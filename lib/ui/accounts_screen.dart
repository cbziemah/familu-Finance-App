import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/money.dart';
import '../data/database.dart';
import '../data/repository.dart';
import '../providers.dart';
import 'activity_screen.dart';
import 'add_transaction_screen.dart';
import 'shell.dart';
import 'theme.dart';
import 'visuals.dart';
import 'widgets.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider).value ?? const <AccountBalance>[];
    final rates = ref.watch(ratesProvider).value ?? const {'GHS': 1.0};
    final worth = ref.watch(netWorthProvider).value;

    final groups = <String, int>{};
    for (final a in accounts) {
      final g = switch (a.account.type) {
        'momo' => 'MoMo',
        'cash' => 'Cash',
        'online_wallet' => 'Foreign & online',
        _ => a.account.currency == 'GHS' ? 'Bank' : 'Foreign & online',
      };
      groups[g] = (groups[g] ?? 0) + FinanceRepository.convert(a.balance, a.account.currency, rates).clamp(0, 1 << 52);
    }
    final groupColors = {'Bank': AppColors.ink, 'Foreign & online': const Color(0xFFA6D95A), 'MoMo': const Color(0xFFFFCB05), 'Cash': const Color(0xFFC9D1CB)};
    final groupTotal = groups.values.fold(0, (s, v) => s + v);
    final foreign = rates.entries.where((e) => e.key != 'GHS').toList();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, navClearance),
        children: [
          ScreenTitle('Accounts',
              action: FilledButton.icon(
                onPressed: () => showAddAccountSheet(context),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add'),
                style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
              )),
          const SizedBox(height: 16),
          if (accounts.isEmpty)
            EmptyState(
              icon: Icons.account_balance_rounded,
              title: 'No accounts yet',
              message: 'Add each MoMo wallet, bank account, card, foreign wallet and the cash you keep at home.',
              action: FilledButton(onPressed: () => showAddAccountSheet(context), child: const Text('Add account')),
            )
          else ...[
            SectionCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('All accounts in GHS', style: TextStyle(fontSize: 12, color: AppColors.muted, fontWeight: FontWeight.w600)),
                      Text(amountText(worth?.total ?? 0), style: AppFonts.display(size: 28)),
                    ]),
                  ),
                  if (foreign.isNotEmpty)
                    Text(foreign.map((e) => '${e.key} 1 = GHS ${e.value.toStringAsFixed(2)}').join('\n'),
                        textAlign: TextAlign.right, style: const TextStyle(fontSize: 11, color: AppColors.muted, fontWeight: FontWeight.w600)),
                ]),
                if (groupTotal > 0) ...[
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SizedBox(
                      height: 12,
                      child: Row(children: [
                        for (final e in groups.entries.where((e) => e.value > 0))
                          Expanded(
                            flex: (e.value * 1000 ~/ groupTotal).clamp(1, 1000),
                            child: Container(margin: const EdgeInsets.only(right: 3), color: groupColors[e.key]),
                          ),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(spacing: 12, runSpacing: 6, children: [
                    for (final e in groups.entries.where((e) => e.value > 0))
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: groupColors[e.key], borderRadius: BorderRadius.circular(2))),
                        const SizedBox(width: 5),
                        Text('${e.key} ${(e.value * 100 / groupTotal).round()}%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF3B4A43))),
                      ]),
                  ]),
                ],
                if (worth != null && worth.missingRates.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text('No rate yet for ${worth.missingRates.join(', ')}: add one in Settings.', style: const TextStyle(fontSize: 12, color: AppColors.goldText, fontWeight: FontWeight.w700)),
                ],
              ]),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.25,
              children: [for (final a in accounts) _AccountTile(a, rates: rates)],
            ),
            const SizedBox(height: 16),
            if (accounts.length > 1)
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => openAddTransaction(context, type: TxnKind.transfer),
                  child: const SizedBox(
                    height: 52,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.swap_horiz_rounded, color: AppColors.forest),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text('Move money between accounts',
                            overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.forest)),
                      ),
                    ]),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  const _AccountTile(this.a, {required this.rates});

  final AccountBalance a;
  final Map<String, double> rates;

  @override
  Widget build(BuildContext context) {
    final v = AccountVisual.of(a.account);
    final acc = a.account;
    final foreign = acc.currency != 'GHS';
    final subtitle = foreign
        ? (rates.containsKey(acc.currency) ? '≈ GHS ${amountText(FinanceRepository.convert(a.balance, acc.currency, rates))}' : '${acc.currency} · no rate yet')
        : '${acc.currency} · ${acc.number != null ? '••${acc.number}' : accountTypeLabels[acc.type] ?? ''}';
    return Material(
      color: v.background,
      borderRadius: BorderRadius.circular(22),
      elevation: v.background == Colors.white ? 0.5 : 0,
      shadowColor: const Color(0x220F1E18),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => openAccountDetail(context, acc),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Expanded(child: Text(acc.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppFonts.display(size: 15, color: v.foreground))),
              if (foreign)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: v.foreground, borderRadius: BorderRadius.circular(6)),
                  child: Text(acc.currency, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: v.background)),
                ),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(a.balance < 0 ? '−${amountText(a.balance)}' : amountText(a.balance), style: AppFonts.display(size: 21, color: v.foreground)),
              ),
              Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: v.subtle)),
            ]),
          ]),
        ),
      ),
    );
  }
}

void openAccountDetail(BuildContext context, Account account) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => AccountDetailScreen(accountId: account.id)));

class AccountDetailScreen extends ConsumerWidget {
  const AccountDetailScreen({super.key, required this.accountId});

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = (ref.watch(accountsProvider).value ?? const <AccountBalance>[]).where((a) => a.account.id == accountId).firstOrNull;
    final txns = ref.watch(transactionsProvider((accountId: accountId, memberId: null, limit: null))).value ?? const <TxnView>[];
    if (balance == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final v = AccountVisual.of(balance.account);
    return Scaffold(
      appBar: AppBar(
        title: Text(balance.account.name),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'archive') {
                await ref.read(repositoryProvider).archiveAccount(accountId);
                if (context.mounted) Navigator.of(context).pop();
              }
            },
            itemBuilder: (_) => const [PopupMenuItem(value: 'archive', child: Text('Archive account'))],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.forest,
        foregroundColor: Colors.white,
        onPressed: () => openAddTransaction(context, accountId: accountId),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: v.background, borderRadius: BorderRadius.circular(24), border: v.background == Colors.white ? Border.all(color: AppColors.chip) : null),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(accountTypeLabels[balance.account.type] ?? '', style: TextStyle(color: v.subtle, fontWeight: FontWeight.w700, fontSize: 12)),
              const SizedBox(height: 6),
              Text(Money.format(balance.balance, currency: balance.account.currency), style: AppFonts.display(size: 32, color: v.foreground)),
            ]),
          ),
          const SizedBox(height: 18),
          if (txns.isEmpty)
            const EmptyState(icon: Icons.receipt_long_rounded, title: 'Nothing here yet', message: 'Transactions on this account will show up here.')
          else
            SectionCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Column(children: [for (var i = 0; i < txns.length; i++) TxnRow(txns[i], divider: i < txns.length - 1, perspectiveAccountId: accountId)]),
            ),
        ],
      ),
    );
  }
}

Future<void> showAddAccountSheet(BuildContext context) => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _AddAccountSheet(),
    );

class _AddAccountSheet extends ConsumerStatefulWidget {
  const _AddAccountSheet();

  @override
  ConsumerState<_AddAccountSheet> createState() => _AddAccountSheetState();
}

class _AddAccountSheetState extends ConsumerState<_AddAccountSheet> {
  String _type = 'momo';
  String? _providerId;
  String _currency = 'GHS';
  final _name = TextEditingController();
  final _number = TextEditingController();
  final _opening = TextEditingController();

  static const _providerKinds = {'momo': 'momo', 'bank': 'bank', 'card': 'bank', 'savings': 'bank', 'online_wallet': 'wallet'};

  @override
  void dispose() {
    _name.dispose();
    _number.dispose();
    _opening.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Give the account a name')));
      return;
    }
    await ref.read(repositoryProvider).addAccount(
          name: name,
          type: _type,
          providerId: _providerId,
          number: _number.text.trim().isEmpty ? null : _number.text.trim(),
          currency: _currency,
          openingBalance: Money.parse(_opening.text) ?? 0,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final kind = _providerKinds[_type];
    final providers = kind == null ? const <FinProvider>[] : (ref.watch(financeProvidersProvider(kind)).value ?? const <FinProvider>[]);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.viewInsetsOf(context).bottom + 20),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
          Text('Add account', style: AppFonts.display(size: 24)),
          const SizedBox(height: 16),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final e in accountTypeLabels.entries)
              ChoiceChipPill(
                label: e.value,
                selected: _type == e.key,
                onTap: () => setState(() {
                  _type = e.key;
                  _providerId = null;
                  if (e.key == 'cash' && _name.text.isEmpty) _name.text = 'Cash';
                }),
              ),
          ]),
          const SizedBox(height: 14),
          if (providers.isNotEmpty) ...[
            DropdownButtonFormField<String>(
              initialValue: _providerId,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Provider'),
              items: [for (final p in providers) DropdownMenuItem(value: p.id, child: Text(p.name))],
              onChanged: (id) => setState(() {
                _providerId = id;
                final p = providers.firstWhere((p) => p.id == id);
                _name.text = p.name;
                if (p.kind == 'wallet' && _currency == 'GHS') _currency = 'USD';
              }),
            ),
            const SizedBox(height: 10),
          ],
          TextField(controller: _name, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Name')),
          const SizedBox(height: 10),
          if (_type != 'cash') ...[
            TextField(
              controller: _number,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: _type == 'momo' ? 'Wallet number (optional)' : 'Last 4 digits (optional)'),
            ),
            const SizedBox(height: 10),
          ],
          Row(children: [
            SizedBox(
              width: 110,
              child: DropdownButtonFormField<String>(
                initialValue: _currency,
                decoration: const InputDecoration(labelText: 'Currency'),
                items: [for (final c in supportedCurrencies) DropdownMenuItem(value: c, child: Text(c))],
                onChanged: (c) => setState(() => _currency = c ?? 'GHS'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _opening,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Balance today'),
              ),
            ),
          ]),
          const SizedBox(height: 18),
          FilledButton(onPressed: _save, child: const Text('Save account')),
        ]),
      ),
    );
  }
}
