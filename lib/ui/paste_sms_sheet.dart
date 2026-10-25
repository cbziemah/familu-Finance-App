import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/money.dart';
import '../data/repository.dart';
import '../providers.dart';
import '../sms/sms_parser.dart';
import 'theme.dart';
import 'widgets.dart';

/// Paste a MoMo or bank SMS; the app reads it and saves a draft to confirm.
/// This is the iPhone path and the fallback until automatic SMS capture is
/// switched on for Android.
Future<void> showPasteSmsSheet(BuildContext context) =>
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => const _PasteSmsSheet());

class _PasteSmsSheet extends ConsumerStatefulWidget {
  const _PasteSmsSheet();

  @override
  ConsumerState<_PasteSmsSheet> createState() => _PasteSmsSheetState();
}

class _PasteSmsSheetState extends ConsumerState<_PasteSmsSheet> {
  final _text = TextEditingController();
  ParsedSms? _parsed;
  String? _accountId;
  bool _tried = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null) {
      _text.text = data!.text!;
      _read();
    }
  }

  void _read() {
    final parsed = ref.read(smsParserProvider).parse(_text.text);
    final accounts = ref.read(accountsProvider).value ?? const <AccountBalance>[];
    setState(() {
      _tried = true;
      _parsed = parsed;
      if (parsed?.providerId != null) {
        _accountId = accounts.where((a) => a.account.providerId == parsed!.providerId).firstOrNull?.account.id ?? _accountId;
      }
      _accountId ??= accounts.firstOrNull?.account.id;
    });
  }

  Future<void> _save() async {
    final p = _parsed!;
    final repo = ref.read(repositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    final now = DateTime.now();
    if (await repo.isDuplicateSms(accountId: _accountId!, amount: p.amount, date: now, smsRef: p.reference)) {
      messenger.showSnackBar(const SnackBar(content: Text('This message looks like one you already added')));
      return;
    }
    await repo.addTransaction(
      type: p.direction == SmsDirection.credit ? 'income' : 'expense',
      amount: p.amount,
      accountId: _accountId!,
      date: now,
      payee: p.counterparty,
      fee: p.direction == SmsDirection.debit ? p.totalCharges : 0,
      source: 'sms',
      status: 'draft',
      smsRef: p.reference,
    );
    if (mounted) Navigator.pop(context);
    messenger.showSnackBar(const SnackBar(content: Text('Saved. Confirm it on Home when you are ready.')));
  }

  @override
  Widget build(BuildContext context) {
    final accounts = ref.watch(accountsProvider).value ?? const <AccountBalance>[];
    final p = _parsed;
    final account = accounts.where((a) => a.account.id == _accountId).firstOrNull;
    int? gap;
    if (p?.balance != null && account != null) {
      final after = account.balance + (p!.direction == SmsDirection.credit ? p.amount : -(p.amount + p.totalCharges));
      gap = p.balance! - after;
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.viewInsetsOf(context).bottom + 20),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Add from SMS', style: AppFonts.display(size: 24)),
          const SizedBox(height: 4),
          const Text('Copy a MoMo or bank message and paste it here. Nothing leaves your phone.', style: TextStyle(color: AppColors.muted)),
          const SizedBox(height: 14),
          TextField(
            controller: _text,
            minLines: 3,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: 'Payment made for GHS 85.00 to …',
              suffixIcon: IconButton(tooltip: 'Paste', icon: const Icon(Icons.content_paste_rounded), onPressed: _pasteFromClipboard),
            ),
            onChanged: (_) => setState(() => _tried = false),
          ),
          const SizedBox(height: 10),
          OutlinedButton(onPressed: _text.text.trim().isEmpty ? null : _read, child: const Text('Read message')),
          if (_tried && p == null) ...[
            const SizedBox(height: 12),
            const Text('Could not find a payment in this message. You can still add it by hand.', style: TextStyle(color: AppColors.goldText, fontWeight: FontWeight.w700)),
          ],
          if (p != null) ...[
            const SizedBox(height: 16),
            SectionCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  '${p.direction == SmsDirection.credit ? '+' : '−'}${Money.format(p.amount, currency: p.currency)}',
                  style: AppFonts.display(size: 26, color: p.direction == SmsDirection.credit ? AppColors.green : AppColors.ink),
                ),
                const SizedBox(height: 6),
                if (p.counterparty != null) Text('${p.direction == SmsDirection.credit ? 'From' : 'To'} ${p.counterparty}', style: const TextStyle(fontWeight: FontWeight.w700)),
                if (p.totalCharges > 0) Text('Fee and tax ${amountText(p.totalCharges)}, saved as its own line', style: const TextStyle(color: AppColors.muted)),
                if (p.reference != null) Text('Ref ${p.reference}', style: const TextStyle(color: AppColors.muted)),
                if (!p.matchedTemplate) const Text('Read with the general reader: check the details.', style: TextStyle(color: AppColors.goldText, fontWeight: FontWeight.w600)),
              ]),
            ),
            const SizedBox(height: 12),
            const Text('Which account?', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.muted)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final a in accounts) ChoiceChipPill(label: a.account.name, dark: false, selected: a.account.id == _accountId, onTap: () => setState(() => _accountId = a.account.id)),
            ]),
            if (gap != null && gap != 0) ...[
              const SizedBox(height: 10),
              Text(
                'The message says your balance is ${amountText(p.balance!)}, ${amountText(gap.abs())} ${gap > 0 ? 'more' : 'less'} than the app expects. A transaction may be missing.',
                style: const TextStyle(color: AppColors.goldText, fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ],
            const SizedBox(height: 16),
            FilledButton(onPressed: _accountId == null ? null : _save, child: const Text('Save to confirm later')),
          ],
        ]),
      ),
    );
  }
}
