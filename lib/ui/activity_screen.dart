import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../core/money.dart';
import '../data/repository.dart';
import '../providers.dart';
import 'add_transaction_screen.dart';
import 'shell.dart';
import 'theme.dart';
import 'widgets.dart';

enum _Filter { all, spent, received, transfers, member }

class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key});

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  _Filter _filter = _Filter.all;
  String? _memberId;
  String _query = '';

  bool _keep(TxnView t) {
    final ok = switch (_filter) {
      _Filter.all => true,
      _Filter.spent => t.txn.type == 'expense',
      _Filter.received => t.txn.type == 'income',
      _Filter.transfers => t.isTransfer,
      _Filter.member => t.member?.id == _memberId,
    };
    if (!ok) return false;
    if (_query.isEmpty) return true;
    final q = _query.toLowerCase();
    return [t.txn.payee, t.txn.note, t.categoryLabel, t.account.name, amountText(t.txn.amount)]
        .whereType<String>()
        .any((s) => s.toLowerCase().contains(q));
  }

  @override
  Widget build(BuildContext context) {
    final drafts = ref.watch(draftsProvider).value ?? const <TxnView>[];
    final posted = ref.watch(transactionsProvider((accountId: null, memberId: null, limit: null))).value ?? const <TxnView>[];
    final members = ref.watch(membersProvider).value ?? const [];
    final month = ref.watch(summaryProvider(DateRange.month(DateTime.now()))).value;
    final all = [...drafts.where((d) => d.txn.feeOfId == null), ...posted].where(_keep).toList();

    final groups = <String, List<TxnView>>{};
    for (final t in all) {
      groups.putIfAbsent(friendlyDay(t.txn.date), () => []).add(t);
    }

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, navClearance),
        children: [
          ScreenTitle('Activity',
              action: IconButton.filled(
                tooltip: 'Add transaction',
                onPressed: () => openAddTransaction(context),
                style: IconButton.styleFrom(backgroundColor: AppColors.forest, fixedSize: const Size(44, 44), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                icon: const Icon(Icons.add_rounded, color: Colors.white),
              )),
          const SizedBox(height: 16),
          TextField(
            onChanged: (v) => setState(() => _query = v.trim()),
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Search payee, note or amount'),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 40,
            child: ListView(scrollDirection: Axis.horizontal, clipBehavior: Clip.none, children: [
              for (final (f, label) in const [(_Filter.all, 'All'), (_Filter.spent, 'Spent'), (_Filter.received, 'Received'), (_Filter.transfers, 'Transfers')])
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChipPill(label: label, selected: _filter == f, onTap: () => setState(() => _filter = f)),
                ),
              for (final m in members)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChipPill(
                    label: m.name,
                    selected: _filter == _Filter.member && _memberId == m.id,
                    onTap: () => setState(() {
                      _filter = _Filter.member;
                      _memberId = m.id;
                    }),
                  ),
                ),
            ]),
          ),
          const SizedBox(height: 14),
          if (month != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(color: AppColors.forest, borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(DateFormat('MMMM').format(DateTime.now()), style: const TextStyle(fontSize: 12, color: AppColors.mintText, fontWeight: FontWeight.w600)),
                    Text('Kept ${amountText(month.kept)}', style: AppFonts.display(size: 18, weight: FontWeight.w700, color: Colors.white)),
                  ]),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('+${amountText(month.income)}', style: const TextStyle(color: AppColors.mint, fontWeight: FontWeight.w700, fontSize: 13)),
                  Text('−${amountText(month.expense)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                ]),
              ]),
            ),
          const SizedBox(height: 18),
          if (all.isEmpty)
            EmptyState(
              icon: Icons.receipt_long_rounded,
              title: _query.isEmpty && _filter == _Filter.all ? 'No transactions yet' : 'Nothing matches',
              message: _query.isEmpty && _filter == _Filter.all ? 'Tap + to record one, or paste a MoMo SMS from Home.' : 'Try another filter or search.',
            ),
          for (final e in groups.entries) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(e.key.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.9, color: AppColors.muted)),
            ),
            SectionCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Column(children: [for (var i = 0; i < e.value.length; i++) TxnRow(e.value[i], divider: i < e.value.length - 1)]),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class TxnRow extends ConsumerWidget {
  const TxnRow(this.t, {super.key, this.divider = false, this.perspectiveAccountId});

  final TxnView t;
  final bool divider;

  /// On an account page a transfer reads as in or out for that account.
  final String? perspectiveAccountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txn = t.txn;
    final incoming = txn.type == 'income' || txn.type == 'transfer_in';
    final title = t.isTransfer
        ? '${txn.type == 'transfer_out' ? t.account.name : (t.counterpartAccount?.name ?? 'Account')} → ${txn.type == 'transfer_out' ? (t.counterpartAccount?.name ?? 'Account') : t.account.name}'
        : (txn.payee ?? t.category?.name ?? (incoming ? 'Money in' : 'Payment'));
    final feeNote = t.fee > 0 ? ' · fee ${amountText(t.fee)}' : '';
    final meta = t.isTransfer ? 'Transfer$feeNote' : '${t.categoryLabel} · ${t.account.name}$feeNote';
    final amount = t.isTransfer && perspectiveAccountId == null ? amountText(txn.amount) : signedAmount(txn.amount, incoming: incoming);
    final color = t.isTransfer && perspectiveAccountId == null ? AppColors.muted : (incoming ? AppColors.green : AppColors.ink);
    return InkWell(
      onTap: () => _showDetails(context, ref),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(border: divider ? const Border(bottom: BorderSide(color: AppColors.line)) : null),
        child: Row(children: [
          CategoryIcon(t.iconKey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              const SizedBox(height: 3),
              Text(meta, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: AppColors.muted)),
            ]),
          ),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(amount, style: AppFonts.display(size: 16, weight: FontWeight.w700, color: color)),
            if (txn.status == 'draft') ...[const SizedBox(height: 4), const Tag('CONFIRM')],
            if (t.member != null) ...[
              const SizedBox(height: 4),
              Tag(t.member!.name.toUpperCase(), background: const Color(0xFFE6ECFD), foreground: const Color(0xFF1F3B8C)),
            ],
          ]),
        ]),
      ),
    );
  }

  void _showDetails(BuildContext context, WidgetRef ref) {
    final txn = t.txn;
    showModalBottomSheet(
      context: context,
      builder: (sheet) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            CategoryIcon(t.iconKey, size: 48),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(Money.format(txn.amount, currency: t.account.currency), style: AppFonts.display(size: 26)),
                Text(t.categoryLabel, style: const TextStyle(color: AppColors.muted, fontWeight: FontWeight.w600)),
              ]),
            ),
          ]),
          const SizedBox(height: 16),
          _detail('Account', t.isTransfer ? '${t.account.name} → ${t.counterpartAccount?.name ?? ''}' : t.account.name),
          _detail('Date', DateFormat('EEE d MMM yyyy, HH:mm').format(txn.date)),
          if (t.fee > 0) _detail('Fee', '${amountText(t.fee)} (counted as Fees and charges)'),
          if (txn.payee != null) _detail(txn.type == 'income' ? 'From' : 'Paid to', txn.payee!),
          if (t.member != null) _detail('For', t.member!.name),
          if (txn.note != null) _detail('Note', txn.note!),
          _detail('Source', switch (txn.source) { 'sms' => 'SMS', 'import' => 'Import', _ => 'Entered by hand' }),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  final ok = await showDialog<bool>(
                    context: sheet,
                    builder: (d) => AlertDialog(
                      title: const Text('Delete this transaction?'),
                      content: Text(t.isTransfer ? 'Both sides of the transfer and any fee are removed.' : 'Any fee recorded with it is removed too.'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Keep')),
                        FilledButton(onPressed: () => Navigator.pop(d, true), style: FilledButton.styleFrom(backgroundColor: const Color(0xFF9A2A17)), child: const Text('Delete')),
                      ],
                    ),
                  );
                  if (ok == true) {
                    await ref.read(repositoryProvider).deleteTransaction(txn.id);
                    if (sheet.mounted) Navigator.pop(sheet);
                  }
                },
                icon: const Icon(Icons.delete_outline_rounded),
                label: const Text('Delete'),
              ),
            ),
            if (txn.status == 'draft' || !t.isTransfer) ...[
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheet);
                    if (txn.status == 'draft') {
                      openAddTransaction(context, editDraft: t);
                    } else {
                      _pickCategory(context, ref);
                    }
                  },
                  icon: Icon(txn.status == 'draft' ? Icons.check_rounded : Icons.edit_rounded),
                  label: Text(txn.status == 'draft' ? 'Review' : 'Change'),
                ),
              ),
            ],
          ]),
        ]),
      ),
    );
  }

  void _pickCategory(BuildContext context, WidgetRef ref) {
    final cats = (ref.read(categoriesProvider).value ?? const []).where((c) => c.kind == (t.txn.type == 'income' ? 'income' : 'expense')).toList();
    final members = ref.read(membersProvider).value ?? const [];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheet) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        builder: (_, controller) => ListView(controller: controller, padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), children: [
          Text('Change', style: AppFonts.display(size: 22)),
          if (t.txn.type == 'expense' && members.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(spacing: 8, children: [
              ChoiceChipPill(label: 'Household', dark: false, selected: t.member == null, onTap: () {
                ref.read(repositoryProvider).updateTransaction(t.txn.id, clearMember: true);
                Navigator.pop(sheet);
              }),
              for (final m in members)
                ChoiceChipPill(label: m.name, dark: false, selected: t.member?.id == m.id, onTap: () {
                  ref.read(repositoryProvider).updateTransaction(t.txn.id, memberId: m.id);
                  Navigator.pop(sheet);
                }),
            ]),
          ],
          const SizedBox(height: 8),
          for (final c in cats)
            ListTile(
              contentPadding: EdgeInsets.only(left: c.parentId == null ? 0 : 28),
              leading: c.parentId == null ? CategoryIcon(c.iconKey, size: 34) : null,
              title: Text(c.name, style: TextStyle(fontWeight: c.parentId == null ? FontWeight.w700 : FontWeight.w500)),
              trailing: c.id == t.txn.categoryId ? const Icon(Icons.check_rounded, color: AppColors.green) : null,
              onTap: () {
                ref.read(repositoryProvider).updateTransaction(t.txn.id, categoryId: c.id);
                Navigator.pop(sheet);
              },
            ),
        ]),
      ),
    );
  }

  static Widget _detail(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: 90, child: Text(label, style: const TextStyle(color: AppColors.muted, fontWeight: FontWeight.w600))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w700))),
        ]),
      );
}
