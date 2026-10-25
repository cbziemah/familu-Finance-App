import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_finance/core/money.dart';
import 'package:home_finance/data/database.dart';
import 'package:home_finance/data/repository.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late AppDatabase db;
  late FinanceRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = FinanceRepository(db);
  });
  tearDown(() => db.close());

  Future<int> balanceOf(String id) async =>
      (await repo.watchAccounts().first).firstWhere((a) => a.account.id == id).balance;

  test('money parsing and formatting', () {
    expect(Money.parse('1,250.30'), 125030);
    expect(Money.parse('GHS 0.5'), 50);
    expect(Money.parse('45'), 4500);
    expect(Money.format(125030), 'GHS 1,250.30');
    expect(Money.format(-500, currency: 'USD'), '-USD 5.00');
  });

  test('seeds categories and providers on first open', () async {
    final cats = await repo.watchCategories().first;
    expect(cats.any((c) => c.systemKey == 'school.fees'), isTrue);
    expect(await repo.categoryByKey('fees.elevy'), isNotNull);
    final momo = await repo.watchProviders(kinds: ['momo']).first;
    expect(momo.map((p) => p.id), containsAll(['mtn_momo', 'telecel_cash', 'at_money']));
  });

  test('balance = opening + income - expense - fees', () async {
    final momo = await repo.addAccount(name: 'MTN MoMo', type: 'momo', providerId: 'mtn_momo', openingBalance: 100000);
    await repo.addTransaction(type: 'income', amount: 20000, accountId: momo);
    await repo.addTransaction(type: 'expense', amount: 4500, accountId: momo, fee: 45);
    expect(await balanceOf(momo), 100000 + 20000 - 4500 - 45);
  });

  test('a transfer moves money but is not income or spending', () async {
    final bank = await repo.addAccount(name: 'GCB', type: 'bank', openingBalance: 500000);
    final momo = await repo.addAccount(name: 'MoMo', type: 'momo');
    await repo.addTransfer(fromAccountId: bank, toAccountId: momo, amount: 50000, fee: 200);
    expect(await balanceOf(bank), 500000 - 50000 - 200);
    expect(await balanceOf(momo), 50000);

    final summary = await repo.watchSummary(DateRange.month(DateTime.now())).first;
    expect(summary.income, 0);
    expect(summary.expense, 200, reason: 'only the fee counts as spending');

    final list = await repo.watchTransactions().first;
    final transfer = list.firstWhere((t) => t.isTransfer);
    expect(transfer.counterpartAccount?.id, momo);
    expect(list.where((t) => t.isTransfer), hasLength(1), reason: 'shown once');
  });

  test('deleting a transfer removes both legs and the fee', () async {
    final a = await repo.addAccount(name: 'A', type: 'bank', openingBalance: 10000);
    final b = await repo.addAccount(name: 'B', type: 'momo');
    final id = await repo.addTransfer(fromAccountId: a, toAccountId: b, amount: 3000, fee: 100);
    await repo.deleteTransaction(id);
    expect(await balanceOf(a), 10000);
    expect(await balanceOf(b), 0);
  });

  test('drafts do not touch balances until confirmed', () async {
    final momo = await repo.addAccount(name: 'MoMo', type: 'momo', openingBalance: 10000);
    final id = await repo.addTransaction(type: 'expense', amount: 2500, accountId: momo, status: 'draft', source: 'sms', smsRef: 'X1', fee: 25);
    expect(await balanceOf(momo), 10000);
    await repo.confirmDraft(id);
    expect(await balanceOf(momo), 10000 - 2500 - 25);
    expect(await repo.isDuplicateSms(accountId: momo, amount: 9999, date: DateTime.now(), smsRef: 'X1'), isTrue);
  });

  test('net worth converts foreign balances and flags missing rates', () async {
    await repo.addAccount(name: 'GCB', type: 'bank', openingBalance: 100000);
    await repo.addAccount(name: 'Wise', type: 'online_wallet', currency: 'USD', openingBalance: 32000);
    var nw = await repo.watchNetWorth().first;
    expect(nw.total, 100000);
    expect(nw.missingRates, {'USD'});

    await repo.setRate('USD', 15.42);
    nw = await repo.watchNetWorth().first;
    expect(nw.total, 100000 + 493440);
    expect(nw.missingRates, isEmpty);
  });

  test('child spending keeps sub-categories', () async {
    final cash = await repo.addAccount(name: 'Cash', type: 'cash', openingBalance: 1000000);
    final kofi = await repo.addMember(name: 'Kofi');
    final fees = await repo.categoryByKey('school.fees');
    final books = await repo.categoryByKey('school.books');
    await repo.addTransaction(type: 'expense', amount: 320000, accountId: cash, categoryId: fees!.id, memberId: kofi);
    await repo.addTransaction(type: 'expense', amount: 6500, accountId: cash, categoryId: books!.id, memberId: kofi);
    await repo.addTransaction(type: 'expense', amount: 9999, accountId: cash, categoryId: books.id);

    final range = DateRange.year(DateTime.now());
    final kid = await repo.watchSpendByCategory(range, memberId: kofi).first;
    expect(kid.map((s) => s.category?.name), ['School fees', 'Books and stationery']);
    final household = await repo.watchSpendByCategory(range).first;
    expect(household.single.category?.name, 'School');
    expect(household.single.amount, 320000 + 6500 + 9999);
  });

  test('recording a premium logs the contribution and rolls the due date', () async {
    final bank = await repo.addAccount(name: 'GCB', type: 'bank', openingBalance: 100000);
    final policyId = await repo.addPolicy(type: 'life', premium: 25000, nextDueDate: DateTime(2026, 1, 31), providerName: 'Test Life');
    await repo.recordPremium(policyId, accountId: bank);
    await repo.recordPremium(policyId, accountId: bank);

    final view = (await repo.watchPolicies().first).single;
    expect(view.paidCount, 2);
    expect(view.paidTotal, 50000);
    expect(view.policy.nextDueDate, DateTime(2026, 3, 31), reason: 'Jan 31 -> Feb 28 -> Mar 31');
    expect(await balanceOf(bank), 50000);
  });

  test('addMonths clamps to the end of shorter months', () {
    expect(addMonths(DateTime(2026, 1, 31), 1), DateTime(2026, 2, 28));
    expect(addMonths(DateTime(2026, 11, 15), 3), DateTime(2027, 2, 15));
  });
}
