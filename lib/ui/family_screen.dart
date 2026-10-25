import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/database.dart';
import '../data/repository.dart';
import '../providers.dart';
import 'activity_screen.dart';
import 'add_transaction_screen.dart';
import 'shell.dart';
import 'theme.dart';
import 'widgets.dart';

enum _Period { term, year, month }

class FamilyScreen extends ConsumerStatefulWidget {
  const FamilyScreen({super.key});

  @override
  ConsumerState<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends ConsumerState<FamilyScreen> {
  String? _memberId;
  _Period _period = _Period.term;

  DateRange? _range(Member m) {
    final now = DateTime.now();
    return switch (_period) {
      _Period.month => DateRange.month(now),
      _Period.year => DateRange.year(now),
      _Period.term => m.termStart == null || m.termEnd == null ? null : DateRange(m.termStart!, m.termEnd!.add(const Duration(days: 1))),
    };
  }

  Future<void> _setTerm(Member m) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
      initialDateRange: m.termStart != null && m.termEnd != null ? DateTimeRange(start: m.termStart!, end: m.termEnd!) : null,
      helpText: 'Current term dates',
    );
    if (picked != null) await ref.read(repositoryProvider).setTerm(m.id, picked.start, picked.end);
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(membersProvider).value ?? const <Member>[];
    final member = members.where((m) => m.id == _memberId).firstOrNull ?? members.firstOrNull;
    final top = MediaQuery.paddingOf(context).top;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          decoration: const BoxDecoration(color: AppColors.forest, borderRadius: BorderRadius.vertical(bottom: Radius.circular(32))),
          padding: EdgeInsets.only(top: top),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const KenteStrip(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Row(children: [
                  Expanded(child: Text('Family', style: AppFonts.display(size: 30, color: Colors.white))),
                  FilledButton(
                    onPressed: () => showAddMemberSheet(context),
                    style: FilledButton.styleFrom(backgroundColor: AppColors.forestTile, minimumSize: const Size(0, 40)),
                    child: const Text('Add member', style: TextStyle(fontSize: 13)),
                  ),
                ]),
                if (member != null) ...[
                  const SizedBox(height: 18),
                  if (members.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Wrap(spacing: 8, children: [
                        for (final m in members) ChoiceChipPill(label: m.name, dark: false, selected: m.id == member.id, onTap: () => setState(() => _memberId = m.id)),
                      ]),
                    ),
                  Row(children: [
                    Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3F6FE0),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.gold, width: 2),
                      ),
                      child: Text(member.name[0].toUpperCase(), style: AppFonts.display(size: 24, color: Colors.white)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(member.name, style: AppFonts.display(size: 22, color: Colors.white)),
                        const SizedBox(height: 3),
                        Text(
                          [_relationLabel(member.relation), if (member.school != null) member.school!].join(' · '),
                          style: const TextStyle(fontSize: 13, color: AppColors.mintText, fontWeight: FontWeight.w600),
                        ),
                      ]),
                    ),
                  ]),
                  const SizedBox(height: 18),
                  Segmented<_Period>(
                    dark: true,
                    options: const [(_Period.term, 'This term'), (_Period.year, 'This year'), (_Period.month, 'This month')],
                    selected: _period,
                    onChanged: (p) => setState(() => _period = p),
                  ),
                ],
              ]),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, navClearance),
          child: member == null
              ? EmptyState(
                  icon: Icons.child_care_rounded,
                  title: 'Track what your son costs',
                  message: 'Add him once, then tag any expense to him: school fees, feeding, uniform, books and more.',
                  action: FilledButton(onPressed: () => showAddMemberSheet(context), child: const Text('Add family member')),
                )
              : _MemberBody(member: member, range: _range(member), period: _period, onSetTerm: () => _setTerm(member)),
        ),
      ],
    );
  }
}

class _MemberBody extends ConsumerWidget {
  const _MemberBody({required this.member, required this.range, required this.period, required this.onSetTerm});

  final Member member;
  final DateRange? range;
  final _Period period;
  final VoidCallback onSetTerm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (range == null) {
      return EmptyState(
        icon: Icons.event_rounded,
        title: 'Set the term dates',
        message: 'Tell the app when ${member.name}\'s current term starts and ends to see term totals.',
        action: FilledButton(onPressed: onSetTerm, child: const Text('Set term dates')),
      );
    }
    final spend = ref.watch(spendByCategoryProvider((range: range!, memberId: member.id))).value ?? const <CategorySpend>[];
    final total = spend.fold(0, (s, e) => s + e.amount);
    final txns = (ref.watch(transactionsProvider((accountId: null, memberId: member.id, limit: 5))).value ?? const <TxnView>[]);
    final policies = (ref.watch(policiesProvider).value ?? const <PolicyView>[]).where((p) => p.policy.insuredMemberId == member.id).toList();
    final palette = [const Color(0xFF3F6FE0), AppColors.gold, const Color(0xFF7A5AF8), const Color(0xFF19A07B), const Color(0xFFE85D9B), const Color(0xFF9AA8A0)];
    final caption = switch (period) {
      _Period.term => '${DateFormat('d MMM').format(range!.start)} – ${DateFormat('d MMM').format(range!.end.subtract(const Duration(days: 1)))}',
      _Period.year => DateFormat('yyyy').format(range!.start),
      _Period.month => DateFormat('MMMM').format(range!.start),
    };

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SectionCard(
        child: total == 0
            ? Column(children: [
                Text('No costs for ${member.name} in this period yet.', style: const TextStyle(color: AppColors.muted)),
                const SizedBox(height: 12),
                FilledButton(onPressed: () => openAddTransaction(context, memberId: member.id), child: Text('Add a cost for ${member.name}')),
              ])
            : Row(children: [
                DonutChart(
                  size: 136,
                  segments: [for (var i = 0; i < spend.length; i++) DonutSegment(spend[i].amount.toDouble(), palette[i % palette.length])],
                  semanticLabel: '$caption costs for ${member.name}: ${spend.map((s) => '${s.category?.name ?? 'Other'} ${amountText(s.amount, whole: true)}').join(', ')}',
                  center: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(caption, style: const TextStyle(fontSize: 10.5, color: AppColors.muted, fontWeight: FontWeight.w700)),
                    Text(amountText(total, whole: true), style: AppFonts.display(size: 20)),
                    const Text('GHS', style: TextStyle(fontSize: 10.5, color: AppColors.muted, fontWeight: FontWeight.w700)),
                  ]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(children: [
                    for (var i = 0; i < spend.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.5),
                        child: Row(children: [
                          Container(width: 10, height: 10, decoration: BoxDecoration(color: palette[i % palette.length], borderRadius: BorderRadius.circular(3))),
                          const SizedBox(width: 8),
                          Expanded(child: Text(spend[i].category?.name ?? 'Other', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                          Text(amountText(spend[i].amount, whole: true), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                        ]),
                      ),
                  ]),
                ),
              ]),
      ),
      if (period == _Period.term)
        Align(alignment: Alignment.centerRight, child: TextButton(onPressed: onSetTerm, child: const Text('Change term dates'))),
      for (final p in policies) ...[
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(color: const Color(0xFFE6ECFD), borderRadius: BorderRadius.circular(22)),
          child: Row(children: [
            DatePill(p.policy.nextDueDate, background: Colors.white, foreground: const Color(0xFF1F3B8C)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.policy.type == 'education' ? 'Education plan' : 'Policy for ${member.name}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF14275E))),
                Text(p.providerLabel, style: const TextStyle(fontSize: 12, color: Color(0xFF2C3F73), fontWeight: FontWeight.w600)),
              ]),
            ),
            Text(amountText(p.policy.premium), style: AppFonts.display(size: 16, color: const Color(0xFF14275E))),
          ]),
        ),
      ],
      const SizedBox(height: 18),
      SectionTitle('Recent for ${member.name}', trailing: TextButton(onPressed: () => openAddTransaction(context, memberId: member.id), child: const Text('Add cost'))),
      const SizedBox(height: 8),
      if (txns.isEmpty)
        Text('Tag an expense to ${member.name} and it shows up here.', style: const TextStyle(color: AppColors.muted))
      else
        SectionCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Column(children: [for (var i = 0; i < txns.length; i++) TxnRow(txns[i], divider: i < txns.length - 1)]),
        ),
    ]);
  }
}

String _relationLabel(String r) => switch (r) {
      'son' => 'Son',
      'daughter' => 'Daughter',
      'spouse' => 'Spouse',
      'parent' => 'Parent',
      _ => 'Family',
    };

Future<void> showAddMemberSheet(BuildContext context) => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => const _AddMemberSheet());

class _AddMemberSheet extends ConsumerStatefulWidget {
  const _AddMemberSheet();

  @override
  ConsumerState<_AddMemberSheet> createState() => _AddMemberSheetState();
}

class _AddMemberSheetState extends ConsumerState<_AddMemberSheet> {
  final _name = TextEditingController();
  final _school = TextEditingController();
  String _relation = 'son';

  @override
  void dispose() {
    _name.dispose();
    _school.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.viewInsetsOf(context).bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Add family member', style: AppFonts.display(size: 24)),
          const SizedBox(height: 16),
          TextField(controller: _name, autofocus: true, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Name')),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: [
            for (final r in const ['son', 'daughter', 'spouse', 'parent', 'other'])
              ChoiceChipPill(label: _relationLabel(r), selected: _relation == r, onTap: () => setState(() => _relation = r)),
          ]),
          const SizedBox(height: 12),
          TextField(controller: _school, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'School and class (optional)')),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: () async {
              if (_name.text.trim().isEmpty) return;
              await ref.read(repositoryProvider).addMember(
                    name: _name.text.trim(),
                    relation: _relation,
                    school: _school.text.trim().isEmpty ? null : _school.text.trim(),
                  );
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ]),
      );
}
