import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository.dart';
import '../providers.dart';
import 'accounts_screen.dart';
import 'add_transaction_screen.dart';
import 'paste_sms_sheet.dart';
import 'settings_screen.dart';
import 'shell.dart';
import 'theme.dart';
import 'visuals.dart';
import 'widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider).value ?? const [];
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _BalanceHeader(onSettings: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen()))),
        Transform.translate(
          offset: const Offset(0, -40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _QuickActions(onPayBill: () => onNavigate(4)),
                const SizedBox(height: 22),
                if (accounts.isEmpty)
                  EmptyState(
                    icon: Icons.account_balance_wallet_rounded,
                    title: 'Add your first account',
                    message: 'Start with the MoMo wallet or bank account you use most. You can add the rest any time.',
                    action: FilledButton(onPressed: () => showAddAccountSheet(context), child: const Text('Add account')),
                  )
                else ...[
                  const _DraftsCard(),
                  const _SpendingCard(),
                  const SizedBox(height: 22),
                  SectionTitle('Accounts', trailing: TextButton(onPressed: () => onNavigate(2), child: const Text('See all'))),
                  const SizedBox(height: 8),
                  _AccountStrip(accounts: accounts),
                  const SizedBox(height: 22),
                  _ComingUp(onOpenPlan: () => onNavigate(4)),
                ],
                const SizedBox(height: navClearance - 40),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BalanceHeader extends ConsumerWidget {
  const _BalanceHeader({required this.onSettings});

  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final worth = ref.watch(netWorthProvider).value;
    final month = ref.watch(summaryProvider(DateRange.month(DateTime.now()))).value;
    final top = MediaQuery.paddingOf(context).top;
    return Container(
      decoration: const BoxDecoration(color: AppColors.forest, borderRadius: BorderRadius.vertical(bottom: Radius.circular(36))),
      padding: EdgeInsets.only(top: top),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KenteStrip(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
                    child: const Icon(Icons.home_rounded, color: Color(0xFF3A2A00)),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Akwaaba', style: TextStyle(color: AppColors.mintText, fontSize: 13, fontWeight: FontWeight.w500)),
                      Text('Our household', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                    ]),
                  ),
                  IconButton(
                    tooltip: 'Settings',
                    onPressed: onSettings,
                    style: IconButton.styleFrom(backgroundColor: AppColors.forestTile, fixedSize: const Size(44, 44)),
                    icon: const Icon(Icons.tune_rounded, color: Colors.white, size: 20),
                  ),
                ]),
                const SizedBox(height: 22),
                Text('Total balance · ${worth?.accountCount ?? 0} accounts',
                    style: const TextStyle(color: AppColors.mintText, fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(text: 'GHS ', style: AppFonts.display(size: 22, weight: FontWeight.w700, color: AppColors.mintText)),
                    TextSpan(text: amountText(worth?.total ?? 0), style: AppFonts.display(size: 42, color: Colors.white)),
                  ]),
                ),
                if (worth != null && worth.missingRates.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text('Add a rate for ${worth.missingRates.join(', ')} in Settings to include it',
                      style: const TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w700)),
                ],
                if (month != null && month.income + month.expense > 0) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: AppColors.forestTile, borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      month.kept >= 0 ? 'You kept GHS ${amountText(month.kept)} this month' : 'GHS ${amountText(month.kept)} more out than in this month',
                      style: const TextStyle(color: AppColors.mint, fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
                const SizedBox(height: 22),
                Row(children: [
                  Expanded(child: _FlowTile(label: 'In · this month', amount: month?.income ?? 0, incoming: true)),
                  const SizedBox(width: 10),
                  Expanded(child: _FlowTile(label: 'Out · this month', amount: month?.expense ?? 0, incoming: false)),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowTile extends StatelessWidget {
  const _FlowTile({required this.label, required this.amount, required this.incoming});

  final String label;
  final int amount;
  final bool incoming;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(color: AppColors.forestTile, borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: incoming ? AppColors.mint : const Color(0xFFF7D9D2), shape: BoxShape.circle),
            child: Icon(incoming ? Icons.north_rounded : Icons.south_rounded, size: 16, color: incoming ? AppColors.forest : const Color(0xFF7A2414)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label, style: const TextStyle(color: AppColors.mintText, fontSize: 11, fontWeight: FontWeight.w600)),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(amountText(amount), style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
              ),
            ]),
          ),
        ]),
      );
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.onPayBill});

  final VoidCallback onPayBill;

  @override
  Widget build(BuildContext context) {
    Widget action(IconData icon, String label, Color bg, Color fg, VoidCallback onTap) => Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
                  child: Icon(icon, color: fg, size: 22),
                ),
                const SizedBox(height: 8),
                Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              ]),
            ),
          ),
        );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x0F0F1E18), blurRadius: 2, offset: Offset(0, 1)),
          BoxShadow(color: Color(0x1A0F1E18), blurRadius: 28, offset: Offset(0, 10)),
        ],
      ),
      child: Row(children: [
        action(Icons.add_rounded, 'Add', AppColors.forest, Colors.white, () => openAddTransaction(context)),
        action(Icons.swap_horiz_rounded, 'Transfer', const Color(0xFFE4F2EA), AppColors.green,
            () => openAddTransaction(context, type: TxnKind.transfer)),
        action(Icons.sms_rounded, 'Paste SMS', AppColors.goldSoft, const Color(0xFF7A5200), () => showPasteSmsSheet(context)),
        action(Icons.receipt_long_rounded, 'Pay bill', const Color(0xFFE6ECFD), const Color(0xFF2C4FB8), onPayBill),
      ]),
    );
  }
}

class _DraftsCard extends ConsumerWidget {
  const _DraftsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drafts = ref.watch(draftsProvider).value ?? const [];
    final main = drafts.where((d) => d.txn.feeOfId == null).toList();
    if (main.isEmpty) return const SizedBox.shrink();
    final d = main.first;
    final fee = d.fee;
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: SectionCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SectionTitle('Caught from SMS', trailing: Tag('${main.length} to confirm')),
          const SizedBox(height: 14),
          Row(children: [
            AccountMonogram(d.account, size: 46),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(d.txn.payee ?? (d.txn.type == 'income' ? 'Money received' : 'Payment'),
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text('${d.account.name} · ${friendlyDay(d.txn.date)}${fee > 0 ? ' · fee ${amountText(fee)}' : ''}',
                    style: const TextStyle(fontSize: 12, color: AppColors.muted)),
              ]),
            ),
            Text(signedAmount(d.txn.amount, incoming: d.txn.type == 'income'), style: AppFonts.display(size: 17, weight: FontWeight.w700)),
          ]),
          const SizedBox(height: 14),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => openAddTransaction(context, editDraft: d),
                child: const Text('Edit'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: () => ref.read(repositoryProvider).confirmDraft(d.txn.id),
                child: Text(d.category == null ? 'Confirm' : 'Confirm · ${d.category!.name}'),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}

class _SpendingCard extends ConsumerWidget {
  const _SpendingCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spend = ref.watch(spendByCategoryProvider((range: DateRange.month(DateTime.now()), memberId: null))).value ?? const [];
    final total = spend.fold(0, (s, e) => s + e.amount);
    final top = spend.take(4).toList();
    final other = spend.skip(4).fold(0, (s, e) => s + e.amount);
    final rows = [
      for (final s in top) (s.category?.name ?? 'Uncategorised', s.amount, CategoryVisual.of(s.category?.iconKey).chart),
      if (other > 0) ('Other', other, const Color(0xFFC9D1CB)),
    ];
    return SectionCard(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SectionTitle('Where it went', trailing: Text('This month', style: TextStyle(fontSize: 12, color: AppColors.muted, fontWeight: FontWeight.w600))),
        const SizedBox(height: 14),
        if (total == 0)
          const Text('No spending recorded this month yet.', style: TextStyle(color: AppColors.muted))
        else
          Row(children: [
            DonutChart(
              segments: [for (final r in rows) DonutSegment(r.$2.toDouble(), r.$3)],
              semanticLabel: 'Spending this month: ${rows.map((r) => '${r.$1} ${amountText(r.$2, whole: true)}').join(', ')}',
              center: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('Spent', style: TextStyle(fontSize: 11, color: AppColors.muted, fontWeight: FontWeight.w600)),
                Text(amountText(total, whole: true), style: AppFonts.display(size: 18)),
              ]),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(children: [
                for (final r in rows)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.5),
                    child: Row(children: [
                      Container(width: 10, height: 10, decoration: BoxDecoration(color: r.$3, borderRadius: BorderRadius.circular(3))),
                      const SizedBox(width: 8),
                      Expanded(child: Text(r.$1, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
                      Text(amountText(r.$2, whole: true), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                    ]),
                  ),
              ]),
            ),
          ]),
      ]),
    );
  }
}

class _AccountStrip extends StatelessWidget {
  const _AccountStrip({required this.accounts});

  final List<AccountBalance> accounts;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 116,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          itemCount: accounts.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, i) {
            final a = accounts[i];
            final v = AccountVisual.of(a.account);
            return GestureDetector(
              onTap: () => openAccountDetail(context, a.account),
              child: Container(
                width: 150,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: v.background, borderRadius: BorderRadius.circular(22)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(a.account.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppFonts.display(size: 15, color: v.foreground)),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(a.account.currency, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: v.subtle)),
                    FittedBox(fit: BoxFit.scaleDown, child: Text(amountText(a.balance), style: AppFonts.display(size: 20, color: v.foreground))),
                  ]),
                ]),
              ),
            );
          },
        ),
      );
}

class _ComingUp extends ConsumerWidget {
  const _ComingUp({required this.onOpenPlan});

  final VoidCallback onOpenPlan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soon = DateTime.now().add(const Duration(days: 14));
    final policies = (ref.watch(policiesProvider).value ?? const []).where((p) => p.policy.nextDueDate.isBefore(soon)).toList();
    if (policies.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SectionTitle('Coming up'),
      const SizedBox(height: 12),
      SectionCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(children: [
          for (var i = 0; i < policies.length; i++)
            InkWell(
              onTap: onOpenPlan,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < policies.length - 1 ? const Border(bottom: BorderSide(color: AppColors.line)) : null),
                child: Row(children: [
                  DatePill(policies[i].policy.nextDueDate),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(policyTitle(policies[i]), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 3),
                      Text('${frequencyLabel(policies[i].policy.frequency)} · ${policies[i].providerLabel}',
                          style: const TextStyle(fontSize: 12, color: AppColors.muted)),
                    ]),
                  ),
                  Text(amountText(policies[i].policy.premium), style: AppFonts.display(size: 16, weight: FontWeight.w700)),
                ]),
              ),
            ),
        ]),
      ),
    ]);
  }
}

String policyTitle(PolicyView p) => switch (p.policy.type) {
      'life' => 'Life policy',
      'health' => 'Health insurance',
      'motor' => 'Motor insurance',
      'education' => 'Education plan',
      'funeral' => 'Funeral policy',
      'pension' => 'Pension',
      _ => 'Policy',
    };

String frequencyLabel(String f) => switch (f) {
      'quarterly' => 'Quarterly',
      'termly' => 'Termly',
      'yearly' => 'Yearly',
      _ => 'Monthly',
    };
