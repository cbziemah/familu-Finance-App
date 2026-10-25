// Renders each screen to a PNG with the real fonts, for design review.
// Run: SCREENSHOT_FONTS=<dir with .ttf files> flutter test test/screenshot_test.dart
// Output goes to build/screenshots/. Skipped when SCREENSHOT_FONTS is unset.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_finance/data/database.dart';
import 'package:home_finance/data/repository.dart';
import 'package:home_finance/providers.dart';
import 'package:home_finance/ui/add_transaction_screen.dart';
import 'package:home_finance/ui/shell.dart';
import 'package:home_finance/ui/theme.dart';

final _fontsDir = Platform.environment['SCREENSHOT_FONTS'];

Future<void> _loadFonts() async {
  Future<void> load(String family, Iterable<File> files) async {
    final loader = FontLoader(family);
    for (final f in files) {
      loader.addFont(Future.value(ByteData.sublistView(f.readAsBytesSync())));
    }
    await loader.load();
  }

  final files = Directory(_fontsDir!).listSync().whereType<File>().where((f) => f.path.endsWith('.ttf')).toList();
  await load('Manrope', files.where((f) => f.path.contains('manrope')));
  await load('Bricolage', files.where((f) => f.path.contains('bricolage')));
  final flutterRoot = File(Platform.resolvedExecutable).parent.parent.parent.parent.parent.parent.path;
  await load('MaterialIcons', [File('$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf')]);
}

Future<void> _seed(FinanceRepository repo) async {
  final now = DateTime.now();
  final momo = await repo.addAccount(name: 'MTN MoMo', type: 'momo', providerId: 'mtn_momo', openingBalance: 300000);
  final tel = await repo.addAccount(name: 'Telecel Cash', type: 'momo', providerId: 'telecel_cash', openingBalance: 95000);
  final bank = await repo.addAccount(name: 'GCB Bank', type: 'bank', providerId: 'gcb', number: '4521', openingBalance: 1240000);
  await repo.addAccount(name: 'Wise', type: 'online_wallet', providerId: 'wise', currency: 'USD', openingBalance: 32000);
  final cash = await repo.addAccount(name: 'Cash', type: 'cash', openingBalance: 38000);
  await repo.setRate('USD', 15.42);
  final kofi = await repo.addMember(name: 'Kofi', school: 'Basic 4');
  await repo.setTerm(kofi, now.subtract(const Duration(days: 50)), now.add(const Duration(days: 45)));
  Future<String?> cat(String k) async => (await repo.categoryByKey(k))?.id;
  DateTime ago(int d) => now.subtract(Duration(days: d));

  await repo.addTransaction(type: 'income', amount: 920000, accountId: bank, payee: 'Salary', categoryId: await cat('salary'), date: ago(1));
  await repo.addTransaction(type: 'expense', amount: 320000, accountId: bank, categoryId: await cat('school.fees'), memberId: kofi, payee: 'School fees', date: ago(3));
  await repo.addTransaction(type: 'expense', amount: 64000, accountId: momo, categoryId: await cat('school.feeding'), memberId: kofi, payee: 'Canteen', date: ago(4));
  await repo.addTransaction(type: 'expense', amount: 6500, accountId: cash, categoryId: await cat('school.books'), memberId: kofi, payee: 'Maths workbook', date: ago(2));
  await repo.addTransaction(type: 'expense', amount: 36000, accountId: momo, categoryId: await cat('school.transport'), memberId: kofi, payee: 'School bus', date: ago(6));
  await repo.addTransaction(type: 'expense', amount: 14600, accountId: cash, categoryId: await cat('food.market'), payee: 'Makola market', date: ago(2));
  await repo.addTransaction(type: 'expense', amount: 120000, accountId: momo, categoryId: await cat('food.groceries'), payee: 'Shoprite', fee: 300, date: ago(5));
  await repo.addTransaction(type: 'expense', amount: 20000, accountId: momo, categoryId: await cat('bills.electricity'), payee: 'ECG prepaid', fee: 200, date: ago(1));
  await repo.addTransaction(type: 'expense', amount: 3250, accountId: momo, categoryId: await cat('transport.ride_hailing'), payee: 'Ride to Osu', date: now);
  await repo.addTransaction(type: 'expense', amount: 45000, accountId: tel, categoryId: await cat('giving.church'), payee: 'Church', date: ago(7));
  await repo.addTransfer(fromAccountId: bank, toAccountId: momo, amount: 50000, fee: 200, date: ago(1));
  await repo.addTransaction(type: 'expense', amount: 8500, accountId: momo, payee: 'Melcom, Accra Mall', status: 'draft', source: 'sms', fee: 128, date: now);
  final life = await repo.addPolicy(type: 'life', premium: 25000, nextDueDate: DateTime(now.year, 1, (now.day + 3).clamp(1, 28)), providerName: '[Insurer]', payFromAccountId: bank);
  for (var m = 1; m < now.month; m++) {
    await repo.recordPremium(life, accountId: bank, date: DateTime(now.year, m, 2));
  }
  final edu = await repo.addPolicy(type: 'education', premium: 30000, nextDueDate: DateTime(now.year, 1, 5), providerName: '[Insurer]', insuredMemberId: kofi, payFromAccountId: bank);
  for (var m = 1; m <= now.month; m++) {
    await repo.recordPremium(edu, accountId: bank, date: DateTime(now.year, m, 5));
  }
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  testWidgets('screenshots', skip: _fontsDir == null, (tester) async {
    AppFonts.useGoogleFonts = false;
    AppFonts.localBodyFamily = 'Manrope';
    AppFonts.localDisplayFamily = 'Bricolage';
    await tester.runAsync(_loadFonts);

    final db = AppDatabase(NativeDatabase.memory());
    final repo = FinanceRepository(db);
    await tester.runAsync(() => _seed(repo));

    Future<void> settle() async {
      for (var i = 0; i < 6; i++) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 40)));
        await tester.pump(const Duration(milliseconds: 200));
      }
    }

    final out = Directory('build/screenshots')..createSync(recursive: true);
    final key = GlobalKey();
    Future<void> shoot(String name) async {
      await settle();
      final boundary = key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final bytes = await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 2);
        return (await image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
      });
      File('${out.path}/$name.png').writeAsBytesSync(bytes!);
    }

    Future<void> app(Widget home, {double height = 844}) async {
      tester.view.physicalSize = Size(390, height) * 2;
      tester.view.devicePixelRatio = 2;
      await tester.pumpWidget(ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: RepaintBoundary(key: key, child: MaterialApp(debugShowCheckedModeBanner: false, theme: buildTheme(), home: home)),
      ));
    }

    await app(const AppShell(), height: 1400);
    await shoot('1-home');
    for (final (i, tab) in ['Activity', 'Accounts', 'Family', 'Plan'].indexed) {
      await app(const AppShell());
      await settle();
      await tester.tap(find.text(tab).last);
      await shoot('${i + 2}-${tab.toLowerCase()}');
    }
    await app(const AddTransactionScreen());
    await settle();
    for (final k in ['4', '5']) {
      await tester.tap(find.text(k).last);
    }
    await tester.tap(find.text('Food'));
    await shoot('6-add');

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(db.close);
    tester.view.reset();
  });
}
