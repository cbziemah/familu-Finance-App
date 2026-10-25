import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_finance/data/database.dart';
import 'package:home_finance/data/repository.dart';
import 'package:home_finance/main.dart';
import 'package:home_finance/providers.dart';
import 'package:home_finance/ui/theme.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  AppFonts.useGoogleFonts = false;

  late AppDatabase db;
  late FinanceRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = FinanceRepository(db);
  });

  // Drift runs real async work that the fake test clock does not advance,
  // so let real time pass, then pump frames.
  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 30)));
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const HomeFinanceApp(),
    ));
    await settle(tester);
  }

  Future<void> closeDb(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(db.close);
  }

  testWidgets('first run shows the empty state', (tester) async {
    await pumpApp(tester);
    expect(find.text('Add your first account'), findsOneWidget);
    await closeDb(tester);
  });

  testWidgets('every tab renders with sample data at phone size', (tester) async {
    final momo = await repo.addAccount(name: 'MTN MoMo', type: 'momo', providerId: 'mtn_momo', openingBalance: 125030);
    final bank = await repo.addAccount(name: 'GCB Bank', type: 'bank', providerId: 'gcb', number: '4521', openingBalance: 1240000);
    await repo.addAccount(name: 'Wise', type: 'online_wallet', providerId: 'wise', currency: 'USD', openingBalance: 32000);
    await repo.setRate('USD', 15.42);
    final kofi = await repo.addMember(name: 'Kofi', school: 'Basic 4');
    await repo.setTerm(kofi, DateTime.now().subtract(const Duration(days: 30)), DateTime.now().add(const Duration(days: 40)));
    final fees = await repo.categoryByKey('school.fees');
    final food = await repo.categoryByKey('food.groceries');
    await repo.addTransaction(type: 'expense', amount: 320000, accountId: bank, categoryId: fees!.id, memberId: kofi);
    await repo.addTransaction(type: 'expense', amount: 14600, accountId: momo, categoryId: food!.id, payee: 'Makola market', fee: 146);
    await repo.addTransaction(type: 'income', amount: 920000, accountId: bank, payee: 'Salary');
    await repo.addTransfer(fromAccountId: bank, toAccountId: momo, amount: 50000, fee: 200);
    await repo.addTransaction(type: 'expense', amount: 8500, accountId: momo, payee: 'Melcom', status: 'draft', source: 'sms', fee: 128);
    await repo.addPolicy(type: 'life', premium: 25000, nextDueDate: DateTime.now().add(const Duration(days: 3)), providerName: 'Test Life', payFromAccountId: bank);

    await pumpApp(tester);
    expect(find.text('Caught from SMS'), findsOneWidget);
    expect(find.text('Where it went'), findsOneWidget);

    for (final tab in ['Activity', 'Accounts', 'Family', 'Plan', 'Home']) {
      await tester.tap(find.text(tab).last);
      await settle(tester);
    }
    await tester.tap(find.text('Family').last);
    await settle(tester);
    expect(find.text('Kofi'), findsWidgets);
    await tester.tap(find.text('Plan').last);
    await settle(tester);
    expect(find.textContaining('Record'), findsOneWidget);
    await closeDb(tester);
  });

  testWidgets('add an expense with the keypad', (tester) async {
    await repo.addAccount(name: 'Cash', type: 'cash', openingBalance: 10000);
    await pumpApp(tester);

    await tester.tap(find.text('Add').first);
    await settle(tester);
    for (final k in ['4', '5']) {
      await tester.tap(find.text(k).last);
    }
    await tester.pump();
    expect(find.text('Save GHS 45'), findsOneWidget);
    await tester.tap(find.text('Food'));
    await tester.pump();
    await tester.tap(find.text('Save GHS 45'));
    await settle(tester);

    final balance = (await repo.watchAccounts().first).single.balance;
    expect(balance, 10000 - 4500);
    await closeDb(tester);
  });
}
