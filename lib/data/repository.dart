import 'package:drift/drift.dart';

import 'database.dart';

class AccountBalance {
  const AccountBalance(this.account, this.balance, this.provider);

  final Account account;

  /// In the account's own currency, minor units.
  final int balance;
  final FinProvider? provider;
}

class NetWorth {
  const NetWorth(this.total, this.accountCount, this.missingRates);

  /// Household base currency (GHS), minor units.
  final int total;
  final int accountCount;

  /// Currencies held in accounts with no exchange rate entered yet; those
  /// balances are left out of [total].
  final Set<String> missingRates;
}

class TxnView {
  const TxnView({
    required this.txn,
    required this.account,
    this.category,
    this.parentCategory,
    this.member,
    this.counterpartAccount,
    this.fee = 0,
  });

  final Txn txn;
  final Account account;
  final Category? category;
  final Category? parentCategory;
  final Member? member;

  /// For a transfer, the account on the other side.
  final Account? counterpartAccount;

  /// Fee and e-levy lines recorded with this transaction (shown with it,
  /// not as separate rows).
  final int fee;

  bool get isTransfer => txn.type == 'transfer_out' || txn.type == 'transfer_in';

  /// "Food › Groceries", or the single name of a top-level category.
  String get categoryLabel {
    if (category == null) return isTransfer ? 'Transfer' : 'Uncategorised';
    if (parentCategory == null) return category!.name;
    return '${parentCategory!.name} › ${category!.name}';
  }

  String get iconKey {
    if (isTransfer) return 'transfer';
    if (txn.type == 'income') return category?.iconKey ?? 'salary';
    return category?.iconKey ?? 'other';
  }
}

class PeriodSummary {
  const PeriodSummary(this.income, this.expense);

  final int income;
  final int expense;
  int get kept => income - expense;
}

class CategorySpend {
  const CategorySpend(this.category, this.amount);

  final Category? category;
  final int amount;
}

class PolicyView {
  const PolicyView(this.policy, this.provider, this.paidTotal, this.paidCount, this.paidDueDates);

  final InsurancePolicy policy;
  final FinProvider? provider;
  final int paidTotal;
  final int paidCount;

  /// The due dates already covered by a contribution.
  final List<DateTime> paidDueDates;

  String get providerLabel => policy.providerName ?? provider?.name ?? 'Insurer';
}

/// Date range helper; [end] is exclusive.
class DateRange {
  const DateRange(this.start, this.end);

  final DateTime start;
  final DateTime end;

  factory DateRange.month(DateTime d) =>
      DateRange(DateTime(d.year, d.month), DateTime(d.year, d.month + 1));
  factory DateRange.year(DateTime d) => DateRange(DateTime(d.year), DateTime(d.year + 1));

  bool contains(DateTime d) => !d.isBefore(start) && d.isBefore(end);

  @override
  bool operator ==(Object other) => other is DateRange && other.start == start && other.end == end;

  @override
  int get hashCode => Object.hash(start, end);
}

/// Adds [months], landing on [day] (default: [d]'s day) or the last day of
/// a shorter month: 31 Jan + 1 = 28 Feb.
DateTime addMonths(DateTime d, int months, {int? day}) {
  final firstOfTarget = DateTime(d.year, d.month + months);
  final lastDay = DateTime(firstOfTarget.year, firstOfTarget.month + 1, 0).day;
  final want = day ?? d.day;
  return DateTime(firstOfTarget.year, firstOfTarget.month, want > lastDay ? lastDay : want);
}

int monthsPerPeriod(String frequency) => switch (frequency) {
      'quarterly' => 3,
      'termly' => 4,
      'yearly' => 12,
      _ => 1,
    };

class FinanceRepository {
  FinanceRepository(this.db);

  final AppDatabase db;
  String? _householdId;

  Future<String> householdId() async =>
      _householdId ??= (await db.select(db.households).getSingle()).id;

  // ---------------------------------------------------------------- accounts

  Stream<List<AccountBalance>> watchAccounts() {
    final query = db.customSelect(
      '''
      SELECT a.*, p.name AS provider_name, p.kind AS provider_kind,
        a.opening_balance + COALESCE(SUM(CASE
          WHEN t.type IN ('income', 'transfer_in') THEN t.amount
          WHEN t.type IN ('expense', 'transfer_out') THEN -t.amount
          ELSE 0 END), 0) AS balance
      FROM accounts a
      LEFT JOIN providers p ON p.id = a.provider_id
      LEFT JOIN txns t ON t.account_id = a.id
        AND t.deleted_at IS NULL AND t.status = 'posted'
      WHERE a.deleted_at IS NULL AND a.archived = 0
      GROUP BY a.id
      ORDER BY a.created_at, a.rowid
      ''',
      readsFrom: {db.accounts, db.txns, db.providers},
    );
    return query.watch().map((rows) => [
          for (final r in rows)
            AccountBalance(
              db.accounts.map(r.data),
              r.read<int>('balance'),
              r.readNullable<String>('provider_name') == null
                  ? null
                  : FinProvider(
                      id: r.read<String>('provider_id'),
                      name: r.read<String>('provider_name'),
                      kind: r.read<String>('provider_kind'),
                    ),
            ),
        ]);
  }

  Future<String> addAccount({
    required String name,
    required String type,
    String? providerId,
    String? number,
    String currency = 'GHS',
    int openingBalance = 0,
    DateTime? openingDate,
  }) async {
    final id = newId();
    await db.into(db.accounts).insert(AccountsCompanion.insert(
          id: Value(id),
          householdId: await householdId(),
          name: name,
          type: type,
          providerId: Value(providerId),
          number: Value(number),
          currency: Value(currency),
          openingBalance: Value(openingBalance),
          openingDate: Value(openingDate ?? DateTime.now()),
        ));
    return id;
  }

  Future<void> archiveAccount(String id) =>
      (db.update(db.accounts)..where((a) => a.id.equals(id)))
          .write(const AccountsCompanion(archived: Value(true)));

  // ---------------------------------------------------------- exchange rates

  Future<void> setRate(String currency, double rateToBase, {DateTime? date}) async {
    final d = date ?? DateTime.now();
    await db.into(db.exchangeRates).insertOnConflictUpdate(ExchangeRatesCompanion.insert(
          currency: currency,
          date: DateTime(d.year, d.month, d.day),
          rateToBase: rateToBase,
        ));
  }

  Stream<Map<String, double>> watchLatestRates() {
    final q = db.select(db.exchangeRates)..orderBy([(r) => OrderingTerm.desc(r.date)]);
    return q.watch().map((rows) {
      final out = <String, double>{'GHS': 1};
      for (final r in rows) {
        out.putIfAbsent(r.currency, () => r.rateToBase);
      }
      return out;
    });
  }

  Future<Map<String, double>> latestRates() => watchLatestRates().first;

  static int convert(int minor, String currency, Map<String, double> rates) =>
      currency == 'GHS' ? minor : (minor * (rates[currency] ?? 0)).round();

  Stream<NetWorth> watchNetWorth() => watchAccounts().asyncMap((accounts) async {
        final rates = await latestRates();
        var total = 0;
        final missing = <String>{};
        for (final a in accounts) {
          if (!rates.containsKey(a.account.currency)) {
            missing.add(a.account.currency);
            continue;
          }
          total += convert(a.balance, a.account.currency, rates);
        }
        return NetWorth(total, accounts.length, missing);
      });

  // ------------------------------------------------------------ categories

  Stream<List<Category>> watchCategories() =>
      (db.select(db.categories)
            ..where((c) => c.deletedAt.isNull())
            ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
          .watch();

  Future<Category?> categoryByKey(String key) =>
      (db.select(db.categories)..where((c) => c.systemKey.equals(key))).getSingleOrNull();

  Future<String> addCategory({required String name, required String kind, String? parentId, String iconKey = 'other'}) async {
    final id = newId();
    await db.into(db.categories).insert(CategoriesCompanion.insert(
          id: Value(id),
          householdId: await householdId(),
          name: name,
          kind: kind,
          parentId: Value(parentId),
          iconKey: Value(iconKey),
          sortOrder: const Value(1000),
        ));
    return id;
  }

  // ---------------------------------------------------------- transactions

  /// Records income or an expense. A [fee] (MoMo charge, e-levy, bank charge)
  /// becomes its own expense row under Fees, linked to this one.
  Future<String> addTransaction({
    required String type,
    required int amount,
    required String accountId,
    String? categoryId,
    String? memberId,
    String? policyId,
    DateTime? date,
    String? payee,
    String? note,
    int fee = 0,
    String feeCategoryKey = 'fees.momo',
    String source = 'manual',
    String status = 'posted',
    String? smsRef,
  }) async {
    assert(type == 'income' || type == 'expense');
    if (amount <= 0) throw ArgumentError.value(amount, 'amount', 'must be positive');
    final hid = await householdId();
    final when = date ?? DateTime.now();
    final id = newId();
    await db.transaction(() async {
      await db.into(db.txns).insert(TxnsCompanion.insert(
            id: Value(id),
            householdId: hid,
            type: type,
            amount: amount,
            date: when,
            accountId: accountId,
            categoryId: Value(categoryId),
            memberId: Value(memberId),
            policyId: Value(policyId),
            payee: Value(payee),
            note: Value(note),
            source: Value(source),
            status: Value(status),
            smsRef: Value(smsRef),
          ));
      if (fee > 0) {
        final feeCategory = await categoryByKey(feeCategoryKey);
        await db.into(db.txns).insert(TxnsCompanion.insert(
              householdId: hid,
              type: 'expense',
              amount: fee,
              date: when,
              accountId: accountId,
              categoryId: Value(feeCategory?.id),
              payee: Value(payee),
              note: const Value('Fee'),
              source: Value(source),
              status: Value(status),
              feeOfId: Value(id),
            ));
      }
    });
    return id;
  }

  /// Moves money between two accounts. [toAmount] is needed when the
  /// currencies differ (USD to GHS); otherwise it equals [amount].
  Future<String> addTransfer({
    required String fromAccountId,
    required String toAccountId,
    required int amount,
    int? toAmount,
    int fee = 0,
    DateTime? date,
    String? note,
  }) async {
    if (fromAccountId == toAccountId) throw ArgumentError('Pick two different accounts');
    if (amount <= 0) throw ArgumentError.value(amount, 'amount', 'must be positive');
    final hid = await householdId();
    final when = date ?? DateTime.now();
    final group = newId();
    final outId = newId();
    await db.transaction(() async {
      await db.into(db.txns).insert(TxnsCompanion.insert(
            id: Value(outId),
            householdId: hid,
            type: 'transfer_out',
            amount: amount,
            date: when,
            accountId: fromAccountId,
            note: Value(note),
            transferGroupId: Value(group),
          ));
      await db.into(db.txns).insert(TxnsCompanion.insert(
            householdId: hid,
            type: 'transfer_in',
            amount: toAmount ?? amount,
            date: when,
            accountId: toAccountId,
            note: Value(note),
            transferGroupId: Value(group),
          ));
      if (fee > 0) {
        final feeCategory = await categoryByKey('fees.momo');
        await db.into(db.txns).insert(TxnsCompanion.insert(
              householdId: hid,
              type: 'expense',
              amount: fee,
              date: when,
              accountId: fromAccountId,
              categoryId: Value(feeCategory?.id),
              note: const Value('Transfer fee'),
              feeOfId: Value(outId),
            ));
      }
    });
    return outId;
  }

  /// Soft-deletes a transaction together with its fee line and, for a
  /// transfer, the other leg.
  Future<void> deleteTransaction(String id) async {
    final txn = await (db.select(db.txns)..where((t) => t.id.equals(id))).getSingle();
    final now = Value<DateTime?>(DateTime.now());
    await db.transaction(() async {
      final legs = txn.transferGroupId == null
          ? [txn.id]
          : (await (db.select(db.txns)..where((t) => t.transferGroupId.equals(txn.transferGroupId!))).get())
              .map((t) => t.id)
              .toList();
      await (db.update(db.txns)..where((t) => t.id.isIn(legs) | t.feeOfId.isIn(legs)))
          .write(TxnsCompanion(deletedAt: now));
    });
  }

  /// Confirms an SMS draft (and its fee line), optionally setting its category.
  Future<void> confirmDraft(String id, {String? categoryId, String? memberId}) async {
    await db.transaction(() async {
      await (db.update(db.txns)..where((t) => t.id.equals(id))).write(TxnsCompanion(
            status: const Value('posted'),
            categoryId: categoryId == null ? const Value.absent() : Value(categoryId),
            memberId: memberId == null ? const Value.absent() : Value(memberId),
          ));
      await (db.update(db.txns)..where((t) => t.feeOfId.equals(id)))
          .write(const TxnsCompanion(status: Value('posted')));
    });
  }

  Future<void> updateTransaction(String id, {String? categoryId, String? memberId, String? note, bool clearMember = false}) =>
      (db.update(db.txns)..where((t) => t.id.equals(id))).write(TxnsCompanion(
            categoryId: categoryId == null ? const Value.absent() : Value(categoryId),
            memberId: clearMember ? const Value(null) : (memberId == null ? const Value.absent() : Value(memberId)),
            note: note == null ? const Value.absent() : Value(note),
          ));

  /// True when an SMS with the same reference was already recorded, or the
  /// same amount hit the same account within 24 hours from another SMS.
  Future<bool> isDuplicateSms({required String accountId, required int amount, required DateTime date, String? smsRef}) async {
    if (smsRef != null) {
      final byRef = await (db.select(db.txns)
            ..where((t) => t.smsRef.equals(smsRef) & t.deletedAt.isNull()))
          .get();
      if (byRef.isNotEmpty) return true;
    }
    final near = await (db.select(db.txns)
          ..where((t) =>
              t.accountId.equals(accountId) &
              t.amount.equals(amount) &
              t.source.equals('sms') &
              t.deletedAt.isNull() &
              t.date.isBetweenValues(date.subtract(const Duration(hours: 24)), date.add(const Duration(hours: 24)))))
        .get();
    return near.isNotEmpty;
  }

  /// Newest first. Transfers appear once (the outgoing leg) with the
  /// receiving account as [TxnView.counterpartAccount].
  Stream<List<TxnView>> watchTransactions({String? status = 'posted', String? accountId, String? memberId, int? limit}) {
    final q = db.select(db.txns).join([
      innerJoin(db.accounts, db.accounts.id.equalsExp(db.txns.accountId)),
      leftOuterJoin(db.members, db.members.id.equalsExp(db.txns.memberId)),
    ])
      ..where(db.txns.deletedAt.isNull())
      ..orderBy([OrderingTerm.desc(db.txns.date), OrderingTerm.desc(db.txns.createdAt)]);
    if (status != null) q.where(db.txns.status.equals(status));
    if (memberId != null) q.where(db.txns.memberId.equals(memberId));

    return q.watch().asyncMap((rows) async {
      final cats = {for (final c in await db.select(db.categories).get()) c.id: c};
      final inLegs = <String, Account>{};
      final outLegs = <String, Account>{};
      final ids = {for (final r in rows) r.readTable(db.txns).id};
      final fees = <String, int>{};
      for (final r in rows) {
        final t = r.readTable(db.txns);
        if (t.feeOfId != null) fees[t.feeOfId!] = (fees[t.feeOfId!] ?? 0) + t.amount;
        if (t.transferGroupId == null) continue;
        (t.type == 'transfer_in' ? inLegs : outLegs)[t.transferGroupId!] = r.readTable(db.accounts);
      }
      final out = <TxnView>[];
      for (final r in rows) {
        final t = r.readTable(db.txns);
        final account = r.readTable(db.accounts);
        if (t.feeOfId != null && ids.contains(t.feeOfId)) continue;
        if (accountId != null) {
          if (t.accountId != accountId) continue;
        } else if (t.type == 'transfer_in') {
          continue;
        }
        final cat = cats[t.categoryId];
        out.add(TxnView(
          txn: t,
          account: account,
          category: cat,
          parentCategory: cat?.parentId == null ? null : cats[cat!.parentId],
          member: r.readTableOrNull(db.members),
          counterpartAccount: t.transferGroupId == null
              ? null
              : (t.type == 'transfer_out' ? inLegs[t.transferGroupId] : outLegs[t.transferGroupId]),
          fee: fees[t.id] ?? 0,
        ));
        if (limit != null && out.length >= limit) break;
      }
      return out;
    });
  }

  /// Income and spending in GHS for a period; transfers are excluded.
  Stream<PeriodSummary> watchSummary(DateRange range) {
    final q = db.select(db.txns).join([innerJoin(db.accounts, db.accounts.id.equalsExp(db.txns.accountId))])
      ..where(db.txns.deletedAt.isNull() &
          db.txns.status.equals('posted') &
          db.txns.type.isIn(['income', 'expense']) &
          db.txns.date.isBiggerOrEqualValue(range.start) &
          db.txns.date.isSmallerThanValue(range.end));
    return q.watch().asyncMap((rows) async {
      final rates = await latestRates();
      var income = 0, expense = 0;
      for (final r in rows) {
        final t = r.readTable(db.txns);
        final amount = convert(t.amount, r.readTable(db.accounts).currency, rates);
        if (t.type == 'income') {
          income += amount;
        } else {
          expense += amount;
        }
      }
      return PeriodSummary(income, expense);
    });
  }

  /// Spending in GHS per category, largest first. Household view rolls up to
  /// top-level categories; a member view keeps sub-categories ("School fees",
  /// "Feeding") because that detail is what matters for a child.
  Stream<List<CategorySpend>> watchSpendByCategory(DateRange range, {String? memberId}) {
    final q = db.select(db.txns).join([innerJoin(db.accounts, db.accounts.id.equalsExp(db.txns.accountId))])
      ..where(db.txns.deletedAt.isNull() &
          db.txns.status.equals('posted') &
          db.txns.type.equals('expense') &
          db.txns.date.isBiggerOrEqualValue(range.start) &
          db.txns.date.isSmallerThanValue(range.end));
    if (memberId != null) q.where(db.txns.memberId.equals(memberId));
    return q.watch().asyncMap((rows) async {
      final rates = await latestRates();
      final cats = {for (final c in await db.select(db.categories).get()) c.id: c};
      final totals = <String?, int>{};
      for (final r in rows) {
        final t = r.readTable(db.txns);
        var cat = cats[t.categoryId];
        if (memberId == null && cat?.parentId != null) cat = cats[cat!.parentId];
        totals[cat?.id] = (totals[cat?.id] ?? 0) + convert(t.amount, r.readTable(db.accounts).currency, rates);
      }
      final list = [for (final e in totals.entries) CategorySpend(cats[e.key], e.value)]
        ..sort((a, b) => b.amount.compareTo(a.amount));
      return list;
    });
  }

  // --------------------------------------------------------------- members

  Stream<List<Member>> watchMembers() =>
      (db.select(db.members)..where((m) => m.deletedAt.isNull())).watch();

  Future<String> addMember({required String name, String relation = 'son', String? school, DateTime? dateOfBirth}) async {
    final id = newId();
    await db.into(db.members).insert(MembersCompanion.insert(
          id: Value(id),
          householdId: await householdId(),
          name: name,
          relation: Value(relation),
          school: Value(school),
          dateOfBirth: Value(dateOfBirth),
        ));
    return id;
  }

  Future<void> setTerm(String memberId, DateTime start, DateTime end) =>
      (db.update(db.members)..where((m) => m.id.equals(memberId)))
          .write(MembersCompanion(termStart: Value(start), termEnd: Value(end)));

  // ---------------------------------------------------------- insurance

  Stream<List<FinProvider>> watchProviders({List<String>? kinds}) {
    final q = db.select(db.providers)..orderBy([(p) => OrderingTerm.asc(p.name)]);
    if (kinds != null) q.where((p) => p.kind.isIn(kinds));
    return q.watch();
  }

  Future<String> addPolicy({
    required String type,
    required int premium,
    required DateTime nextDueDate,
    String? providerId,
    String? providerName,
    String? policyNumber,
    String? insuredMemberId,
    String frequency = 'monthly',
    String? payFromAccountId,
    int? coverAmount,
  }) async {
    final id = newId();
    await db.into(db.insurancePolicies).insert(InsurancePoliciesCompanion.insert(
          id: Value(id),
          householdId: await householdId(),
          type: type,
          premium: premium,
          nextDueDate: nextDueDate,
          dueDay: Value(nextDueDate.day),
          providerId: Value(providerId),
          providerName: Value(providerName),
          policyNumber: Value(policyNumber),
          insuredMemberId: Value(insuredMemberId),
          frequency: Value(frequency),
          payFromAccountId: Value(payFromAccountId),
          coverAmount: Value(coverAmount),
        ));
    return id;
  }

  Stream<List<PolicyView>> watchPolicies() {
    final q = db.select(db.insurancePolicies).join([
      leftOuterJoin(db.providers, db.providers.id.equalsExp(db.insurancePolicies.providerId)),
    ])
      ..where(db.insurancePolicies.deletedAt.isNull())
      ..orderBy([OrderingTerm.asc(db.insurancePolicies.nextDueDate)]);
    return q.watch().asyncMap((rows) async {
      final paid = await (db.select(db.contributions).join([
        innerJoin(db.txns, db.txns.id.equalsExp(db.contributions.txnId)),
      ])
            ..where(db.txns.deletedAt.isNull() & db.contributions.deletedAt.isNull()))
          .get();
      return [
        for (final r in rows)
          () {
            final p = r.readTable(db.insurancePolicies);
            final mine = paid.where((c) => c.readTable(db.contributions).policyId == p.id).toList();
            return PolicyView(
              p,
              r.readTableOrNull(db.providers),
              mine.fold(0, (sum, c) => sum + c.readTable(db.txns).amount),
              mine.length,
              [for (final c in mine) c.readTable(db.contributions).periodDue],
            );
          }(),
      ];
    });
  }

  /// Pays the premium that is due: records the expense, logs the
  /// contribution against the due date and rolls the policy forward.
  Future<String> recordPremium(String policyId, {required String accountId, int? amount, DateTime? date, int fee = 0}) async {
    final policy = await (db.select(db.insurancePolicies)..where((p) => p.id.equals(policyId))).getSingle();
    final premiums = await categoryByKey('insurance.premiums');
    return db.transaction(() async {
      final txnId = await addTransaction(
        type: 'expense',
        amount: amount ?? policy.premium,
        accountId: accountId,
        categoryId: premiums?.id,
        memberId: policy.insuredMemberId,
        policyId: policy.id,
        date: date,
        note: 'Premium',
        fee: fee,
      );
      await db.into(db.contributions).insert(ContributionsCompanion.insert(
            householdId: policy.householdId,
            policyId: policy.id,
            txnId: txnId,
            periodDue: policy.nextDueDate,
          ));
      await (db.update(db.insurancePolicies)..where((p) => p.id.equals(policy.id))).write(
            InsurancePoliciesCompanion(
              nextDueDate: Value(addMonths(policy.nextDueDate, monthsPerPeriod(policy.frequency), day: policy.dueDay)),
            ),
          );
      return txnId;
    });
  }
}
