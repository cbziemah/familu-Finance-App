import 'package:drift/drift.dart';

import 'database.dart';
import 'provider_registry.dart';

class _CategorySeed {
  const _CategorySeed(this.key, this.name, this.icon, [this.children = const []]);

  final String key;
  final String name;
  final String icon;
  final List<(String key, String name)> children;
}

const _expenseCategories = <_CategorySeed>[
  _CategorySeed('food', 'Food', 'food', [
    ('food.groceries', 'Groceries'),
    ('food.market', 'Market'),
    ('food.eating_out', 'Eating out'),
  ]),
  _CategorySeed('transport', 'Transport', 'transport', [
    ('transport.fuel', 'Fuel'),
    ('transport.trotro_taxi', 'Trotro and taxi'),
    ('transport.ride_hailing', 'Ride-hailing'),
  ]),
  _CategorySeed('bills', 'Bills', 'utilities', [
    ('bills.electricity', 'Electricity'),
    ('bills.water', 'Water'),
    ('bills.internet', 'Internet and data'),
    ('bills.airtime', 'Airtime'),
    ('bills.tv', 'TV'),
  ]),
  _CategorySeed('housing', 'Housing', 'housing', [
    ('housing.rent', 'Rent'),
    ('housing.repairs', 'Repairs'),
  ]),
  _CategorySeed('school', 'School', 'school', [
    ('school.fees', 'School fees'),
    ('school.pta', 'PTA dues'),
    ('school.uniform', 'Uniform'),
    ('school.books', 'Books and stationery'),
    ('school.feeding', 'Feeding'),
    ('school.transport', 'School transport'),
    ('school.extra_classes', 'Extra classes'),
    ('school.activities', 'Activities'),
    ('school.pocket_money', 'Pocket money'),
  ]),
  _CategorySeed('health', 'Health', 'health', [
    ('health.hospital', 'Hospital'),
    ('health.pharmacy', 'Pharmacy'),
  ]),
  _CategorySeed('shopping', 'Shopping', 'shopping', [
    ('shopping.clothing', 'Clothing'),
    ('shopping.household', 'Household items'),
  ]),
  _CategorySeed('giving', 'Giving', 'gift', [
    ('giving.church', 'Church and tithe'),
    ('giving.family', 'Family support'),
    ('giving.funerals', 'Funerals and events'),
  ]),
  _CategorySeed('insurance', 'Insurance and pensions', 'insurance', [
    ('insurance.premiums', 'Premiums'),
  ]),
  _CategorySeed('fees', 'Fees and charges', 'fees', [
    ('fees.momo', 'MoMo fees'),
    ('fees.elevy', 'E-levy'),
    ('fees.bank', 'Bank charges'),
  ]),
  _CategorySeed('other_expense', 'Other', 'other'),
];

const _incomeCategories = <_CategorySeed>[
  _CategorySeed('salary', 'Salary', 'salary'),
  _CategorySeed('business', 'Business', 'business'),
  _CategorySeed('gift_income', 'Gift', 'gift'),
  _CategorySeed('rental_income', 'Rental income', 'housing'),
  _CategorySeed('interest', 'Interest', 'salary'),
  _CategorySeed('refund', 'Refund', 'other'),
  _CategorySeed('other_income', 'Other income', 'other'),
];

/// Runs once when the database is first created.
Future<void> seedDatabase(AppDatabase db) async {
  final householdId = newId();
  await db.into(db.households).insert(
        HouseholdsCompanion.insert(id: Value(householdId), name: 'Our household'),
      );
  await db.into(db.users).insert(
        UsersCompanion.insert(householdId: householdId, name: 'Me'),
      );

  await db.batch((b) {
    b.insertAll(db.providers, [
      for (final p in providerSeeds)
        ProvidersCompanion.insert(
          id: p.id,
          name: p.name,
          kind: p.kind,
          smsSenders: Value(p.smsSenders.isEmpty ? null : p.smsSenders.join(',')),
        ),
    ]);
  });

  var order = 0;
  Future<void> insertTree(_CategorySeed seed, String kind) async {
    final parentId = newId();
    await db.into(db.categories).insert(CategoriesCompanion.insert(
          id: Value(parentId),
          householdId: householdId,
          name: seed.name,
          kind: kind,
          iconKey: Value(seed.icon),
          systemKey: Value(seed.key),
          sortOrder: Value(order++),
        ));
    for (final (key, name) in seed.children) {
      await db.into(db.categories).insert(CategoriesCompanion.insert(
            householdId: householdId,
            name: name,
            kind: kind,
            parentId: Value(parentId),
            iconKey: Value(seed.icon),
            systemKey: Value(key),
            sortOrder: Value(order++),
          ));
    }
  }

  for (final c in _expenseCategories) {
    await insertTree(c, 'expense');
  }
  for (final c in _incomeCategories) {
    await insertTree(c, 'income');
  }
}
