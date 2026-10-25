import 'package:intl/intl.dart';

/// Amounts are stored as integer minor units (pesewas for GHS, cents for USD)
/// so sums never pick up floating-point rounding errors.
class Money {
  Money._();

  static final _format = NumberFormat('#,##0.00', 'en_US');

  /// 4550 -> "GHS 45.50"; negative values keep their sign in front.
  static String format(int minor, {String currency = 'GHS'}) {
    final sign = minor < 0 ? '-' : '';
    return '$sign$currency ${_format.format(minor.abs() / 100)}';
  }

  /// Parses user or SMS text such as "1,250.30", "45", "GHS 0.5" into minor
  /// units. Returns null when no number is present.
  static int? parse(String input) {
    final match = RegExp(r'-?\d[\d,]*(?:\.\d{1,2})?').firstMatch(input);
    if (match == null) return null;
    final raw = match.group(0)!.replaceAll(',', '');
    final negative = raw.startsWith('-');
    final parts = raw.replaceFirst('-', '').split('.');
    final whole = int.parse(parts[0]);
    final fraction = parts.length > 1 ? int.parse(parts[1].padRight(2, '0')) : 0;
    final value = whole * 100 + fraction;
    return negative ? -value : value;
  }
}

/// Currencies the app offers for accounts. GHS is the household base currency.
const supportedCurrencies = ['GHS', 'USD', 'GBP', 'EUR', 'NGN', 'CAD', 'ZAR', 'CNY'];
