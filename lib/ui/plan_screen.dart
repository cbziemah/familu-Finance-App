import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../core/money.dart';
import '../data/database.dart';
import '../data/repository.dart';
import '../providers.dart';
import 'home_screen.dart' show frequencyLabel, policyTitle;
import 'shell.dart';
import 'theme.dart';
import 'widgets.dart';

class PlanScreen extends ConsumerWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policies = ref.watch(policiesProvider).value ?? const <PolicyView>[];
    final now = DateTime.now();
    final monthEnd = DateTime(now.year, now.month + 1);
    final perMonth = policies.fold<int>(0, (s, p) => s + p.policy.premium ~/ monthsPerPeriod(p.policy.frequency));
    final dueThisMonth = policies.where((p) => p.policy.frequency == 'monthly').toList();
    final paidThisMonth = dueThisMonth.where((p) => !p.policy.nextDueDate.isBefore(monthEnd)).length;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, navClearance),
        children: [
          ScreenTitle('Plan',
              action: FilledButton.icon(
                onPressed: () => showAddPolicySheet(context),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add'),
                style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
              )),
          const SizedBox(height: 4),
          const Text('Insurance and pensions', style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          if (policies.isEmpty)
            EmptyState(
              icon: Icons.shield_rounded,
              title: 'Add your policies',
              message: 'Life, health, education plans, SSNIT and other pensions. Contributions default to monthly, with a reminder before each due date.',
              action: FilledButton(onPressed: () => showAddPolicySheet(context), child: const Text('Add policy')),
            )
          else ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(color: AppColors.forest, borderRadius: BorderRadius.circular(24)),
              child: Row(children: [
                if (dueThisMonth.isNotEmpty) ...[
                  DonutChart(
                    size: 72,
                    stroke: 8,
                    segments: [
                      DonutSegment(paidThisMonth.toDouble(), AppColors.gold),
                      DonutSegment((dueThisMonth.length - paidThisMonth).toDouble(), AppColors.forestTile),
                    ],
                    semanticLabel: '$paidThisMonth of ${dueThisMonth.length} monthly contributions paid this month',
                    center: Text('$paidThisMonth/${dueThisMonth.length}', style: AppFonts.display(size: 18, color: Colors.white)),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Contributions per month', style: TextStyle(fontSize: 12, color: AppColors.mintText, fontWeight: FontWeight.w600)),
                    FittedBox(fit: BoxFit.scaleDown, child: Text('GHS ${amountText(perMonth)}', style: AppFonts.display(size: 28, color: Colors.white))),
                    if (dueThisMonth.isNotEmpty)
                      Text(
                        paidThisMonth == dueThisMonth.length ? '${DateFormat('MMMM').format(now)}: all paid' : '${DateFormat('MMMM').format(now)}: ${dueThisMonth.length - paidThisMonth} still to pay',
                        style: const TextStyle(fontSize: 12, color: AppColors.mint, fontWeight: FontWeight.w700),
                      ),
                  ]),
                ),
              ]),
            ),
            const SizedBox(height: 14),
            for (final p in policies) ...[_PolicyCard(p), const SizedBox(height: 14)],
          ],
        ],
      ),
    );
  }
}

class _PolicyCard extends StatelessWidget {
  const _PolicyCard(this.p);

  final PolicyView p;

  static const _visuals = {
    'life': (Icons.favorite_rounded, Color(0xFFFBE3E0), Color(0xFF9A2A17)),
    'health': (Icons.local_hospital_rounded, Color(0xFFFDF0D3), Color(0xFF7A5200)),
    'motor': (Icons.directions_car_rounded, Color(0xFFEEE9FE), Color(0xFF4B2FC2)),
    'education': (Icons.school_rounded, Color(0xFFE6ECFD), Color(0xFF1F3B8C)),
    'funeral': (Icons.spa_rounded, Color(0xFFECEFEA), Color(0xFF3B4A43)),
    'pension': (Icons.savings_rounded, Color(0xFFDDF3EB), Color(0xFF0B6B4C)),
  };

  @override
  Widget build(BuildContext context) {
    final policy = p.policy;
    final (icon, bg, fg) = _visuals[policy.type] ?? _visuals['life']!;
    final now = DateTime.now();
    final daysToDue = DateTime(policy.nextDueDate.year, policy.nextDueDate.month, policy.nextDueDate.day).difference(DateTime(now.year, now.month, now.day)).inDays;
    final dueLabel = daysToDue < 0
        ? 'Overdue by ${-daysToDue} day${daysToDue == -1 ? '' : 's'}'
        : daysToDue == 0
            ? 'Due today'
            : daysToDue <= 7
                ? 'Due in $daysToDue day${daysToDue == 1 ? '' : 's'}'
                : 'Next due ${DateFormat('d MMM').format(policy.nextDueDate)}';

    return SectionCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: fg, size: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(policyTitle(p), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              Text('${p.providerLabel} · paid ${amountText(p.paidTotal)} so far', style: const TextStyle(fontSize: 12, color: AppColors.muted)),
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(amountText(policy.premium), style: AppFonts.display(size: 18)),
            Text(frequencyLabel(policy.frequency).toLowerCase(), style: const TextStyle(fontSize: 11, color: AppColors.muted, fontWeight: FontWeight.w600)),
          ]),
        ]),
        const SizedBox(height: 14),
        if (policy.frequency == 'monthly') ...[
          _YearStrip(p, year: now.year),
          const SizedBox(height: 6),
        ],
        Row(children: [
          Text('Jan', style: TextStyle(fontSize: 11, color: AppColors.muted.withValues(alpha: policy.frequency == 'monthly' ? 1 : 0), fontWeight: FontWeight.w700)),
          Expanded(
            child: Text(dueLabel,
                textAlign: policy.frequency == 'monthly' ? TextAlign.center : TextAlign.start,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: daysToDue <= 7 ? AppColors.goldText : AppColors.muted)),
          ),
          Text('Dec', style: TextStyle(fontSize: 11, color: AppColors.muted.withValues(alpha: policy.frequency == 'monthly' ? 1 : 0), fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 14),
        FilledButton(
          onPressed: () => showRecordPremiumSheet(context, p),
          child: Text('Record ${DateFormat('MMMM').format(policy.nextDueDate)} payment'),
        ),
      ]),
    );
  }
}

class _YearStrip extends StatelessWidget {
  const _YearStrip(this.p, {required this.year});

  final PolicyView p;
  final int year;

  @override
  Widget build(BuildContext context) {
    final paid = {for (final d in p.paidDueDates) if (d.year == year) d.month};
    final due = p.policy.nextDueDate;
    final cells = [
      for (var m = 1; m <= 12; m++)
        paid.contains(m)
            ? AppColors.green
            : (due.year == year && due.month == m)
                ? AppColors.gold
                : AppColors.chip,
    ];
    return Semantics(
      label: '$year: ${paid.length} month${paid.length == 1 ? '' : 's'} paid',
      child: Row(children: [
        for (var i = 0; i < 12; i++)
          Expanded(
            child: Container(
              height: 8,
              margin: EdgeInsets.only(right: i < 11 ? 4 : 0),
              decoration: BoxDecoration(color: cells[i], borderRadius: BorderRadius.circular(4)),
            ),
          ),
      ]),
    );
  }
}

Future<void> showRecordPremiumSheet(BuildContext context, PolicyView p) =>
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => _RecordPremiumSheet(p));

class _RecordPremiumSheet extends ConsumerStatefulWidget {
  const _RecordPremiumSheet(this.p);

  final PolicyView p;

  @override
  ConsumerState<_RecordPremiumSheet> createState() => _RecordPremiumSheetState();
}

class _RecordPremiumSheetState extends ConsumerState<_RecordPremiumSheet> {
  String? _accountId;
  late final _amount = TextEditingController(text: (widget.p.policy.premium / 100).toStringAsFixed(2));
  final _fee = TextEditingController();
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _accountId = widget.p.policy.payFromAccountId;
  }

  @override
  void dispose() {
    _amount.dispose();
    _fee.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accounts = ref.watch(accountsProvider).value ?? const <AccountBalance>[];
    _accountId ??= accounts.firstOrNull?.account.id;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.viewInsetsOf(context).bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Record payment', style: AppFonts.display(size: 24)),
        Text('${policyTitle(widget.p)} · due ${DateFormat('d MMM yyyy').format(widget.p.policy.nextDueDate)}', style: const TextStyle(color: AppColors.muted, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        const Text('Paid from', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.muted)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (final a in accounts) ChoiceChipPill(label: a.account.name, dark: false, selected: a.account.id == _accountId, onTap: () => setState(() => _accountId = a.account.id)),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: TextField(controller: _amount, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Amount', prefixText: 'GHS '))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: _fee, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Fee (optional)'))),
        ]),
        const SizedBox(height: 10),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          child: ListTile(
            leading: const Icon(Icons.calendar_today_rounded, size: 20),
            title: Text(friendlyDay(_date), style: const TextStyle(fontWeight: FontWeight.w700)),
            onTap: () async {
              final d = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2015), lastDate: DateTime.now());
              if (d != null) setState(() => _date = d);
            },
          ),
        ),
        const SizedBox(height: 18),
        FilledButton(
          onPressed: _accountId == null
              ? null
              : () async {
                  await ref.read(repositoryProvider).recordPremium(
                        widget.p.policy.id,
                        accountId: _accountId!,
                        amount: Money.parse(_amount.text),
                        fee: Money.parse(_fee.text) ?? 0,
                        date: _date,
                      );
                  if (context.mounted) Navigator.pop(context);
                },
          child: const Text('Save payment'),
        ),
      ]),
    );
  }
}

Future<void> showAddPolicySheet(BuildContext context) => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => const _AddPolicySheet());

class _AddPolicySheet extends ConsumerStatefulWidget {
  const _AddPolicySheet();

  @override
  ConsumerState<_AddPolicySheet> createState() => _AddPolicySheetState();
}

class _AddPolicySheetState extends ConsumerState<_AddPolicySheet> {
  String _type = 'life';
  String? _providerId;
  String _frequency = 'monthly';
  String? _memberId;
  String? _accountId;
  DateTime _due = DateTime.now();
  final _otherName = TextEditingController();
  final _number = TextEditingController();
  final _premium = TextEditingController();

  static const _types = {'life': 'Life', 'health': 'Health', 'education': 'Education', 'motor': 'Motor', 'funeral': 'Funeral', 'pension': 'Pension'};

  @override
  void dispose() {
    _otherName.dispose();
    _number.dispose();
    _premium.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providers = ref.watch(financeProvidersProvider('insurer,pension,health')).value ?? const <FinProvider>[];
    final members = ref.watch(membersProvider).value ?? const <Member>[];
    final accounts = ref.watch(accountsProvider).value ?? const <AccountBalance>[];
    final isOther = _providerId == null || _providerId!.startsWith('other_');
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.viewInsetsOf(context).bottom + 20),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Add policy', style: AppFonts.display(size: 24)),
          const SizedBox(height: 16),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final e in _types.entries) ChoiceChipPill(label: e.value, selected: _type == e.key, onTap: () => setState(() => _type = e.key)),
          ]),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _providerId,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Provider'),
            items: [for (final p in providers) DropdownMenuItem(value: p.id, child: Text(p.name))],
            onChanged: (v) => setState(() => _providerId = v),
          ),
          if (isOther) ...[
            const SizedBox(height: 10),
            TextField(controller: _otherName, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Insurer or trustee name')),
          ],
          const SizedBox(height: 10),
          TextField(controller: _number, decoration: const InputDecoration(labelText: 'Policy number (optional)')),
          const SizedBox(height: 10),
          TextField(controller: _premium, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Contribution', prefixText: 'GHS ')),
          const SizedBox(height: 12),
          Segmented<String>(
            options: const [('monthly', 'Monthly'), ('quarterly', 'Quarterly'), ('termly', 'Termly'), ('yearly', 'Yearly')],
            selected: _frequency,
            onChanged: (f) => setState(() => _frequency = f),
          ),
          const SizedBox(height: 10),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            child: ListTile(
              leading: const Icon(Icons.event_rounded, size: 20),
              title: Text('Next due ${DateFormat('d MMM yyyy').format(_due)}', style: const TextStyle(fontWeight: FontWeight.w700)),
              onTap: () async {
                final d = await showDatePicker(context: context, initialDate: _due, firstDate: DateTime(2015), lastDate: DateTime(DateTime.now().year + 5));
                if (d != null) setState(() => _due = d);
              },
            ),
          ),
          if (members.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text('Covers', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.muted)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: [
              ChoiceChipPill(label: 'Household', dark: false, selected: _memberId == null, onTap: () => setState(() => _memberId = null)),
              for (final m in members) ChoiceChipPill(label: m.name, dark: false, selected: _memberId == m.id, onTap: () => setState(() => _memberId = m.id)),
            ]),
          ],
          if (accounts.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text('Usually paid from', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.muted)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final a in accounts) ChoiceChipPill(label: a.account.name, dark: false, selected: _accountId == a.account.id, onTap: () => setState(() => _accountId = a.account.id)),
            ]),
          ],
          const SizedBox(height: 18),
          FilledButton(
            onPressed: () async {
              final premium = Money.parse(_premium.text) ?? 0;
              if (premium <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter the contribution amount')));
                return;
              }
              await ref.read(repositoryProvider).addPolicy(
                    type: _type,
                    premium: premium,
                    nextDueDate: _due,
                    providerId: _providerId,
                    providerName: isOther && _otherName.text.trim().isNotEmpty ? _otherName.text.trim() : null,
                    policyNumber: _number.text.trim().isEmpty ? null : _number.text.trim(),
                    insuredMemberId: _memberId,
                    frequency: _frequency,
                    payFromAccountId: _accountId,
                  );
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save policy'),
          ),
        ]),
      ),
    );
  }
}
