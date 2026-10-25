import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:uuid/uuid.dart';

import 'seed.dart';

part 'database.g.dart';

const _uuid = Uuid();
String newId() => _uuid.v4();

/// Columns shared by every household-owned table, so one database can later
/// serve many households once cloud sync arrives.
mixin HouseholdScoped on Table {
  TextColumn get id => text().clientDefault(newId)();
  TextColumn get householdId => text().references(Households, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Households extends Table {
  TextColumn get id => text().clientDefault(newId)();
  TextColumn get name => text()();
  TextColumn get baseCurrency => text().withDefault(const Constant('GHS'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Users extends Table with HouseholdScoped {
  TextColumn get name => text()();

  /// owner | partner
  TextColumn get role => text().withDefault(const Constant('owner'))();
}

/// Dependents such as a son or daughter.
class Members extends Table with HouseholdScoped {
  TextColumn get name => text()();
  TextColumn get relation => text().withDefault(const Constant('son'))();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  TextColumn get school => text().nullable()();
  TextColumn get notes => text().nullable()();

  /// The current school term, used for "this term" totals.
  DateTimeColumn get termStart => dateTime().nullable()();
  DateTimeColumn get termEnd => dateTime().nullable()();
}

/// MoMo networks, banks, online wallets, insurers, pension trustees and
/// health schemes. Seeded from provider_registry.dart.
@DataClassName('FinProvider')
class Providers extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// momo | bank | wallet | insurer | pension | health
  TextColumn get kind => text()();

  /// Comma-separated SMS sender IDs used to match incoming messages.
  TextColumn get smsSenders => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Accounts extends Table with HouseholdScoped {
  TextColumn get name => text()();

  /// momo | bank | card | cash | savings | online_wallet
  TextColumn get type => text()();
  TextColumn get providerId => text().nullable().references(Providers, #id)();

  /// Last 4 digits of a card/account, or the wallet phone number.
  TextColumn get number => text().nullable()();
  TextColumn get currency => text().withDefault(const Constant('GHS'))();
  IntColumn get openingBalance => integer().withDefault(const Constant(0))();
  DateTimeColumn get openingDate => dateTime().withDefault(currentDateAndTime)();
  TextColumn get ownerUserId => text().nullable().references(Users, #id)();

  /// household | private
  TextColumn get visibility => text().withDefault(const Constant('household'))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
}

class Categories extends Table with HouseholdScoped {
  TextColumn get name => text()();

  /// income | expense
  TextColumn get kind => text()();
  TextColumn get parentId => text().nullable()();

  /// Picks the icon and colour in the UI: food, transport, school, ...
  TextColumn get iconKey => text().withDefault(const Constant('other'))();

  /// Stable key for seeded categories (e.g. "fees.momo"), so code can find
  /// them without depending on their display name.
  TextColumn get systemKey => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

/// One row per money movement. A transfer is two rows (transfer_out and
/// transfer_in) sharing a transferGroupId; its fee is a separate expense row
/// pointing at the outgoing leg through feeOfId.
@DataClassName('Txn')
class Txns extends Table with HouseholdScoped {
  /// income | expense | transfer_out | transfer_in
  TextColumn get type => text()();

  /// Always positive, in the account's minor units; [type] gives direction.
  IntColumn get amount => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get accountId => text().references(Accounts, #id)();
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  TextColumn get memberId => text().nullable().references(Members, #id)();
  TextColumn get policyId => text().nullable()();
  TextColumn get payee => text().nullable()();
  TextColumn get note => text().nullable()();

  /// manual | sms | import
  TextColumn get source => text().withDefault(const Constant('manual'))();

  /// posted | draft. Drafts come from SMS and wait for the owner to confirm.
  TextColumn get status => text().withDefault(const Constant('posted'))();
  TextColumn get smsRef => text().nullable()();
  TextColumn get transferGroupId => text().nullable()();
  TextColumn get feeOfId => text().nullable()();
  TextColumn get createdByUserId => text().nullable()();
}

class InsurancePolicies extends Table with HouseholdScoped {
  TextColumn get providerId => text().nullable().references(Providers, #id)();

  /// Free text when the provider is "Other" or not in the list yet.
  TextColumn get providerName => text().nullable()();

  /// life | health | motor | education | funeral | pension
  TextColumn get type => text()();
  TextColumn get policyNumber => text().nullable()();
  TextColumn get insuredMemberId => text().nullable().references(Members, #id)();
  IntColumn get premium => integer()();
  TextColumn get currency => text().withDefault(const Constant('GHS'))();

  /// monthly | quarterly | termly | yearly
  TextColumn get frequency => text().withDefault(const Constant('monthly'))();
  DateTimeColumn get nextDueDate => dateTime()();

  /// Day of the month premiums fall due, so 31 Jan -> 28 Feb -> 31 Mar.
  IntColumn get dueDay => integer().nullable()();
  IntColumn get coverAmount => integer().nullable()();
  TextColumn get payFromAccountId => text().nullable().references(Accounts, #id)();
}

class Contributions extends Table with HouseholdScoped {
  TextColumn get policyId => text().references(InsurancePolicies, #id)();
  TextColumn get txnId => text().references(Txns, #id)();

  /// The due date this payment covered.
  DateTimeColumn get periodDue => dateTime()();
}

/// Manually entered or Bank of Ghana reference rates, used to convert
/// foreign-currency balances into GHS totals.
class ExchangeRates extends Table {
  TextColumn get currency => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get rateToBase => real()();

  @override
  Set<Column> get primaryKey => {currency, date};
}

@DriftDatabase(tables: [
  Households,
  Users,
  Members,
  Providers,
  Accounts,
  Categories,
  Txns,
  InsurancePolicies,
  Contributions,
  ExchangeRates,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'home_finance'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await seedDatabase(this);
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
