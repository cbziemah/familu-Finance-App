import '../core/money.dart';
import '../data/provider_registry.dart';

enum SmsDirection { debit, credit }

/// The fields pulled out of one MoMo or bank message. Amounts are minor units.
class ParsedSms {
  const ParsedSms({
    required this.direction,
    required this.amount,
    this.providerId,
    this.currency = 'GHS',
    this.fee = 0,
    this.tax = 0,
    this.balance,
    this.counterparty,
    this.reference,
    this.matchedTemplate = false,
  });

  final SmsDirection direction;
  final int amount;
  final String? providerId;
  final String currency;
  final int fee;

  /// E-levy or other tax charged on the transaction.
  final int tax;

  /// The balance the provider reports after this transaction.
  final int? balance;
  final String? counterparty;
  final String? reference;

  /// False when only the generic fallback parser understood the message.
  final bool matchedTemplate;

  int get totalCharges => fee + tax;
}

/// One message shape for one provider. [pattern] uses named groups:
/// amount (required), and optionally fee, tax, balance, party, ref.
class SmsRule {
  const SmsRule(this.direction, this.pattern);

  final SmsDirection direction;
  final String pattern;
}

class SmsTemplate {
  const SmsTemplate(this.providerId, this.rules);

  final String providerId;
  final List<SmsRule> rules;
}

const _amt = r'(?:GHS|GH₵|GHC|GH¢|GH)\s?';
const _num = r'[\d,]+(?:\.\d{1,2})?';

/// Message templates per provider. These patterns are written from typical
/// message shapes and MUST be checked against real messages from each
/// provider; they live as data so a new or changed format is a data update.
const smsTemplates = <SmsTemplate>[
  SmsTemplate('mtn_momo', [
    SmsRule(SmsDirection.debit,
        '(?:Payment made for|You have sent|Transfer of|Cash Out made for)\\s*$_amt(?<amount>$_num)\\s*(?:to\\s+(?<party>[^.]+?))?\\s*[.,]'),
    SmsRule(SmsDirection.credit,
        '(?:Payment received for|You have received|Cash In received for)\\s*$_amt(?<amount>$_num)\\s*(?:from\\s+(?<party>[^.]+?))?\\s*[.,]'),
  ]),
  SmsTemplate('telecel_cash', [
    SmsRule(SmsDirection.debit, '$_amt(?<amount>$_num)\\s*(?:sent|paid)\\s+to\\s+(?<party>.+?)\\s+on\\b'),
    SmsRule(SmsDirection.credit, '(?:received|You have received)\\s*$_amt(?<amount>$_num)\\s*from\\s+(?<party>.+?)\\s+on\\b'),
  ]),
  SmsTemplate('at_money', [
    SmsRule(SmsDirection.debit, 'You have (?:sent|paid)\\s*$_amt(?<amount>$_num)\\s*to\\s+(?<party>[^.]+?)\\.'),
    SmsRule(SmsDirection.credit, 'You have received\\s*$_amt(?<amount>$_num)\\s*from\\s+(?<party>[^.]+?)\\.'),
  ]),
];

class SmsParser {
  const SmsParser({this.templates = smsTemplates, this.providers = providerSeeds});

  final List<SmsTemplate> templates;
  final List<ProviderSeed> providers;

  /// Which provider sent this message, by sender ID. Null for unknown senders.
  String? providerForSender(String sender) {
    final s = sender.toLowerCase().replaceAll(RegExp(r'[\s_-]'), '');
    for (final p in providers) {
      for (final id in p.smsSenders) {
        if (s == id.toLowerCase().replaceAll(RegExp(r'[\s_-]'), '')) return p.id;
      }
    }
    return null;
  }

  /// Returns null when the message is not a money movement (promos, OTPs).
  ParsedSms? parse(String body, {String? sender}) {
    final providerId = sender == null ? null : providerForSender(sender);
    final text = body.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (_looksLikeNoise(text)) return null;

    final shared = _extractShared(text);
    for (final template in templates.where((t) => providerId == null || t.providerId == providerId)) {
      for (final rule in template.rules) {
        final m = RegExp(rule.pattern, caseSensitive: false).firstMatch(text);
        if (m == null) continue;
        final amount = Money.parse(m.namedGroup('amount')!);
        if (amount == null || amount == 0) continue;
        return ParsedSms(
          direction: rule.direction,
          amount: amount,
          providerId: template.providerId,
          fee: shared.fee,
          tax: shared.tax,
          balance: shared.balance,
          counterparty: _clean(_group(m, 'party')),
          reference: shared.reference,
          matchedTemplate: true,
        );
      }
    }
    return _generic(text, providerId, shared);
  }

  ParsedSms? _generic(String text, String? providerId, _Shared shared) {
    final lower = text.toLowerCase();
    final debit = RegExp(r'\b(debited|sent|paid|payment made|withdraw\w*|cash out|purchase)\b').hasMatch(lower);
    final credit = RegExp(r'\b(credited|received|deposit\w*|cash in)\b').hasMatch(lower);
    if (debit == credit) return null;

    final currencyMatch = RegExp('(GHS|GH₵|GHC|GH¢|USD|US\\\$|GBP|EUR)\\s?($_num)', caseSensitive: false).firstMatch(text);
    if (currencyMatch == null) return null;
    final amount = Money.parse(currencyMatch.group(2)!);
    if (amount == null || amount == 0) return null;
    final code = currencyMatch.group(1)!.toUpperCase();
    final currency = code.startsWith('US') ? 'USD' : (code == 'GBP' || code == 'EUR' ? code : 'GHS');

    final party = RegExp(debit ? r'\bto\s+([A-Z0-9][^.,]{1,40}?)(?=\s+(?:on|at|ref|current|your|with)\b|[.,]|$)' : r'\bfrom\s+([A-Z0-9][^.,]{1,40}?)(?=\s+(?:on|at|ref|current|your|with)\b|[.,]|$)',
            caseSensitive: false)
        .firstMatch(text);
    return ParsedSms(
      direction: debit ? SmsDirection.debit : SmsDirection.credit,
      amount: amount,
      providerId: providerId,
      currency: currency,
      fee: shared.fee,
      tax: shared.tax,
      balance: shared.balance,
      counterparty: _clean(party?.group(1)),
      reference: shared.reference,
    );
  }

  _Shared _extractShared(String text) {
    int? find(String pattern) {
      final m = RegExp(pattern, caseSensitive: false).firstMatch(text);
      return m == null ? null : Money.parse(m.group(1)!);
    }

    // A transaction ID wins over a free-text "Reference: rent"; a reference
    // only counts when it contains a digit.
    final ref = RegExp(r'(?:Financial Transaction Id|Transaction ID|Trans(?:action)? ?ID)[:.\s]*([A-Za-z0-9-]{4,})', caseSensitive: false)
            .firstMatch(text) ??
        RegExp(r'\bRef(?:erence)?(?: No)?[:.\s]*([A-Za-z-]*\d[A-Za-z0-9-]*)', caseSensitive: false).firstMatch(text);
    return _Shared(
      fee: find('Fee(?: charged)?[:\\s]*(?:$_amt)?($_num)') ?? 0,
      tax: find('(?:E-?levy|TAX(?: charged)?)[:\\s]*(?:$_amt)?($_num)') ?? 0,
      balance: find('(?:New |Current |Available |Avail\\.? )?Bal(?:ance)?(?: is)?[:\\s]*(?:$_amt)?($_num)'),
      reference: ref?.group(1),
    );
  }

  static bool _looksLikeNoise(String text) =>
      RegExp(r'\b(OTP|verification code|one[- ]time password|promo|win up to|dial \*)', caseSensitive: false).hasMatch(text) &&
      !RegExp(r'\b(debited|credited|payment|received|sent)\b', caseSensitive: false).hasMatch(text);

  static String? _group(RegExpMatch m, String name) => m.groupNames.contains(name) ? m.namedGroup(name) : null;

  static String? _clean(String? s) {
    final v = s?.trim().replaceAll(RegExp(r'\s+'), ' ');
    return (v == null || v.isEmpty) ? null : v;
  }
}

class _Shared {
  const _Shared({required this.fee, required this.tax, this.balance, this.reference});

  final int fee;
  final int tax;
  final int? balance;
  final String? reference;
}
