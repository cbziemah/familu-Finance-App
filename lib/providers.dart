import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/database.dart';
import 'data/repository.dart';
import 'sms/sms_parser.dart';

/// Overridden in tests with an in-memory database.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final repositoryProvider = Provider((ref) => FinanceRepository(ref.watch(databaseProvider)));
final smsParserProvider = Provider((ref) => const SmsParser());

final accountsProvider = StreamProvider((ref) => ref.watch(repositoryProvider).watchAccounts());
final netWorthProvider = StreamProvider((ref) => ref.watch(repositoryProvider).watchNetWorth());
final ratesProvider = StreamProvider((ref) => ref.watch(repositoryProvider).watchLatestRates());
final categoriesProvider = StreamProvider((ref) => ref.watch(repositoryProvider).watchCategories());
final membersProvider = StreamProvider((ref) => ref.watch(repositoryProvider).watchMembers());
final policiesProvider = StreamProvider((ref) => ref.watch(repositoryProvider).watchPolicies());

final financeProvidersProvider = StreamProvider.family<List<FinProvider>, String>(
  (ref, kinds) => ref.watch(repositoryProvider).watchProviders(kinds: kinds.split(',')),
);

final transactionsProvider = StreamProvider.family<List<TxnView>, ({String? accountId, String? memberId, int? limit})>(
  (ref, q) => ref.watch(repositoryProvider).watchTransactions(accountId: q.accountId, memberId: q.memberId, limit: q.limit),
);

final draftsProvider = StreamProvider((ref) => ref.watch(repositoryProvider).watchTransactions(status: 'draft'));

final summaryProvider = StreamProvider.family<PeriodSummary, DateRange>(
  (ref, range) => ref.watch(repositoryProvider).watchSummary(range),
);

final spendByCategoryProvider = StreamProvider.family<List<CategorySpend>, ({DateRange range, String? memberId})>(
  (ref, q) => ref.watch(repositoryProvider).watchSpendByCategory(q.range, memberId: q.memberId),
);
