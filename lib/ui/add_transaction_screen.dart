import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../core/money.dart';
import '../data/database.dart';
import '../data/repository.dart';
import '../providers.dart';
import 'accounts_screen.dart';
import 'theme.dart';
import 'visuals.dart';
import 'widgets.dart';

enum TxnKind { expense, income, transfer }

Future<void> openAddTransaction(BuildContext context, {TxnKind type = TxnKind.expense, String? accountId, String? memberId, TxnView? editDraft}) =>
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => AddTransactionScreen(initialType: type, initialAccountId: accountId, initialMemberId: memberId, draft: editDraft),
    ));

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key, this.initialType = TxnKind.expense, this.initialAccountId, this.initialMemberId, this.draft});

  final TxnKind initialType;
  final String? initialAccountId;
  final String? initialMemberId;

  /// An SMS draft being reviewed; saving replaces it with a posted entry.
  final TxnView? draft;

  @override
  ConsumerState<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  late TxnKind _type = widget.initialType;
  String _amount = '';
  String? _accountId;
  String? _toAccountId;
  String? _parentCategoryId;
  String? _categoryId;
  String? _memberId;
  int _fee = 0;
  int? _toAmount;
  DateTime _date = DateTime.now();
  final _payee = TextEditingController();
  final _note = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _accountId = widget.initialAccountId;
    _memberId = widget.initialMemberId;
    final d = widget.draft;
    if (d != null) {
      _type = d.txn.type == 'income' ? TxnKind.income : TxnKind.expense;
      _amount = _toEditable(d.txn.amount);
      _accountId = d.account.id;
      _categoryId = d.category?.id;
      _parentCategoryId = d.parentCategory?.id ?? d.category?.id;
      _memberId = d.member?.id;
      _date = d.txn.date;
      _payee.text = d.txn.payee ?? '';
      _note.text = d.txn.note ?? '';
      _loadDraftFee(d.txn.id);
    }
  }

  Future<void> _loadDraftFee(String id) async {
    final db = ref.read(databaseProvider);
    final fees = await (db.select(db.txns)..where((t) => t.feeOfId.equals(id))).get();
    if (mounted) setState(() => _fee = fees.fold(0, (s, f) => s + f.amount));
  }

  static String _toEditable(int minor) {
    final whole = minor ~/ 100, cents = minor % 100;
    return cents == 0 ? '$whole' : '$whole.${cents.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _payee.dispose();
    _note.dispose();
    super.dispose();
  }

  int get _minor => Money.parse(_amount.isEmpty ? '0' : _amount) ?? 0;

  void _press(String key) {
    HapticFeedback.selectionClick();
    setState(() {
      if (key == 'del') {
        if (_amount.isNotEmpty) _amount = _amount.substring(0, _amount.length - 1);
      } else if (key == '.') {
        if (!_amount.contains('.')) _amount = _amount.isEmpty ? '0.' : '$_amount.';
      } else {
        final decimals = _amount.contains('.') ? _amount.split('.')[1].length : 0;
        if (decimals >= 2 || _amount.replaceAll('.', '').length >= 9) return;
        _amount = _amount == '0' ? key : _amount + key;
      }
    });
  }

  String get _shownAmount {
    if (_amount.isEmpty) return '0';
    final parts = _amount.split('.');
    final whole = NumberFormat('#,##0', 'en_US').format(int.parse(parts[0].isEmpty ? '0' : parts[0]));
    return parts.length > 1 ? '$whole.${parts[1]}' : whole;
  }

  Future<void> _editFee(String currency) async {
    final controller = TextEditingController(text: _fee == 0 ? '' : _toEditable(_fee));
    final result = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Fee and e-levy'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(prefixText: '$currency ', hintText: '0.00', fillColor: AppColors.ground),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, Money.parse(controller.text) ?? 0), child: const Text('Save')),
        ],
      ),
    );
    if (result != null) setState(() => _fee = result);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2015), lastDate: DateTime.now().add(const Duration(days: 365)));
    if (picked != null) setState(() => _date = DateTime(picked.year, picked.month, picked.day, _date.hour, _date.minute));
  }

  Future<void> _save(List<AccountBalance> accounts) async {
    final messenger = ScaffoldMessenger.of(context);
    String? problem;
    if (_minor <= 0) problem = 'Enter an amount';
    if (_accountId == null) problem ??= 'Pick an account';
    if (_type == TxnKind.transfer && (_toAccountId == null || _toAccountId == _accountId)) problem ??= 'Pick a different account to move money to';
    if (problem != null) {
      messenger.showSnackBar(SnackBar(content: Text(problem)));
      return;
    }
    setState(() => _saving = true);
    final repo = ref.read(repositoryProvider);
    try {
      if (_type == TxnKind.transfer) {
        await repo.addTransfer(fromAccountId: _accountId!, toAccountId: _toAccountId!, amount: _minor, toAmount: _toAmount, fee: _fee, date: _date, note: _note.text.trim().isEmpty ? null : _note.text.trim());
      } else {
        final draft = widget.draft;
        if (draft != null) await repo.deleteTransaction(draft.txn.id);
        await repo.addTransaction(
          type: _type == TxnKind.income ? 'income' : 'expense',
          amount: _minor,
          accountId: _accountId!,
          categoryId: _categoryId ?? _parentCategoryId,
          memberId: _type == TxnKind.expense ? _memberId : null,
          date: _date,
          payee: _payee.text.trim().isEmpty ? null : _payee.text.trim(),
          note: _note.text.trim().isEmpty ? null : _note.text.trim(),
          fee: _type == TxnKind.expense ? _fee : 0,
          source: draft?.txn.source ?? 'manual',
          smsRef: draft?.txn.smsRef,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Could not save: $e')));
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accounts = ref.watch(accountsProvider).value ?? const <AccountBalance>[];
    final categories = ref.watch(categoriesProvider).value ?? const <Category>[];
    final members = ref.watch(membersProvider).value ?? const <Member>[];
    _accountId ??= accounts.isEmpty ? null : accounts.first.account.id;
    final account = accounts.where((a) => a.account.id == _accountId).firstOrNull?.account;
    final toAccount = accounts.where((a) => a.account.id == _toAccountId).firstOrNull?.account;
    final currency = account?.currency ?? 'GHS';
    final kind = _type == TxnKind.income ? 'income' : 'expense';
    final parents = categories.where((c) => c.kind == kind && c.parentId == null).toList();
    final children = categories.where((c) => c.parentId != null && c.parentId == _parentCategoryId).toList();
    final showFee = _type != TxnKind.income;

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(children: [
              IconButton(
                tooltip: 'Close',
                onPressed: () => Navigator.of(context).pop(),
                style: IconButton.styleFrom(backgroundColor: Colors.white, fixedSize: const Size(44, 44)),
                icon: const Icon(Icons.close_rounded),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Segmented<TxnKind>(
                  options: [
                    (TxnKind.expense, 'Expense'),
                    (TxnKind.income, 'Income'),
                    if (widget.draft == null) (TxnKind.transfer, 'Transfer'),
                  ],
                  selected: _type,
                  onChanged: (t) => setState(() {
                    _type = t;
                    _parentCategoryId = null;
                    _categoryId = null;
                  }),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 14),
          Text(
            switch (_type) { TxnKind.income => 'MONEY IN', TxnKind.transfer => 'MOVE', TxnKind.expense => 'MONEY OUT' },
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.7, color: AppColors.muted),
          ),
          const SizedBox(height: 6),
          Semantics(
            liveRegion: true,
            label: 'Amount $currency $_shownAmount',
            child: FittedBox(
              child: Text.rich(TextSpan(children: [
                TextSpan(text: '$currency ', style: AppFonts.display(size: 22, weight: FontWeight.w700, color: AppColors.muted)),
                TextSpan(text: _shownAmount, style: AppFonts.display(size: 52, color: AppColors.ink)),
              ])),
            ),
          ),
          if (showFee) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _editFee(currency),
              child: Tag(_fee > 0 ? '+ fee and e-levy ${amountText(_fee)} · tap to change' : '+ add fee or e-levy'),
            ),
          ],
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                if (accounts.isEmpty)
                  OutlinedButton.icon(onPressed: () => showAddAccountSheet(context), icon: const Icon(Icons.add), label: const Text('Add an account first'))
                else ...[
                  _label(_type == TxnKind.transfer ? 'From' : 'Account'),
                  _AccountChips(accounts: accounts, selected: _accountId, onPick: (id) => setState(() => _accountId = id)),
                ],
                if (_type == TxnKind.transfer) ...[
                  const SizedBox(height: 14),
                  _label('To'),
                  _AccountChips(
                    accounts: accounts.where((a) => a.account.id != _accountId).toList(),
                    selected: _toAccountId,
                    onPick: (id) => setState(() => _toAccountId = id),
                  ),
                  if (toAccount != null && account != null && toAccount.currency != account.currency) ...[
                    const SizedBox(height: 12),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'Amount received', prefixText: '${toAccount.currency} '),
                      onChanged: (v) => _toAmount = Money.parse(v),
                    ),
                  ],
                ] else ...[
                  const SizedBox(height: 16),
                  _label('Category'),
                  GridView.count(
                    crossAxisCount: 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.82,
                    children: [
                      for (final c in parents)
                        _CategoryTile(
                          category: c,
                          selected: c.id == _parentCategoryId,
                          onTap: () => setState(() {
                            _parentCategoryId = c.id;
                            _categoryId = null;
                          }),
                        ),
                    ],
                  ),
                  if (children.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      for (final c in children)
                        ChoiceChipPill(label: c.name, dark: false, selected: c.id == _categoryId, onTap: () => setState(() => _categoryId = c.id == _categoryId ? null : c.id)),
                    ]),
                  ],
                  if (_type == TxnKind.expense && members.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _label('For'),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      ChoiceChipPill(label: 'Household', dark: false, selected: _memberId == null, onTap: () => setState(() => _memberId = null)),
                      for (final m in members)
                        ChoiceChipPill(
                          label: m.name,
                          dark: false,
                          selected: _memberId == m.id,
                          leading: CircleAvatar(radius: 10, backgroundColor: const Color(0xFF3F6FE0), child: Text(m.name[0], style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w800))),
                          onTap: () => setState(() => _memberId = m.id),
                        ),
                    ]),
                  ],
                  const SizedBox(height: 16),
                  TextField(controller: _payee, textCapitalization: TextCapitalization.words, decoration: InputDecoration(labelText: _type == TxnKind.income ? 'From (optional)' : 'Paid to (optional)')),
                ],
                const SizedBox(height: 10),
                TextField(controller: _note, decoration: const InputDecoration(labelText: 'Note (optional)')),
                const SizedBox(height: 10),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    leading: const Icon(Icons.calendar_today_rounded, size: 20),
                    title: Text(friendlyDay(_date), style: const TextStyle(fontWeight: FontWeight.w700)),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: _pickDate,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Column(children: [
              _Keypad(onKey: _press),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _saving ? null : () => _save(accounts),
                  style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                  child: Text(_type == TxnKind.transfer ? 'Move $currency $_shownAmount' : 'Save $currency $_shownAmount', style: const TextStyle(fontSize: 16)),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.muted)),
      );
}

class _AccountChips extends StatelessWidget {
  const _AccountChips({required this.accounts, required this.selected, required this.onPick});

  final List<AccountBalance> accounts;
  final String? selected;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 44,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: accounts.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final a = accounts[i].account;
            final v = AccountVisual.of(a);
            return ChoiceChipPill(
              label: a.name,
              dark: false,
              selected: a.id == selected,
              leading: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(color: v.background == Colors.white ? AppColors.chip : v.background, borderRadius: BorderRadius.circular(5)),
              ),
              onTap: () => onPick(a.id),
            );
          },
        ),
      );
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category, required this.selected, required this.onTap});

  final Category category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        selected: selected,
        button: true,
        child: Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: selected ? AppColors.forest : Colors.transparent, width: 2),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CategoryIcon(category.iconKey, size: 36),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  category.name.split(' ').first,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.5, fontWeight: selected ? FontWeight.w800 : FontWeight.w600),
                ),
              ),
            ]),
          ),
        ),
      );
}

class _Keypad extends StatelessWidget {
  const _Keypad({required this.onKey});

  final ValueChanged<String> onKey;

  @override
  Widget build(BuildContext context) {
    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '0', 'del'];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      childAspectRatio: 2.4,
      children: [
        for (final k in keys)
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => onKey(k),
              child: Center(
                child: k == 'del'
                    ? const Icon(Icons.backspace_outlined, semanticLabel: 'Delete')
                    : Text(k, style: AppFonts.display(size: 22, weight: FontWeight.w700)),
              ),
            ),
          ),
      ],
    );
  }
}
