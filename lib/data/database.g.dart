// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $HouseholdsTable extends Households
    with TableInfo<$HouseholdsTable, Household> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HouseholdsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseCurrencyMeta = const VerificationMeta(
    'baseCurrency',
  );
  @override
  late final GeneratedColumn<String> baseCurrency = GeneratedColumn<String>(
    'base_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('GHS'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, baseCurrency, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'households';
  @override
  VerificationContext validateIntegrity(
    Insertable<Household> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('base_currency')) {
      context.handle(
        _baseCurrencyMeta,
        baseCurrency.isAcceptableOrUnknown(
          data['base_currency']!,
          _baseCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Household map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Household(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      baseCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HouseholdsTable createAlias(String alias) {
    return $HouseholdsTable(attachedDatabase, alias);
  }
}

class Household extends DataClass implements Insertable<Household> {
  final String id;
  final String name;
  final String baseCurrency;
  final DateTime createdAt;
  const Household({
    required this.id,
    required this.name,
    required this.baseCurrency,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['base_currency'] = Variable<String>(baseCurrency);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HouseholdsCompanion toCompanion(bool nullToAbsent) {
    return HouseholdsCompanion(
      id: Value(id),
      name: Value(name),
      baseCurrency: Value(baseCurrency),
      createdAt: Value(createdAt),
    );
  }

  factory Household.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Household(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      baseCurrency: serializer.fromJson<String>(json['baseCurrency']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'baseCurrency': serializer.toJson<String>(baseCurrency),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Household copyWith({
    String? id,
    String? name,
    String? baseCurrency,
    DateTime? createdAt,
  }) => Household(
    id: id ?? this.id,
    name: name ?? this.name,
    baseCurrency: baseCurrency ?? this.baseCurrency,
    createdAt: createdAt ?? this.createdAt,
  );
  Household copyWithCompanion(HouseholdsCompanion data) {
    return Household(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      baseCurrency: data.baseCurrency.present
          ? data.baseCurrency.value
          : this.baseCurrency,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Household(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, baseCurrency, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Household &&
          other.id == this.id &&
          other.name == this.name &&
          other.baseCurrency == this.baseCurrency &&
          other.createdAt == this.createdAt);
}

class HouseholdsCompanion extends UpdateCompanion<Household> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> baseCurrency;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HouseholdsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HouseholdsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.baseCurrency = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Household> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? baseCurrency,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HouseholdsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? baseCurrency,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return HouseholdsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (baseCurrency.present) {
      map['base_currency'] = Variable<String>(baseCurrency.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HouseholdsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('owner'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    deletedAt,
    name,
    role,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final String name;

  /// owner | partner
  final String role;
  const User({
    required this.id,
    required this.householdId,
    required this.createdAt,
    this.deletedAt,
    required this.name,
    required this.role,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    map['role'] = Variable<String>(role);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      name: Value(name),
      role: Value(role),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
    };
  }

  User copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? name,
    String? role,
  }) => User(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    name: name ?? this.name,
    role: role ?? this.role,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, householdId, createdAt, deletedAt, name, role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.role == this.role);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<String> role;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String householdId,
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    this.role = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : householdId = Value(householdId),
       name = Value(name);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? role,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime?>? deletedAt,
    Value<String>? name,
    Value<String>? role,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      role: role ?? this.role,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, Member> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relationMeta = const VerificationMeta(
    'relation',
  );
  @override
  late final GeneratedColumn<String> relation = GeneratedColumn<String>(
    'relation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('son'),
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _schoolMeta = const VerificationMeta('school');
  @override
  late final GeneratedColumn<String> school = GeneratedColumn<String>(
    'school',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termStartMeta = const VerificationMeta(
    'termStart',
  );
  @override
  late final GeneratedColumn<DateTime> termStart = GeneratedColumn<DateTime>(
    'term_start',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termEndMeta = const VerificationMeta(
    'termEnd',
  );
  @override
  late final GeneratedColumn<DateTime> termEnd = GeneratedColumn<DateTime>(
    'term_end',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    deletedAt,
    name,
    relation,
    dateOfBirth,
    school,
    notes,
    termStart,
    termEnd,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<Member> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('relation')) {
      context.handle(
        _relationMeta,
        relation.isAcceptableOrUnknown(data['relation']!, _relationMeta),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('school')) {
      context.handle(
        _schoolMeta,
        school.isAcceptableOrUnknown(data['school']!, _schoolMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('term_start')) {
      context.handle(
        _termStartMeta,
        termStart.isAcceptableOrUnknown(data['term_start']!, _termStartMeta),
      );
    }
    if (data.containsKey('term_end')) {
      context.handle(
        _termEndMeta,
        termEnd.isAcceptableOrUnknown(data['term_end']!, _termEndMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Member map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Member(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      relation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relation'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      ),
      school: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      termStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}term_start'],
      ),
      termEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}term_end'],
      ),
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class Member extends DataClass implements Insertable<Member> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final String name;
  final String relation;
  final DateTime? dateOfBirth;
  final String? school;
  final String? notes;

  /// The current school term, used for "this term" totals.
  final DateTime? termStart;
  final DateTime? termEnd;
  const Member({
    required this.id,
    required this.householdId,
    required this.createdAt,
    this.deletedAt,
    required this.name,
    required this.relation,
    this.dateOfBirth,
    this.school,
    this.notes,
    this.termStart,
    this.termEnd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    map['relation'] = Variable<String>(relation);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    if (!nullToAbsent || school != null) {
      map['school'] = Variable<String>(school);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || termStart != null) {
      map['term_start'] = Variable<DateTime>(termStart);
    }
    if (!nullToAbsent || termEnd != null) {
      map['term_end'] = Variable<DateTime>(termEnd);
    }
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      name: Value(name),
      relation: Value(relation),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      school: school == null && nullToAbsent
          ? const Value.absent()
          : Value(school),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      termStart: termStart == null && nullToAbsent
          ? const Value.absent()
          : Value(termStart),
      termEnd: termEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(termEnd),
    );
  }

  factory Member.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Member(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      relation: serializer.fromJson<String>(json['relation']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      school: serializer.fromJson<String?>(json['school']),
      notes: serializer.fromJson<String?>(json['notes']),
      termStart: serializer.fromJson<DateTime?>(json['termStart']),
      termEnd: serializer.fromJson<DateTime?>(json['termEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'relation': serializer.toJson<String>(relation),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'school': serializer.toJson<String?>(school),
      'notes': serializer.toJson<String?>(notes),
      'termStart': serializer.toJson<DateTime?>(termStart),
      'termEnd': serializer.toJson<DateTime?>(termEnd),
    };
  }

  Member copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? name,
    String? relation,
    Value<DateTime?> dateOfBirth = const Value.absent(),
    Value<String?> school = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<DateTime?> termStart = const Value.absent(),
    Value<DateTime?> termEnd = const Value.absent(),
  }) => Member(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    name: name ?? this.name,
    relation: relation ?? this.relation,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    school: school.present ? school.value : this.school,
    notes: notes.present ? notes.value : this.notes,
    termStart: termStart.present ? termStart.value : this.termStart,
    termEnd: termEnd.present ? termEnd.value : this.termEnd,
  );
  Member copyWithCompanion(MembersCompanion data) {
    return Member(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      relation: data.relation.present ? data.relation.value : this.relation,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      school: data.school.present ? data.school.value : this.school,
      notes: data.notes.present ? data.notes.value : this.notes,
      termStart: data.termStart.present ? data.termStart.value : this.termStart,
      termEnd: data.termEnd.present ? data.termEnd.value : this.termEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('relation: $relation, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('school: $school, ')
          ..write('notes: $notes, ')
          ..write('termStart: $termStart, ')
          ..write('termEnd: $termEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    deletedAt,
    name,
    relation,
    dateOfBirth,
    school,
    notes,
    termStart,
    termEnd,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Member &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.relation == this.relation &&
          other.dateOfBirth == this.dateOfBirth &&
          other.school == this.school &&
          other.notes == this.notes &&
          other.termStart == this.termStart &&
          other.termEnd == this.termEnd);
}

class MembersCompanion extends UpdateCompanion<Member> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<String> relation;
  final Value<DateTime?> dateOfBirth;
  final Value<String?> school;
  final Value<String?> notes;
  final Value<DateTime?> termStart;
  final Value<DateTime?> termEnd;
  final Value<int> rowid;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.relation = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.school = const Value.absent(),
    this.notes = const Value.absent(),
    this.termStart = const Value.absent(),
    this.termEnd = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembersCompanion.insert({
    this.id = const Value.absent(),
    required String householdId,
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    this.relation = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.school = const Value.absent(),
    this.notes = const Value.absent(),
    this.termStart = const Value.absent(),
    this.termEnd = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : householdId = Value(householdId),
       name = Value(name);
  static Insertable<Member> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? relation,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? school,
    Expression<String>? notes,
    Expression<DateTime>? termStart,
    Expression<DateTime>? termEnd,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (relation != null) 'relation': relation,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (school != null) 'school': school,
      if (notes != null) 'notes': notes,
      if (termStart != null) 'term_start': termStart,
      if (termEnd != null) 'term_end': termEnd,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembersCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime?>? deletedAt,
    Value<String>? name,
    Value<String>? relation,
    Value<DateTime?>? dateOfBirth,
    Value<String?>? school,
    Value<String?>? notes,
    Value<DateTime?>? termStart,
    Value<DateTime?>? termEnd,
    Value<int>? rowid,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      relation: relation ?? this.relation,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      school: school ?? this.school,
      notes: notes ?? this.notes,
      termStart: termStart ?? this.termStart,
      termEnd: termEnd ?? this.termEnd,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (relation.present) {
      map['relation'] = Variable<String>(relation.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (school.present) {
      map['school'] = Variable<String>(school.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (termStart.present) {
      map['term_start'] = Variable<DateTime>(termStart.value);
    }
    if (termEnd.present) {
      map['term_end'] = Variable<DateTime>(termEnd.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('relation: $relation, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('school: $school, ')
          ..write('notes: $notes, ')
          ..write('termStart: $termStart, ')
          ..write('termEnd: $termEnd, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProvidersTable extends Providers
    with TableInfo<$ProvidersTable, FinProvider> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProvidersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _smsSendersMeta = const VerificationMeta(
    'smsSenders',
  );
  @override
  late final GeneratedColumn<String> smsSenders = GeneratedColumn<String>(
    'sms_senders',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, kind, smsSenders];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'providers';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinProvider> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('sms_senders')) {
      context.handle(
        _smsSendersMeta,
        smsSenders.isAcceptableOrUnknown(data['sms_senders']!, _smsSendersMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinProvider map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinProvider(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      smsSenders: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sms_senders'],
      ),
    );
  }

  @override
  $ProvidersTable createAlias(String alias) {
    return $ProvidersTable(attachedDatabase, alias);
  }
}

class FinProvider extends DataClass implements Insertable<FinProvider> {
  final String id;
  final String name;

  /// momo | bank | wallet | insurer | pension | health
  final String kind;

  /// Comma-separated SMS sender IDs used to match incoming messages.
  final String? smsSenders;
  const FinProvider({
    required this.id,
    required this.name,
    required this.kind,
    this.smsSenders,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || smsSenders != null) {
      map['sms_senders'] = Variable<String>(smsSenders);
    }
    return map;
  }

  ProvidersCompanion toCompanion(bool nullToAbsent) {
    return ProvidersCompanion(
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      smsSenders: smsSenders == null && nullToAbsent
          ? const Value.absent()
          : Value(smsSenders),
    );
  }

  factory FinProvider.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinProvider(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      smsSenders: serializer.fromJson<String?>(json['smsSenders']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'smsSenders': serializer.toJson<String?>(smsSenders),
    };
  }

  FinProvider copyWith({
    String? id,
    String? name,
    String? kind,
    Value<String?> smsSenders = const Value.absent(),
  }) => FinProvider(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    smsSenders: smsSenders.present ? smsSenders.value : this.smsSenders,
  );
  FinProvider copyWithCompanion(ProvidersCompanion data) {
    return FinProvider(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      smsSenders: data.smsSenders.present
          ? data.smsSenders.value
          : this.smsSenders,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinProvider(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('smsSenders: $smsSenders')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, kind, smsSenders);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinProvider &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.smsSenders == this.smsSenders);
}

class ProvidersCompanion extends UpdateCompanion<FinProvider> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> kind;
  final Value<String?> smsSenders;
  final Value<int> rowid;
  const ProvidersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.smsSenders = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProvidersCompanion.insert({
    required String id,
    required String name,
    required String kind,
    this.smsSenders = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       kind = Value(kind);
  static Insertable<FinProvider> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? smsSenders,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (smsSenders != null) 'sms_senders': smsSenders,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProvidersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? kind,
    Value<String?>? smsSenders,
    Value<int>? rowid,
  }) {
    return ProvidersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      smsSenders: smsSenders ?? this.smsSenders,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (smsSenders.present) {
      map['sms_senders'] = Variable<String>(smsSenders.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProvidersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('smsSenders: $smsSenders, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<String> providerId = GeneratedColumn<String>(
    'provider_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES providers (id)',
    ),
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('GHS'),
  );
  static const VerificationMeta _openingBalanceMeta = const VerificationMeta(
    'openingBalance',
  );
  @override
  late final GeneratedColumn<int> openingBalance = GeneratedColumn<int>(
    'opening_balance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _openingDateMeta = const VerificationMeta(
    'openingDate',
  );
  @override
  late final GeneratedColumn<DateTime> openingDate = GeneratedColumn<DateTime>(
    'opening_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _ownerUserIdMeta = const VerificationMeta(
    'ownerUserId',
  );
  @override
  late final GeneratedColumn<String> ownerUserId = GeneratedColumn<String>(
    'owner_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _visibilityMeta = const VerificationMeta(
    'visibility',
  );
  @override
  late final GeneratedColumn<String> visibility = GeneratedColumn<String>(
    'visibility',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('household'),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    deletedAt,
    name,
    type,
    providerId,
    number,
    currency,
    openingBalance,
    openingDate,
    ownerUserId,
    visibility,
    archived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('opening_balance')) {
      context.handle(
        _openingBalanceMeta,
        openingBalance.isAcceptableOrUnknown(
          data['opening_balance']!,
          _openingBalanceMeta,
        ),
      );
    }
    if (data.containsKey('opening_date')) {
      context.handle(
        _openingDateMeta,
        openingDate.isAcceptableOrUnknown(
          data['opening_date']!,
          _openingDateMeta,
        ),
      );
    }
    if (data.containsKey('owner_user_id')) {
      context.handle(
        _ownerUserIdMeta,
        ownerUserId.isAcceptableOrUnknown(
          data['owner_user_id']!,
          _ownerUserIdMeta,
        ),
      );
    }
    if (data.containsKey('visibility')) {
      context.handle(
        _visibilityMeta,
        visibility.isAcceptableOrUnknown(data['visibility']!, _visibilityMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_id'],
      ),
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      openingBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opening_balance'],
      )!,
      openingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opening_date'],
      )!,
      ownerUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_user_id'],
      ),
      visibility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}visibility'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final String name;

  /// momo | bank | card | cash | savings | online_wallet
  final String type;
  final String? providerId;

  /// Last 4 digits of a card/account, or the wallet phone number.
  final String? number;
  final String currency;
  final int openingBalance;
  final DateTime openingDate;
  final String? ownerUserId;

  /// household | private
  final String visibility;
  final bool archived;
  const Account({
    required this.id,
    required this.householdId,
    required this.createdAt,
    this.deletedAt,
    required this.name,
    required this.type,
    this.providerId,
    this.number,
    required this.currency,
    required this.openingBalance,
    required this.openingDate,
    this.ownerUserId,
    required this.visibility,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || providerId != null) {
      map['provider_id'] = Variable<String>(providerId);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<String>(number);
    }
    map['currency'] = Variable<String>(currency);
    map['opening_balance'] = Variable<int>(openingBalance);
    map['opening_date'] = Variable<DateTime>(openingDate);
    if (!nullToAbsent || ownerUserId != null) {
      map['owner_user_id'] = Variable<String>(ownerUserId);
    }
    map['visibility'] = Variable<String>(visibility);
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      name: Value(name),
      type: Value(type),
      providerId: providerId == null && nullToAbsent
          ? const Value.absent()
          : Value(providerId),
      number: number == null && nullToAbsent
          ? const Value.absent()
          : Value(number),
      currency: Value(currency),
      openingBalance: Value(openingBalance),
      openingDate: Value(openingDate),
      ownerUserId: ownerUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerUserId),
      visibility: Value(visibility),
      archived: Value(archived),
    );
  }

  factory Account.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      providerId: serializer.fromJson<String?>(json['providerId']),
      number: serializer.fromJson<String?>(json['number']),
      currency: serializer.fromJson<String>(json['currency']),
      openingBalance: serializer.fromJson<int>(json['openingBalance']),
      openingDate: serializer.fromJson<DateTime>(json['openingDate']),
      ownerUserId: serializer.fromJson<String?>(json['ownerUserId']),
      visibility: serializer.fromJson<String>(json['visibility']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'providerId': serializer.toJson<String?>(providerId),
      'number': serializer.toJson<String?>(number),
      'currency': serializer.toJson<String>(currency),
      'openingBalance': serializer.toJson<int>(openingBalance),
      'openingDate': serializer.toJson<DateTime>(openingDate),
      'ownerUserId': serializer.toJson<String?>(ownerUserId),
      'visibility': serializer.toJson<String>(visibility),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  Account copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? name,
    String? type,
    Value<String?> providerId = const Value.absent(),
    Value<String?> number = const Value.absent(),
    String? currency,
    int? openingBalance,
    DateTime? openingDate,
    Value<String?> ownerUserId = const Value.absent(),
    String? visibility,
    bool? archived,
  }) => Account(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    name: name ?? this.name,
    type: type ?? this.type,
    providerId: providerId.present ? providerId.value : this.providerId,
    number: number.present ? number.value : this.number,
    currency: currency ?? this.currency,
    openingBalance: openingBalance ?? this.openingBalance,
    openingDate: openingDate ?? this.openingDate,
    ownerUserId: ownerUserId.present ? ownerUserId.value : this.ownerUserId,
    visibility: visibility ?? this.visibility,
    archived: archived ?? this.archived,
  );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      number: data.number.present ? data.number.value : this.number,
      currency: data.currency.present ? data.currency.value : this.currency,
      openingBalance: data.openingBalance.present
          ? data.openingBalance.value
          : this.openingBalance,
      openingDate: data.openingDate.present
          ? data.openingDate.value
          : this.openingDate,
      ownerUserId: data.ownerUserId.present
          ? data.ownerUserId.value
          : this.ownerUserId,
      visibility: data.visibility.present
          ? data.visibility.value
          : this.visibility,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('providerId: $providerId, ')
          ..write('number: $number, ')
          ..write('currency: $currency, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('openingDate: $openingDate, ')
          ..write('ownerUserId: $ownerUserId, ')
          ..write('visibility: $visibility, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    deletedAt,
    name,
    type,
    providerId,
    number,
    currency,
    openingBalance,
    openingDate,
    ownerUserId,
    visibility,
    archived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.type == this.type &&
          other.providerId == this.providerId &&
          other.number == this.number &&
          other.currency == this.currency &&
          other.openingBalance == this.openingBalance &&
          other.openingDate == this.openingDate &&
          other.ownerUserId == this.ownerUserId &&
          other.visibility == this.visibility &&
          other.archived == this.archived);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<String> type;
  final Value<String?> providerId;
  final Value<String?> number;
  final Value<String> currency;
  final Value<int> openingBalance;
  final Value<DateTime> openingDate;
  final Value<String?> ownerUserId;
  final Value<String> visibility;
  final Value<bool> archived;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.providerId = const Value.absent(),
    this.number = const Value.absent(),
    this.currency = const Value.absent(),
    this.openingBalance = const Value.absent(),
    this.openingDate = const Value.absent(),
    this.ownerUserId = const Value.absent(),
    this.visibility = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required String householdId,
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    required String type,
    this.providerId = const Value.absent(),
    this.number = const Value.absent(),
    this.currency = const Value.absent(),
    this.openingBalance = const Value.absent(),
    this.openingDate = const Value.absent(),
    this.ownerUserId = const Value.absent(),
    this.visibility = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : householdId = Value(householdId),
       name = Value(name),
       type = Value(type);
  static Insertable<Account> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? providerId,
    Expression<String>? number,
    Expression<String>? currency,
    Expression<int>? openingBalance,
    Expression<DateTime>? openingDate,
    Expression<String>? ownerUserId,
    Expression<String>? visibility,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (providerId != null) 'provider_id': providerId,
      if (number != null) 'number': number,
      if (currency != null) 'currency': currency,
      if (openingBalance != null) 'opening_balance': openingBalance,
      if (openingDate != null) 'opening_date': openingDate,
      if (ownerUserId != null) 'owner_user_id': ownerUserId,
      if (visibility != null) 'visibility': visibility,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime?>? deletedAt,
    Value<String>? name,
    Value<String>? type,
    Value<String?>? providerId,
    Value<String?>? number,
    Value<String>? currency,
    Value<int>? openingBalance,
    Value<DateTime>? openingDate,
    Value<String?>? ownerUserId,
    Value<String>? visibility,
    Value<bool>? archived,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      type: type ?? this.type,
      providerId: providerId ?? this.providerId,
      number: number ?? this.number,
      currency: currency ?? this.currency,
      openingBalance: openingBalance ?? this.openingBalance,
      openingDate: openingDate ?? this.openingDate,
      ownerUserId: ownerUserId ?? this.ownerUserId,
      visibility: visibility ?? this.visibility,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (openingBalance.present) {
      map['opening_balance'] = Variable<int>(openingBalance.value);
    }
    if (openingDate.present) {
      map['opening_date'] = Variable<DateTime>(openingDate.value);
    }
    if (ownerUserId.present) {
      map['owner_user_id'] = Variable<String>(ownerUserId.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<String>(visibility.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('providerId: $providerId, ')
          ..write('number: $number, ')
          ..write('currency: $currency, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('openingDate: $openingDate, ')
          ..write('ownerUserId: $ownerUserId, ')
          ..write('visibility: $visibility, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('other'),
  );
  static const VerificationMeta _systemKeyMeta = const VerificationMeta(
    'systemKey',
  );
  @override
  late final GeneratedColumn<String> systemKey = GeneratedColumn<String>(
    'system_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    deletedAt,
    name,
    kind,
    parentId,
    iconKey,
    systemKey,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    if (data.containsKey('system_key')) {
      context.handle(
        _systemKeyMeta,
        systemKey.isAcceptableOrUnknown(data['system_key']!, _systemKeyMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      )!,
      systemKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_key'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final String name;

  /// income | expense
  final String kind;
  final String? parentId;

  /// Picks the icon and colour in the UI: food, transport, school, ...
  final String iconKey;

  /// Stable key for seeded categories (e.g. "fees.momo"), so code can find
  /// them without depending on their display name.
  final String? systemKey;
  final int sortOrder;
  const Category({
    required this.id,
    required this.householdId,
    required this.createdAt,
    this.deletedAt,
    required this.name,
    required this.kind,
    this.parentId,
    required this.iconKey,
    this.systemKey,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['icon_key'] = Variable<String>(iconKey);
    if (!nullToAbsent || systemKey != null) {
      map['system_key'] = Variable<String>(systemKey);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      name: Value(name),
      kind: Value(kind),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      iconKey: Value(iconKey),
      systemKey: systemKey == null && nullToAbsent
          ? const Value.absent()
          : Value(systemKey),
      sortOrder: Value(sortOrder),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      systemKey: serializer.fromJson<String?>(json['systemKey']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'parentId': serializer.toJson<String?>(parentId),
      'iconKey': serializer.toJson<String>(iconKey),
      'systemKey': serializer.toJson<String?>(systemKey),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Category copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? name,
    String? kind,
    Value<String?> parentId = const Value.absent(),
    String? iconKey,
    Value<String?> systemKey = const Value.absent(),
    int? sortOrder,
  }) => Category(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    parentId: parentId.present ? parentId.value : this.parentId,
    iconKey: iconKey ?? this.iconKey,
    systemKey: systemKey.present ? systemKey.value : this.systemKey,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      systemKey: data.systemKey.present ? data.systemKey.value : this.systemKey,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('parentId: $parentId, ')
          ..write('iconKey: $iconKey, ')
          ..write('systemKey: $systemKey, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    deletedAt,
    name,
    kind,
    parentId,
    iconKey,
    systemKey,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.parentId == this.parentId &&
          other.iconKey == this.iconKey &&
          other.systemKey == this.systemKey &&
          other.sortOrder == this.sortOrder);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<String> kind;
  final Value<String?> parentId;
  final Value<String> iconKey;
  final Value<String?> systemKey;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.parentId = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.systemKey = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String householdId,
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    required String kind,
    this.parentId = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.systemKey = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : householdId = Value(householdId),
       name = Value(name),
       kind = Value(kind);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? parentId,
    Expression<String>? iconKey,
    Expression<String>? systemKey,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (parentId != null) 'parent_id': parentId,
      if (iconKey != null) 'icon_key': iconKey,
      if (systemKey != null) 'system_key': systemKey,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime?>? deletedAt,
    Value<String>? name,
    Value<String>? kind,
    Value<String?>? parentId,
    Value<String>? iconKey,
    Value<String?>? systemKey,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      parentId: parentId ?? this.parentId,
      iconKey: iconKey ?? this.iconKey,
      systemKey: systemKey ?? this.systemKey,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (systemKey.present) {
      map['system_key'] = Variable<String>(systemKey.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('parentId: $parentId, ')
          ..write('iconKey: $iconKey, ')
          ..write('systemKey: $systemKey, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TxnsTable extends Txns with TableInfo<$TxnsTable, Txn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TxnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _policyIdMeta = const VerificationMeta(
    'policyId',
  );
  @override
  late final GeneratedColumn<String> policyId = GeneratedColumn<String>(
    'policy_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payeeMeta = const VerificationMeta('payee');
  @override
  late final GeneratedColumn<String> payee = GeneratedColumn<String>(
    'payee',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('posted'),
  );
  static const VerificationMeta _smsRefMeta = const VerificationMeta('smsRef');
  @override
  late final GeneratedColumn<String> smsRef = GeneratedColumn<String>(
    'sms_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transferGroupIdMeta = const VerificationMeta(
    'transferGroupId',
  );
  @override
  late final GeneratedColumn<String> transferGroupId = GeneratedColumn<String>(
    'transfer_group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _feeOfIdMeta = const VerificationMeta(
    'feeOfId',
  );
  @override
  late final GeneratedColumn<String> feeOfId = GeneratedColumn<String>(
    'fee_of_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByUserIdMeta = const VerificationMeta(
    'createdByUserId',
  );
  @override
  late final GeneratedColumn<String> createdByUserId = GeneratedColumn<String>(
    'created_by_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    deletedAt,
    type,
    amount,
    date,
    accountId,
    categoryId,
    memberId,
    policyId,
    payee,
    note,
    source,
    status,
    smsRef,
    transferGroupId,
    feeOfId,
    createdByUserId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'txns';
  @override
  VerificationContext validateIntegrity(
    Insertable<Txn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    }
    if (data.containsKey('policy_id')) {
      context.handle(
        _policyIdMeta,
        policyId.isAcceptableOrUnknown(data['policy_id']!, _policyIdMeta),
      );
    }
    if (data.containsKey('payee')) {
      context.handle(
        _payeeMeta,
        payee.isAcceptableOrUnknown(data['payee']!, _payeeMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('sms_ref')) {
      context.handle(
        _smsRefMeta,
        smsRef.isAcceptableOrUnknown(data['sms_ref']!, _smsRefMeta),
      );
    }
    if (data.containsKey('transfer_group_id')) {
      context.handle(
        _transferGroupIdMeta,
        transferGroupId.isAcceptableOrUnknown(
          data['transfer_group_id']!,
          _transferGroupIdMeta,
        ),
      );
    }
    if (data.containsKey('fee_of_id')) {
      context.handle(
        _feeOfIdMeta,
        feeOfId.isAcceptableOrUnknown(data['fee_of_id']!, _feeOfIdMeta),
      );
    }
    if (data.containsKey('created_by_user_id')) {
      context.handle(
        _createdByUserIdMeta,
        createdByUserId.isAcceptableOrUnknown(
          data['created_by_user_id']!,
          _createdByUserIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Txn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Txn(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      ),
      policyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}policy_id'],
      ),
      payee: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payee'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      smsRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sms_ref'],
      ),
      transferGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_group_id'],
      ),
      feeOfId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fee_of_id'],
      ),
      createdByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by_user_id'],
      ),
    );
  }

  @override
  $TxnsTable createAlias(String alias) {
    return $TxnsTable(attachedDatabase, alias);
  }
}

class Txn extends DataClass implements Insertable<Txn> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime? deletedAt;

  /// income | expense | transfer_out | transfer_in
  final String type;

  /// Always positive, in the account's minor units; [type] gives direction.
  final int amount;
  final DateTime date;
  final String accountId;
  final String? categoryId;
  final String? memberId;
  final String? policyId;
  final String? payee;
  final String? note;

  /// manual | sms | import
  final String source;

  /// posted | draft. Drafts come from SMS and wait for the owner to confirm.
  final String status;
  final String? smsRef;
  final String? transferGroupId;
  final String? feeOfId;
  final String? createdByUserId;
  const Txn({
    required this.id,
    required this.householdId,
    required this.createdAt,
    this.deletedAt,
    required this.type,
    required this.amount,
    required this.date,
    required this.accountId,
    this.categoryId,
    this.memberId,
    this.policyId,
    this.payee,
    this.note,
    required this.source,
    required this.status,
    this.smsRef,
    this.transferGroupId,
    this.feeOfId,
    this.createdByUserId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<int>(amount);
    map['date'] = Variable<DateTime>(date);
    map['account_id'] = Variable<String>(accountId);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || memberId != null) {
      map['member_id'] = Variable<String>(memberId);
    }
    if (!nullToAbsent || policyId != null) {
      map['policy_id'] = Variable<String>(policyId);
    }
    if (!nullToAbsent || payee != null) {
      map['payee'] = Variable<String>(payee);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['source'] = Variable<String>(source);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || smsRef != null) {
      map['sms_ref'] = Variable<String>(smsRef);
    }
    if (!nullToAbsent || transferGroupId != null) {
      map['transfer_group_id'] = Variable<String>(transferGroupId);
    }
    if (!nullToAbsent || feeOfId != null) {
      map['fee_of_id'] = Variable<String>(feeOfId);
    }
    if (!nullToAbsent || createdByUserId != null) {
      map['created_by_user_id'] = Variable<String>(createdByUserId);
    }
    return map;
  }

  TxnsCompanion toCompanion(bool nullToAbsent) {
    return TxnsCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      type: Value(type),
      amount: Value(amount),
      date: Value(date),
      accountId: Value(accountId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      memberId: memberId == null && nullToAbsent
          ? const Value.absent()
          : Value(memberId),
      policyId: policyId == null && nullToAbsent
          ? const Value.absent()
          : Value(policyId),
      payee: payee == null && nullToAbsent
          ? const Value.absent()
          : Value(payee),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      source: Value(source),
      status: Value(status),
      smsRef: smsRef == null && nullToAbsent
          ? const Value.absent()
          : Value(smsRef),
      transferGroupId: transferGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(transferGroupId),
      feeOfId: feeOfId == null && nullToAbsent
          ? const Value.absent()
          : Value(feeOfId),
      createdByUserId: createdByUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(createdByUserId),
    );
  }

  factory Txn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Txn(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<int>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      accountId: serializer.fromJson<String>(json['accountId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      memberId: serializer.fromJson<String?>(json['memberId']),
      policyId: serializer.fromJson<String?>(json['policyId']),
      payee: serializer.fromJson<String?>(json['payee']),
      note: serializer.fromJson<String?>(json['note']),
      source: serializer.fromJson<String>(json['source']),
      status: serializer.fromJson<String>(json['status']),
      smsRef: serializer.fromJson<String?>(json['smsRef']),
      transferGroupId: serializer.fromJson<String?>(json['transferGroupId']),
      feeOfId: serializer.fromJson<String?>(json['feeOfId']),
      createdByUserId: serializer.fromJson<String?>(json['createdByUserId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<int>(amount),
      'date': serializer.toJson<DateTime>(date),
      'accountId': serializer.toJson<String>(accountId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'memberId': serializer.toJson<String?>(memberId),
      'policyId': serializer.toJson<String?>(policyId),
      'payee': serializer.toJson<String?>(payee),
      'note': serializer.toJson<String?>(note),
      'source': serializer.toJson<String>(source),
      'status': serializer.toJson<String>(status),
      'smsRef': serializer.toJson<String?>(smsRef),
      'transferGroupId': serializer.toJson<String?>(transferGroupId),
      'feeOfId': serializer.toJson<String?>(feeOfId),
      'createdByUserId': serializer.toJson<String?>(createdByUserId),
    };
  }

  Txn copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? type,
    int? amount,
    DateTime? date,
    String? accountId,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> memberId = const Value.absent(),
    Value<String?> policyId = const Value.absent(),
    Value<String?> payee = const Value.absent(),
    Value<String?> note = const Value.absent(),
    String? source,
    String? status,
    Value<String?> smsRef = const Value.absent(),
    Value<String?> transferGroupId = const Value.absent(),
    Value<String?> feeOfId = const Value.absent(),
    Value<String?> createdByUserId = const Value.absent(),
  }) => Txn(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    accountId: accountId ?? this.accountId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    memberId: memberId.present ? memberId.value : this.memberId,
    policyId: policyId.present ? policyId.value : this.policyId,
    payee: payee.present ? payee.value : this.payee,
    note: note.present ? note.value : this.note,
    source: source ?? this.source,
    status: status ?? this.status,
    smsRef: smsRef.present ? smsRef.value : this.smsRef,
    transferGroupId: transferGroupId.present
        ? transferGroupId.value
        : this.transferGroupId,
    feeOfId: feeOfId.present ? feeOfId.value : this.feeOfId,
    createdByUserId: createdByUserId.present
        ? createdByUserId.value
        : this.createdByUserId,
  );
  Txn copyWithCompanion(TxnsCompanion data) {
    return Txn(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      policyId: data.policyId.present ? data.policyId.value : this.policyId,
      payee: data.payee.present ? data.payee.value : this.payee,
      note: data.note.present ? data.note.value : this.note,
      source: data.source.present ? data.source.value : this.source,
      status: data.status.present ? data.status.value : this.status,
      smsRef: data.smsRef.present ? data.smsRef.value : this.smsRef,
      transferGroupId: data.transferGroupId.present
          ? data.transferGroupId.value
          : this.transferGroupId,
      feeOfId: data.feeOfId.present ? data.feeOfId.value : this.feeOfId,
      createdByUserId: data.createdByUserId.present
          ? data.createdByUserId.value
          : this.createdByUserId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Txn(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('memberId: $memberId, ')
          ..write('policyId: $policyId, ')
          ..write('payee: $payee, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('status: $status, ')
          ..write('smsRef: $smsRef, ')
          ..write('transferGroupId: $transferGroupId, ')
          ..write('feeOfId: $feeOfId, ')
          ..write('createdByUserId: $createdByUserId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    deletedAt,
    type,
    amount,
    date,
    accountId,
    categoryId,
    memberId,
    policyId,
    payee,
    note,
    source,
    status,
    smsRef,
    transferGroupId,
    feeOfId,
    createdByUserId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Txn &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.memberId == this.memberId &&
          other.policyId == this.policyId &&
          other.payee == this.payee &&
          other.note == this.note &&
          other.source == this.source &&
          other.status == this.status &&
          other.smsRef == this.smsRef &&
          other.transferGroupId == this.transferGroupId &&
          other.feeOfId == this.feeOfId &&
          other.createdByUserId == this.createdByUserId);
}

class TxnsCompanion extends UpdateCompanion<Txn> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<String> type;
  final Value<int> amount;
  final Value<DateTime> date;
  final Value<String> accountId;
  final Value<String?> categoryId;
  final Value<String?> memberId;
  final Value<String?> policyId;
  final Value<String?> payee;
  final Value<String?> note;
  final Value<String> source;
  final Value<String> status;
  final Value<String?> smsRef;
  final Value<String?> transferGroupId;
  final Value<String?> feeOfId;
  final Value<String?> createdByUserId;
  final Value<int> rowid;
  const TxnsCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.policyId = const Value.absent(),
    this.payee = const Value.absent(),
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.status = const Value.absent(),
    this.smsRef = const Value.absent(),
    this.transferGroupId = const Value.absent(),
    this.feeOfId = const Value.absent(),
    this.createdByUserId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TxnsCompanion.insert({
    this.id = const Value.absent(),
    required String householdId,
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String type,
    required int amount,
    required DateTime date,
    required String accountId,
    this.categoryId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.policyId = const Value.absent(),
    this.payee = const Value.absent(),
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.status = const Value.absent(),
    this.smsRef = const Value.absent(),
    this.transferGroupId = const Value.absent(),
    this.feeOfId = const Value.absent(),
    this.createdByUserId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : householdId = Value(householdId),
       type = Value(type),
       amount = Value(amount),
       date = Value(date),
       accountId = Value(accountId);
  static Insertable<Txn> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? type,
    Expression<int>? amount,
    Expression<DateTime>? date,
    Expression<String>? accountId,
    Expression<String>? categoryId,
    Expression<String>? memberId,
    Expression<String>? policyId,
    Expression<String>? payee,
    Expression<String>? note,
    Expression<String>? source,
    Expression<String>? status,
    Expression<String>? smsRef,
    Expression<String>? transferGroupId,
    Expression<String>? feeOfId,
    Expression<String>? createdByUserId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (memberId != null) 'member_id': memberId,
      if (policyId != null) 'policy_id': policyId,
      if (payee != null) 'payee': payee,
      if (note != null) 'note': note,
      if (source != null) 'source': source,
      if (status != null) 'status': status,
      if (smsRef != null) 'sms_ref': smsRef,
      if (transferGroupId != null) 'transfer_group_id': transferGroupId,
      if (feeOfId != null) 'fee_of_id': feeOfId,
      if (createdByUserId != null) 'created_by_user_id': createdByUserId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TxnsCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime?>? deletedAt,
    Value<String>? type,
    Value<int>? amount,
    Value<DateTime>? date,
    Value<String>? accountId,
    Value<String?>? categoryId,
    Value<String?>? memberId,
    Value<String?>? policyId,
    Value<String?>? payee,
    Value<String?>? note,
    Value<String>? source,
    Value<String>? status,
    Value<String?>? smsRef,
    Value<String?>? transferGroupId,
    Value<String?>? feeOfId,
    Value<String?>? createdByUserId,
    Value<int>? rowid,
  }) {
    return TxnsCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      memberId: memberId ?? this.memberId,
      policyId: policyId ?? this.policyId,
      payee: payee ?? this.payee,
      note: note ?? this.note,
      source: source ?? this.source,
      status: status ?? this.status,
      smsRef: smsRef ?? this.smsRef,
      transferGroupId: transferGroupId ?? this.transferGroupId,
      feeOfId: feeOfId ?? this.feeOfId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (policyId.present) {
      map['policy_id'] = Variable<String>(policyId.value);
    }
    if (payee.present) {
      map['payee'] = Variable<String>(payee.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (smsRef.present) {
      map['sms_ref'] = Variable<String>(smsRef.value);
    }
    if (transferGroupId.present) {
      map['transfer_group_id'] = Variable<String>(transferGroupId.value);
    }
    if (feeOfId.present) {
      map['fee_of_id'] = Variable<String>(feeOfId.value);
    }
    if (createdByUserId.present) {
      map['created_by_user_id'] = Variable<String>(createdByUserId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TxnsCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('memberId: $memberId, ')
          ..write('policyId: $policyId, ')
          ..write('payee: $payee, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('status: $status, ')
          ..write('smsRef: $smsRef, ')
          ..write('transferGroupId: $transferGroupId, ')
          ..write('feeOfId: $feeOfId, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InsurancePoliciesTable extends InsurancePolicies
    with TableInfo<$InsurancePoliciesTable, InsurancePolicy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InsurancePoliciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<String> providerId = GeneratedColumn<String>(
    'provider_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES providers (id)',
    ),
  );
  static const VerificationMeta _providerNameMeta = const VerificationMeta(
    'providerName',
  );
  @override
  late final GeneratedColumn<String> providerName = GeneratedColumn<String>(
    'provider_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _policyNumberMeta = const VerificationMeta(
    'policyNumber',
  );
  @override
  late final GeneratedColumn<String> policyNumber = GeneratedColumn<String>(
    'policy_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _insuredMemberIdMeta = const VerificationMeta(
    'insuredMemberId',
  );
  @override
  late final GeneratedColumn<String> insuredMemberId = GeneratedColumn<String>(
    'insured_member_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _premiumMeta = const VerificationMeta(
    'premium',
  );
  @override
  late final GeneratedColumn<int> premium = GeneratedColumn<int>(
    'premium',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('GHS'),
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('monthly'),
  );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
    'next_due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDayMeta = const VerificationMeta('dueDay');
  @override
  late final GeneratedColumn<int> dueDay = GeneratedColumn<int>(
    'due_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverAmountMeta = const VerificationMeta(
    'coverAmount',
  );
  @override
  late final GeneratedColumn<int> coverAmount = GeneratedColumn<int>(
    'cover_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payFromAccountIdMeta = const VerificationMeta(
    'payFromAccountId',
  );
  @override
  late final GeneratedColumn<String> payFromAccountId = GeneratedColumn<String>(
    'pay_from_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    deletedAt,
    providerId,
    providerName,
    type,
    policyNumber,
    insuredMemberId,
    premium,
    currency,
    frequency,
    nextDueDate,
    dueDay,
    coverAmount,
    payFromAccountId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'insurance_policies';
  @override
  VerificationContext validateIntegrity(
    Insertable<InsurancePolicy> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    }
    if (data.containsKey('provider_name')) {
      context.handle(
        _providerNameMeta,
        providerName.isAcceptableOrUnknown(
          data['provider_name']!,
          _providerNameMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('policy_number')) {
      context.handle(
        _policyNumberMeta,
        policyNumber.isAcceptableOrUnknown(
          data['policy_number']!,
          _policyNumberMeta,
        ),
      );
    }
    if (data.containsKey('insured_member_id')) {
      context.handle(
        _insuredMemberIdMeta,
        insuredMemberId.isAcceptableOrUnknown(
          data['insured_member_id']!,
          _insuredMemberIdMeta,
        ),
      );
    }
    if (data.containsKey('premium')) {
      context.handle(
        _premiumMeta,
        premium.isAcceptableOrUnknown(data['premium']!, _premiumMeta),
      );
    } else if (isInserting) {
      context.missing(_premiumMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextDueDateMeta);
    }
    if (data.containsKey('due_day')) {
      context.handle(
        _dueDayMeta,
        dueDay.isAcceptableOrUnknown(data['due_day']!, _dueDayMeta),
      );
    }
    if (data.containsKey('cover_amount')) {
      context.handle(
        _coverAmountMeta,
        coverAmount.isAcceptableOrUnknown(
          data['cover_amount']!,
          _coverAmountMeta,
        ),
      );
    }
    if (data.containsKey('pay_from_account_id')) {
      context.handle(
        _payFromAccountIdMeta,
        payFromAccountId.isAcceptableOrUnknown(
          data['pay_from_account_id']!,
          _payFromAccountIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InsurancePolicy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InsurancePolicy(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_id'],
      ),
      providerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_name'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      policyNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}policy_number'],
      ),
      insuredMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}insured_member_id'],
      ),
      premium: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}premium'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_date'],
      )!,
      dueDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_day'],
      ),
      coverAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cover_amount'],
      ),
      payFromAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pay_from_account_id'],
      ),
    );
  }

  @override
  $InsurancePoliciesTable createAlias(String alias) {
    return $InsurancePoliciesTable(attachedDatabase, alias);
  }
}

class InsurancePolicy extends DataClass implements Insertable<InsurancePolicy> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final String? providerId;

  /// Free text when the provider is "Other" or not in the list yet.
  final String? providerName;

  /// life | health | motor | education | funeral | pension
  final String type;
  final String? policyNumber;
  final String? insuredMemberId;
  final int premium;
  final String currency;

  /// monthly | quarterly | termly | yearly
  final String frequency;
  final DateTime nextDueDate;

  /// Day of the month premiums fall due, so 31 Jan -> 28 Feb -> 31 Mar.
  final int? dueDay;
  final int? coverAmount;
  final String? payFromAccountId;
  const InsurancePolicy({
    required this.id,
    required this.householdId,
    required this.createdAt,
    this.deletedAt,
    this.providerId,
    this.providerName,
    required this.type,
    this.policyNumber,
    this.insuredMemberId,
    required this.premium,
    required this.currency,
    required this.frequency,
    required this.nextDueDate,
    this.dueDay,
    this.coverAmount,
    this.payFromAccountId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || providerId != null) {
      map['provider_id'] = Variable<String>(providerId);
    }
    if (!nullToAbsent || providerName != null) {
      map['provider_name'] = Variable<String>(providerName);
    }
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || policyNumber != null) {
      map['policy_number'] = Variable<String>(policyNumber);
    }
    if (!nullToAbsent || insuredMemberId != null) {
      map['insured_member_id'] = Variable<String>(insuredMemberId);
    }
    map['premium'] = Variable<int>(premium);
    map['currency'] = Variable<String>(currency);
    map['frequency'] = Variable<String>(frequency);
    map['next_due_date'] = Variable<DateTime>(nextDueDate);
    if (!nullToAbsent || dueDay != null) {
      map['due_day'] = Variable<int>(dueDay);
    }
    if (!nullToAbsent || coverAmount != null) {
      map['cover_amount'] = Variable<int>(coverAmount);
    }
    if (!nullToAbsent || payFromAccountId != null) {
      map['pay_from_account_id'] = Variable<String>(payFromAccountId);
    }
    return map;
  }

  InsurancePoliciesCompanion toCompanion(bool nullToAbsent) {
    return InsurancePoliciesCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      providerId: providerId == null && nullToAbsent
          ? const Value.absent()
          : Value(providerId),
      providerName: providerName == null && nullToAbsent
          ? const Value.absent()
          : Value(providerName),
      type: Value(type),
      policyNumber: policyNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(policyNumber),
      insuredMemberId: insuredMemberId == null && nullToAbsent
          ? const Value.absent()
          : Value(insuredMemberId),
      premium: Value(premium),
      currency: Value(currency),
      frequency: Value(frequency),
      nextDueDate: Value(nextDueDate),
      dueDay: dueDay == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDay),
      coverAmount: coverAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(coverAmount),
      payFromAccountId: payFromAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(payFromAccountId),
    );
  }

  factory InsurancePolicy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InsurancePolicy(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      providerId: serializer.fromJson<String?>(json['providerId']),
      providerName: serializer.fromJson<String?>(json['providerName']),
      type: serializer.fromJson<String>(json['type']),
      policyNumber: serializer.fromJson<String?>(json['policyNumber']),
      insuredMemberId: serializer.fromJson<String?>(json['insuredMemberId']),
      premium: serializer.fromJson<int>(json['premium']),
      currency: serializer.fromJson<String>(json['currency']),
      frequency: serializer.fromJson<String>(json['frequency']),
      nextDueDate: serializer.fromJson<DateTime>(json['nextDueDate']),
      dueDay: serializer.fromJson<int?>(json['dueDay']),
      coverAmount: serializer.fromJson<int?>(json['coverAmount']),
      payFromAccountId: serializer.fromJson<String?>(json['payFromAccountId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'providerId': serializer.toJson<String?>(providerId),
      'providerName': serializer.toJson<String?>(providerName),
      'type': serializer.toJson<String>(type),
      'policyNumber': serializer.toJson<String?>(policyNumber),
      'insuredMemberId': serializer.toJson<String?>(insuredMemberId),
      'premium': serializer.toJson<int>(premium),
      'currency': serializer.toJson<String>(currency),
      'frequency': serializer.toJson<String>(frequency),
      'nextDueDate': serializer.toJson<DateTime>(nextDueDate),
      'dueDay': serializer.toJson<int?>(dueDay),
      'coverAmount': serializer.toJson<int?>(coverAmount),
      'payFromAccountId': serializer.toJson<String?>(payFromAccountId),
    };
  }

  InsurancePolicy copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<String?> providerId = const Value.absent(),
    Value<String?> providerName = const Value.absent(),
    String? type,
    Value<String?> policyNumber = const Value.absent(),
    Value<String?> insuredMemberId = const Value.absent(),
    int? premium,
    String? currency,
    String? frequency,
    DateTime? nextDueDate,
    Value<int?> dueDay = const Value.absent(),
    Value<int?> coverAmount = const Value.absent(),
    Value<String?> payFromAccountId = const Value.absent(),
  }) => InsurancePolicy(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    providerId: providerId.present ? providerId.value : this.providerId,
    providerName: providerName.present ? providerName.value : this.providerName,
    type: type ?? this.type,
    policyNumber: policyNumber.present ? policyNumber.value : this.policyNumber,
    insuredMemberId: insuredMemberId.present
        ? insuredMemberId.value
        : this.insuredMemberId,
    premium: premium ?? this.premium,
    currency: currency ?? this.currency,
    frequency: frequency ?? this.frequency,
    nextDueDate: nextDueDate ?? this.nextDueDate,
    dueDay: dueDay.present ? dueDay.value : this.dueDay,
    coverAmount: coverAmount.present ? coverAmount.value : this.coverAmount,
    payFromAccountId: payFromAccountId.present
        ? payFromAccountId.value
        : this.payFromAccountId,
  );
  InsurancePolicy copyWithCompanion(InsurancePoliciesCompanion data) {
    return InsurancePolicy(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      providerName: data.providerName.present
          ? data.providerName.value
          : this.providerName,
      type: data.type.present ? data.type.value : this.type,
      policyNumber: data.policyNumber.present
          ? data.policyNumber.value
          : this.policyNumber,
      insuredMemberId: data.insuredMemberId.present
          ? data.insuredMemberId.value
          : this.insuredMemberId,
      premium: data.premium.present ? data.premium.value : this.premium,
      currency: data.currency.present ? data.currency.value : this.currency,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
      dueDay: data.dueDay.present ? data.dueDay.value : this.dueDay,
      coverAmount: data.coverAmount.present
          ? data.coverAmount.value
          : this.coverAmount,
      payFromAccountId: data.payFromAccountId.present
          ? data.payFromAccountId.value
          : this.payFromAccountId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InsurancePolicy(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('providerId: $providerId, ')
          ..write('providerName: $providerName, ')
          ..write('type: $type, ')
          ..write('policyNumber: $policyNumber, ')
          ..write('insuredMemberId: $insuredMemberId, ')
          ..write('premium: $premium, ')
          ..write('currency: $currency, ')
          ..write('frequency: $frequency, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('dueDay: $dueDay, ')
          ..write('coverAmount: $coverAmount, ')
          ..write('payFromAccountId: $payFromAccountId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    deletedAt,
    providerId,
    providerName,
    type,
    policyNumber,
    insuredMemberId,
    premium,
    currency,
    frequency,
    nextDueDate,
    dueDay,
    coverAmount,
    payFromAccountId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InsurancePolicy &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.providerId == this.providerId &&
          other.providerName == this.providerName &&
          other.type == this.type &&
          other.policyNumber == this.policyNumber &&
          other.insuredMemberId == this.insuredMemberId &&
          other.premium == this.premium &&
          other.currency == this.currency &&
          other.frequency == this.frequency &&
          other.nextDueDate == this.nextDueDate &&
          other.dueDay == this.dueDay &&
          other.coverAmount == this.coverAmount &&
          other.payFromAccountId == this.payFromAccountId);
}

class InsurancePoliciesCompanion extends UpdateCompanion<InsurancePolicy> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<String?> providerId;
  final Value<String?> providerName;
  final Value<String> type;
  final Value<String?> policyNumber;
  final Value<String?> insuredMemberId;
  final Value<int> premium;
  final Value<String> currency;
  final Value<String> frequency;
  final Value<DateTime> nextDueDate;
  final Value<int?> dueDay;
  final Value<int?> coverAmount;
  final Value<String?> payFromAccountId;
  final Value<int> rowid;
  const InsurancePoliciesCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.providerId = const Value.absent(),
    this.providerName = const Value.absent(),
    this.type = const Value.absent(),
    this.policyNumber = const Value.absent(),
    this.insuredMemberId = const Value.absent(),
    this.premium = const Value.absent(),
    this.currency = const Value.absent(),
    this.frequency = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.coverAmount = const Value.absent(),
    this.payFromAccountId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InsurancePoliciesCompanion.insert({
    this.id = const Value.absent(),
    required String householdId,
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.providerId = const Value.absent(),
    this.providerName = const Value.absent(),
    required String type,
    this.policyNumber = const Value.absent(),
    this.insuredMemberId = const Value.absent(),
    required int premium,
    this.currency = const Value.absent(),
    this.frequency = const Value.absent(),
    required DateTime nextDueDate,
    this.dueDay = const Value.absent(),
    this.coverAmount = const Value.absent(),
    this.payFromAccountId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : householdId = Value(householdId),
       type = Value(type),
       premium = Value(premium),
       nextDueDate = Value(nextDueDate);
  static Insertable<InsurancePolicy> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? providerId,
    Expression<String>? providerName,
    Expression<String>? type,
    Expression<String>? policyNumber,
    Expression<String>? insuredMemberId,
    Expression<int>? premium,
    Expression<String>? currency,
    Expression<String>? frequency,
    Expression<DateTime>? nextDueDate,
    Expression<int>? dueDay,
    Expression<int>? coverAmount,
    Expression<String>? payFromAccountId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (providerId != null) 'provider_id': providerId,
      if (providerName != null) 'provider_name': providerName,
      if (type != null) 'type': type,
      if (policyNumber != null) 'policy_number': policyNumber,
      if (insuredMemberId != null) 'insured_member_id': insuredMemberId,
      if (premium != null) 'premium': premium,
      if (currency != null) 'currency': currency,
      if (frequency != null) 'frequency': frequency,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (dueDay != null) 'due_day': dueDay,
      if (coverAmount != null) 'cover_amount': coverAmount,
      if (payFromAccountId != null) 'pay_from_account_id': payFromAccountId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InsurancePoliciesCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime?>? deletedAt,
    Value<String?>? providerId,
    Value<String?>? providerName,
    Value<String>? type,
    Value<String?>? policyNumber,
    Value<String?>? insuredMemberId,
    Value<int>? premium,
    Value<String>? currency,
    Value<String>? frequency,
    Value<DateTime>? nextDueDate,
    Value<int?>? dueDay,
    Value<int?>? coverAmount,
    Value<String?>? payFromAccountId,
    Value<int>? rowid,
  }) {
    return InsurancePoliciesCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      providerId: providerId ?? this.providerId,
      providerName: providerName ?? this.providerName,
      type: type ?? this.type,
      policyNumber: policyNumber ?? this.policyNumber,
      insuredMemberId: insuredMemberId ?? this.insuredMemberId,
      premium: premium ?? this.premium,
      currency: currency ?? this.currency,
      frequency: frequency ?? this.frequency,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      dueDay: dueDay ?? this.dueDay,
      coverAmount: coverAmount ?? this.coverAmount,
      payFromAccountId: payFromAccountId ?? this.payFromAccountId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (providerName.present) {
      map['provider_name'] = Variable<String>(providerName.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (policyNumber.present) {
      map['policy_number'] = Variable<String>(policyNumber.value);
    }
    if (insuredMemberId.present) {
      map['insured_member_id'] = Variable<String>(insuredMemberId.value);
    }
    if (premium.present) {
      map['premium'] = Variable<int>(premium.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (dueDay.present) {
      map['due_day'] = Variable<int>(dueDay.value);
    }
    if (coverAmount.present) {
      map['cover_amount'] = Variable<int>(coverAmount.value);
    }
    if (payFromAccountId.present) {
      map['pay_from_account_id'] = Variable<String>(payFromAccountId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InsurancePoliciesCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('providerId: $providerId, ')
          ..write('providerName: $providerName, ')
          ..write('type: $type, ')
          ..write('policyNumber: $policyNumber, ')
          ..write('insuredMemberId: $insuredMemberId, ')
          ..write('premium: $premium, ')
          ..write('currency: $currency, ')
          ..write('frequency: $frequency, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('dueDay: $dueDay, ')
          ..write('coverAmount: $coverAmount, ')
          ..write('payFromAccountId: $payFromAccountId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContributionsTable extends Contributions
    with TableInfo<$ContributionsTable, Contribution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _policyIdMeta = const VerificationMeta(
    'policyId',
  );
  @override
  late final GeneratedColumn<String> policyId = GeneratedColumn<String>(
    'policy_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES insurance_policies (id)',
    ),
  );
  static const VerificationMeta _txnIdMeta = const VerificationMeta('txnId');
  @override
  late final GeneratedColumn<String> txnId = GeneratedColumn<String>(
    'txn_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES txns (id)',
    ),
  );
  static const VerificationMeta _periodDueMeta = const VerificationMeta(
    'periodDue',
  );
  @override
  late final GeneratedColumn<DateTime> periodDue = GeneratedColumn<DateTime>(
    'period_due',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    deletedAt,
    policyId,
    txnId,
    periodDue,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contributions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Contribution> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('policy_id')) {
      context.handle(
        _policyIdMeta,
        policyId.isAcceptableOrUnknown(data['policy_id']!, _policyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_policyIdMeta);
    }
    if (data.containsKey('txn_id')) {
      context.handle(
        _txnIdMeta,
        txnId.isAcceptableOrUnknown(data['txn_id']!, _txnIdMeta),
      );
    } else if (isInserting) {
      context.missing(_txnIdMeta);
    }
    if (data.containsKey('period_due')) {
      context.handle(
        _periodDueMeta,
        periodDue.isAcceptableOrUnknown(data['period_due']!, _periodDueMeta),
      );
    } else if (isInserting) {
      context.missing(_periodDueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contribution map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contribution(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      policyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}policy_id'],
      )!,
      txnId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}txn_id'],
      )!,
      periodDue: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}period_due'],
      )!,
    );
  }

  @override
  $ContributionsTable createAlias(String alias) {
    return $ContributionsTable(attachedDatabase, alias);
  }
}

class Contribution extends DataClass implements Insertable<Contribution> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final String policyId;
  final String txnId;

  /// The due date this payment covered.
  final DateTime periodDue;
  const Contribution({
    required this.id,
    required this.householdId,
    required this.createdAt,
    this.deletedAt,
    required this.policyId,
    required this.txnId,
    required this.periodDue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['policy_id'] = Variable<String>(policyId);
    map['txn_id'] = Variable<String>(txnId);
    map['period_due'] = Variable<DateTime>(periodDue);
    return map;
  }

  ContributionsCompanion toCompanion(bool nullToAbsent) {
    return ContributionsCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      policyId: Value(policyId),
      txnId: Value(txnId),
      periodDue: Value(periodDue),
    );
  }

  factory Contribution.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contribution(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      policyId: serializer.fromJson<String>(json['policyId']),
      txnId: serializer.fromJson<String>(json['txnId']),
      periodDue: serializer.fromJson<DateTime>(json['periodDue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'policyId': serializer.toJson<String>(policyId),
      'txnId': serializer.toJson<String>(txnId),
      'periodDue': serializer.toJson<DateTime>(periodDue),
    };
  }

  Contribution copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? policyId,
    String? txnId,
    DateTime? periodDue,
  }) => Contribution(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    policyId: policyId ?? this.policyId,
    txnId: txnId ?? this.txnId,
    periodDue: periodDue ?? this.periodDue,
  );
  Contribution copyWithCompanion(ContributionsCompanion data) {
    return Contribution(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      policyId: data.policyId.present ? data.policyId.value : this.policyId,
      txnId: data.txnId.present ? data.txnId.value : this.txnId,
      periodDue: data.periodDue.present ? data.periodDue.value : this.periodDue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contribution(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('policyId: $policyId, ')
          ..write('txnId: $txnId, ')
          ..write('periodDue: $periodDue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    deletedAt,
    policyId,
    txnId,
    periodDue,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contribution &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.policyId == this.policyId &&
          other.txnId == this.txnId &&
          other.periodDue == this.periodDue);
}

class ContributionsCompanion extends UpdateCompanion<Contribution> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<String> policyId;
  final Value<String> txnId;
  final Value<DateTime> periodDue;
  final Value<int> rowid;
  const ContributionsCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.policyId = const Value.absent(),
    this.txnId = const Value.absent(),
    this.periodDue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContributionsCompanion.insert({
    this.id = const Value.absent(),
    required String householdId,
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String policyId,
    required String txnId,
    required DateTime periodDue,
    this.rowid = const Value.absent(),
  }) : householdId = Value(householdId),
       policyId = Value(policyId),
       txnId = Value(txnId),
       periodDue = Value(periodDue);
  static Insertable<Contribution> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? policyId,
    Expression<String>? txnId,
    Expression<DateTime>? periodDue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (policyId != null) 'policy_id': policyId,
      if (txnId != null) 'txn_id': txnId,
      if (periodDue != null) 'period_due': periodDue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContributionsCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime?>? deletedAt,
    Value<String>? policyId,
    Value<String>? txnId,
    Value<DateTime>? periodDue,
    Value<int>? rowid,
  }) {
    return ContributionsCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      policyId: policyId ?? this.policyId,
      txnId: txnId ?? this.txnId,
      periodDue: periodDue ?? this.periodDue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (policyId.present) {
      map['policy_id'] = Variable<String>(policyId.value);
    }
    if (txnId.present) {
      map['txn_id'] = Variable<String>(txnId.value);
    }
    if (periodDue.present) {
      map['period_due'] = Variable<DateTime>(periodDue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContributionsCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('policyId: $policyId, ')
          ..write('txnId: $txnId, ')
          ..write('periodDue: $periodDue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExchangeRatesTable extends ExchangeRates
    with TableInfo<$ExchangeRatesTable, ExchangeRate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExchangeRatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rateToBaseMeta = const VerificationMeta(
    'rateToBase',
  );
  @override
  late final GeneratedColumn<double> rateToBase = GeneratedColumn<double>(
    'rate_to_base',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [currency, date, rateToBase];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exchange_rates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExchangeRate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('rate_to_base')) {
      context.handle(
        _rateToBaseMeta,
        rateToBase.isAcceptableOrUnknown(
          data['rate_to_base']!,
          _rateToBaseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rateToBaseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {currency, date};
  @override
  ExchangeRate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExchangeRate(
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      rateToBase: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate_to_base'],
      )!,
    );
  }

  @override
  $ExchangeRatesTable createAlias(String alias) {
    return $ExchangeRatesTable(attachedDatabase, alias);
  }
}

class ExchangeRate extends DataClass implements Insertable<ExchangeRate> {
  final String currency;
  final DateTime date;
  final double rateToBase;
  const ExchangeRate({
    required this.currency,
    required this.date,
    required this.rateToBase,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['currency'] = Variable<String>(currency);
    map['date'] = Variable<DateTime>(date);
    map['rate_to_base'] = Variable<double>(rateToBase);
    return map;
  }

  ExchangeRatesCompanion toCompanion(bool nullToAbsent) {
    return ExchangeRatesCompanion(
      currency: Value(currency),
      date: Value(date),
      rateToBase: Value(rateToBase),
    );
  }

  factory ExchangeRate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExchangeRate(
      currency: serializer.fromJson<String>(json['currency']),
      date: serializer.fromJson<DateTime>(json['date']),
      rateToBase: serializer.fromJson<double>(json['rateToBase']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'currency': serializer.toJson<String>(currency),
      'date': serializer.toJson<DateTime>(date),
      'rateToBase': serializer.toJson<double>(rateToBase),
    };
  }

  ExchangeRate copyWith({
    String? currency,
    DateTime? date,
    double? rateToBase,
  }) => ExchangeRate(
    currency: currency ?? this.currency,
    date: date ?? this.date,
    rateToBase: rateToBase ?? this.rateToBase,
  );
  ExchangeRate copyWithCompanion(ExchangeRatesCompanion data) {
    return ExchangeRate(
      currency: data.currency.present ? data.currency.value : this.currency,
      date: data.date.present ? data.date.value : this.date,
      rateToBase: data.rateToBase.present
          ? data.rateToBase.value
          : this.rateToBase,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRate(')
          ..write('currency: $currency, ')
          ..write('date: $date, ')
          ..write('rateToBase: $rateToBase')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(currency, date, rateToBase);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExchangeRate &&
          other.currency == this.currency &&
          other.date == this.date &&
          other.rateToBase == this.rateToBase);
}

class ExchangeRatesCompanion extends UpdateCompanion<ExchangeRate> {
  final Value<String> currency;
  final Value<DateTime> date;
  final Value<double> rateToBase;
  final Value<int> rowid;
  const ExchangeRatesCompanion({
    this.currency = const Value.absent(),
    this.date = const Value.absent(),
    this.rateToBase = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExchangeRatesCompanion.insert({
    required String currency,
    required DateTime date,
    required double rateToBase,
    this.rowid = const Value.absent(),
  }) : currency = Value(currency),
       date = Value(date),
       rateToBase = Value(rateToBase);
  static Insertable<ExchangeRate> custom({
    Expression<String>? currency,
    Expression<DateTime>? date,
    Expression<double>? rateToBase,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (currency != null) 'currency': currency,
      if (date != null) 'date': date,
      if (rateToBase != null) 'rate_to_base': rateToBase,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExchangeRatesCompanion copyWith({
    Value<String>? currency,
    Value<DateTime>? date,
    Value<double>? rateToBase,
    Value<int>? rowid,
  }) {
    return ExchangeRatesCompanion(
      currency: currency ?? this.currency,
      date: date ?? this.date,
      rateToBase: rateToBase ?? this.rateToBase,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rateToBase.present) {
      map['rate_to_base'] = Variable<double>(rateToBase.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRatesCompanion(')
          ..write('currency: $currency, ')
          ..write('date: $date, ')
          ..write('rateToBase: $rateToBase, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HouseholdsTable households = $HouseholdsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $MembersTable members = $MembersTable(this);
  late final $ProvidersTable providers = $ProvidersTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $TxnsTable txns = $TxnsTable(this);
  late final $InsurancePoliciesTable insurancePolicies =
      $InsurancePoliciesTable(this);
  late final $ContributionsTable contributions = $ContributionsTable(this);
  late final $ExchangeRatesTable exchangeRates = $ExchangeRatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    households,
    users,
    members,
    providers,
    accounts,
    categories,
    txns,
    insurancePolicies,
    contributions,
    exchangeRates,
  ];
}

typedef $$HouseholdsTableCreateCompanionBuilder = HouseholdsCompanion Function({
  Value<String> id,
  required String name,
  Value<String> baseCurrency,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$HouseholdsTableUpdateCompanionBuilder = HouseholdsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> baseCurrency,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$HouseholdsTableReferences
    extends BaseReferences<_$AppDatabase, $HouseholdsTable, Household> {
  $$HouseholdsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UsersTable, List<User>> _usersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.users,
    aliasName: 'households__id__users__household_id',
  );

  $$UsersTableProcessedTableManager get usersRefs {
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_usersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MembersTable, List<Member>> _membersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.members,
    aliasName: 'households__id__members__household_id',
  );

  $$MembersTableProcessedTableManager get membersRefs {
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_membersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AccountsTable, List<Account>> _accountsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.accounts,
    aliasName: 'households__id__accounts__household_id',
  );

  $$AccountsTableProcessedTableManager get accountsRefs {
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CategoriesTable, List<Category>>
  _categoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.categories,
    aliasName: 'households__id__categories__household_id',
  );

  $$CategoriesTableProcessedTableManager get categoriesRefs {
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_categoriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TxnsTable, List<Txn>> _txnsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.txns,
    aliasName: 'households__id__txns__household_id',
  );

  $$TxnsTableProcessedTableManager get txnsRefs {
    final manager = $$TxnsTableTableManager(
      $_db,
      $_db.txns,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_txnsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InsurancePoliciesTable, List<InsurancePolicy>>
  _insurancePoliciesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.insurancePolicies,
        aliasName: 'households__id__insurance_policies__household_id',
      );

  $$InsurancePoliciesTableProcessedTableManager get insurancePoliciesRefs {
    final manager = $$InsurancePoliciesTableTableManager(
      $_db,
      $_db.insurancePolicies,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _insurancePoliciesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContributionsTable, List<Contribution>>
  _contributionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contributions,
    aliasName: 'households__id__contributions__household_id',
  );

  $$ContributionsTableProcessedTableManager get contributionsRefs {
    final manager = $$ContributionsTableTableManager(
      $_db,
      $_db.contributions,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contributionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HouseholdsTableFilterComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> usersRefs(
    Expression<bool> Function($$UsersTableFilterComposer f) f,
  ) {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> membersRefs(
    Expression<bool> Function($$MembersTableFilterComposer f) f,
  ) {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> accountsRefs(
    Expression<bool> Function($$AccountsTableFilterComposer f) f,
  ) {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> categoriesRefs(
    Expression<bool> Function($$CategoriesTableFilterComposer f) f,
  ) {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> txnsRefs(
    Expression<bool> Function($$TxnsTableFilterComposer f) f,
  ) {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> insurancePoliciesRefs(
    Expression<bool> Function($$InsurancePoliciesTableFilterComposer f) f,
  ) {
    final $$InsurancePoliciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.insurancePolicies,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsurancePoliciesTableFilterComposer(
            $db: $db,
            $table: $db.insurancePolicies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contributionsRefs(
    Expression<bool> Function($$ContributionsTableFilterComposer f) f,
  ) {
    final $$ContributionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contributions,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContributionsTableFilterComposer(
            $db: $db,
            $table: $db.contributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HouseholdsTableOrderingComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HouseholdsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> usersRefs<T extends Object>(
    Expression<T> Function($$UsersTableAnnotationComposer a) f,
  ) {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> membersRefs<T extends Object>(
    Expression<T> Function($$MembersTableAnnotationComposer a) f,
  ) {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> accountsRefs<T extends Object>(
    Expression<T> Function($$AccountsTableAnnotationComposer a) f,
  ) {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> categoriesRefs<T extends Object>(
    Expression<T> Function($$CategoriesTableAnnotationComposer a) f,
  ) {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> txnsRefs<T extends Object>(
    Expression<T> Function($$TxnsTableAnnotationComposer a) f,
  ) {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> insurancePoliciesRefs<T extends Object>(
    Expression<T> Function($$InsurancePoliciesTableAnnotationComposer a) f,
  ) {
    final $$InsurancePoliciesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.insurancePolicies,
          getReferencedColumn: (t) => t.householdId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InsurancePoliciesTableAnnotationComposer(
                $db: $db,
                $table: $db.insurancePolicies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> contributionsRefs<T extends Object>(
    Expression<T> Function($$ContributionsTableAnnotationComposer a) f,
  ) {
    final $$ContributionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contributions,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContributionsTableAnnotationComposer(
            $db: $db,
            $table: $db.contributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HouseholdsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HouseholdsTable,
          Household,
          $$HouseholdsTableFilterComposer,
          $$HouseholdsTableOrderingComposer,
          $$HouseholdsTableAnnotationComposer,
          $$HouseholdsTableCreateCompanionBuilder,
          $$HouseholdsTableUpdateCompanionBuilder,
          (Household, $$HouseholdsTableReferences),
          Household,
          PrefetchHooks Function({
            bool usersRefs,
            bool membersRefs,
            bool accountsRefs,
            bool categoriesRefs,
            bool txnsRefs,
            bool insurancePoliciesRefs,
            bool contributionsRefs,
          })
        > {
  $$HouseholdsTableTableManager(_$AppDatabase db, $HouseholdsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HouseholdsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HouseholdsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HouseholdsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HouseholdsCompanion(
                id: id,
                name: name,
                baseCurrency: baseCurrency,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                Value<String> baseCurrency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HouseholdsCompanion.insert(
                id: id,
                name: name,
                baseCurrency: baseCurrency,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HouseholdsTable, Household>(table),
                  $$HouseholdsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                usersRefs = false,
                membersRefs = false,
                accountsRefs = false,
                categoriesRefs = false,
                txnsRefs = false,
                insurancePoliciesRefs = false,
                contributionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (usersRefs) db.users,
                    if (membersRefs) db.members,
                    if (accountsRefs) db.accounts,
                    if (categoriesRefs) db.categories,
                    if (txnsRefs) db.txns,
                    if (insurancePoliciesRefs) db.insurancePolicies,
                    if (contributionsRefs) db.contributions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (usersRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          User,
                          $UsersTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._usersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).usersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (membersRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          Member,
                          $MembersTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._membersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).membersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (accountsRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          Account,
                          $AccountsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._accountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).accountsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (categoriesRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          Category,
                          $CategoriesTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._categoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).categoriesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (txnsRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          Txn,
                          $TxnsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._txnsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).txnsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (insurancePoliciesRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          InsurancePolicy,
                          $InsurancePoliciesTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._insurancePoliciesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).insurancePoliciesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (contributionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          Contribution,
                          $ContributionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._contributionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).contributionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HouseholdsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HouseholdsTable,
      Household,
      $$HouseholdsTableFilterComposer,
      $$HouseholdsTableOrderingComposer,
      $$HouseholdsTableAnnotationComposer,
      $$HouseholdsTableCreateCompanionBuilder,
      $$HouseholdsTableUpdateCompanionBuilder,
      (Household, $$HouseholdsTableReferences),
      Household,
      PrefetchHooks Function({
        bool usersRefs,
        bool membersRefs,
        bool accountsRefs,
        bool categoriesRefs,
        bool txnsRefs,
        bool insurancePoliciesRefs,
        bool contributionsRefs,
      })
    >;
typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  required String householdId,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  required String name,
  Value<String> role,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  Value<String> name,
  Value<String> role,
  Value<int> rowid,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('users__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AccountsTable, List<Account>> _accountsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.accounts,
    aliasName: 'users__id__accounts__owner_user_id',
  );

  $$AccountsTableProcessedTableManager get accountsRefs {
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.ownerUserId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> accountsRefs(
    Expression<bool> Function($$AccountsTableFilterComposer f) f,
  ) {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.ownerUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> accountsRefs<T extends Object>(
    Expression<T> Function($$AccountsTableAnnotationComposer a) f,
  ) {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.ownerUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool householdId, bool accountsRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                name: name,
                role: role,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String householdId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String name,
                Value<String> role = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                name: name,
                role: role,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, User>(table),
                  $$UsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({householdId = false, accountsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (accountsRefs) db.accounts],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$UsersTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$UsersTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (accountsRefs)
                    await $_getPrefetchedDataByColumns<
                      User,
                      $UsersTable,
                      Account,
                      $AccountsTable
                    >(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._accountsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).accountsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'owner_user_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool householdId, bool accountsRefs})
    >;
typedef $$MembersTableCreateCompanionBuilder = MembersCompanion Function({
  Value<String> id,
  required String householdId,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  required String name,
  Value<String> relation,
  Value<DateTime?> dateOfBirth,
  Value<String?> school,
  Value<String?> notes,
  Value<DateTime?> termStart,
  Value<DateTime?> termEnd,
  Value<int> rowid,
});
typedef $$MembersTableUpdateCompanionBuilder = MembersCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  Value<String> name,
  Value<String> relation,
  Value<DateTime?> dateOfBirth,
  Value<String?> school,
  Value<String?> notes,
  Value<DateTime?> termStart,
  Value<DateTime?> termEnd,
  Value<int> rowid,
});

final class $$MembersTableReferences
    extends BaseReferences<_$AppDatabase, $MembersTable, Member> {
  $$MembersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('members__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TxnsTable, List<Txn>> _txnsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.txns,
    aliasName: 'members__id__txns__member_id',
  );

  $$TxnsTableProcessedTableManager get txnsRefs {
    final manager = $$TxnsTableTableManager(
      $_db,
      $_db.txns,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_txnsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InsurancePoliciesTable, List<InsurancePolicy>>
  _insurancePoliciesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.insurancePolicies,
        aliasName: 'members__id__insurance_policies__insured_member_id',
      );

  $$InsurancePoliciesTableProcessedTableManager get insurancePoliciesRefs {
    final manager =
        $$InsurancePoliciesTableTableManager(
          $_db,
          $_db.insurancePolicies,
        ).filter(
          (f) => f.insuredMemberId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _insurancePoliciesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get school => $composableBuilder(
    column: $table.school,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get termStart => $composableBuilder(
    column: $table.termStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get termEnd => $composableBuilder(
    column: $table.termEnd,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> txnsRefs(
    Expression<bool> Function($$TxnsTableFilterComposer f) f,
  ) {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> insurancePoliciesRefs(
    Expression<bool> Function($$InsurancePoliciesTableFilterComposer f) f,
  ) {
    final $$InsurancePoliciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.insurancePolicies,
      getReferencedColumn: (t) => t.insuredMemberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsurancePoliciesTableFilterComposer(
            $db: $db,
            $table: $db.insurancePolicies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get school => $composableBuilder(
    column: $table.school,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get termStart => $composableBuilder(
    column: $table.termStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get termEnd => $composableBuilder(
    column: $table.termEnd,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get relation =>
      $composableBuilder(column: $table.relation, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get school =>
      $composableBuilder(column: $table.school, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get termStart =>
      $composableBuilder(column: $table.termStart, builder: (column) => column);

  GeneratedColumn<DateTime> get termEnd =>
      $composableBuilder(column: $table.termEnd, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> txnsRefs<T extends Object>(
    Expression<T> Function($$TxnsTableAnnotationComposer a) f,
  ) {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> insurancePoliciesRefs<T extends Object>(
    Expression<T> Function($$InsurancePoliciesTableAnnotationComposer a) f,
  ) {
    final $$InsurancePoliciesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.insurancePolicies,
          getReferencedColumn: (t) => t.insuredMemberId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InsurancePoliciesTableAnnotationComposer(
                $db: $db,
                $table: $db.insurancePolicies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTable,
          Member,
          $$MembersTableFilterComposer,
          $$MembersTableOrderingComposer,
          $$MembersTableAnnotationComposer,
          $$MembersTableCreateCompanionBuilder,
          $$MembersTableUpdateCompanionBuilder,
          (Member, $$MembersTableReferences),
          Member,
          PrefetchHooks Function({
            bool householdId,
            bool txnsRefs,
            bool insurancePoliciesRefs,
          })
        > {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> relation = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<String?> school = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> termStart = const Value.absent(),
                Value<DateTime?> termEnd = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                name: name,
                relation: relation,
                dateOfBirth: dateOfBirth,
                school: school,
                notes: notes,
                termStart: termStart,
                termEnd: termEnd,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String householdId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String name,
                Value<String> relation = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<String?> school = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> termStart = const Value.absent(),
                Value<DateTime?> termEnd = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                name: name,
                relation: relation,
                dateOfBirth: dateOfBirth,
                school: school,
                notes: notes,
                termStart: termStart,
                termEnd: termEnd,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MembersTable, Member>(table),
                  $$MembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                householdId = false,
                txnsRefs = false,
                insurancePoliciesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (txnsRefs) db.txns,
                    if (insurancePoliciesRefs) db.insurancePolicies,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (householdId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.householdId,
                            referencedTable: $$MembersTableReferences
                                ._householdIdTable(db),
                            referencedColumn: $$MembersTableReferences
                                ._householdIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (txnsRefs)
                        await $_getPrefetchedDataByColumns<
                          Member,
                          $MembersTable,
                          Txn,
                          $TxnsTable
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._txnsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(db, table, p0).txnsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'member_id',
                          typedResults: items,
                        ),
                      if (insurancePoliciesRefs)
                        await $_getPrefetchedDataByColumns<
                          Member,
                          $MembersTable,
                          InsurancePolicy,
                          $InsurancePoliciesTable
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._insurancePoliciesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).insurancePoliciesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'insured_member_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTable,
      Member,
      $$MembersTableFilterComposer,
      $$MembersTableOrderingComposer,
      $$MembersTableAnnotationComposer,
      $$MembersTableCreateCompanionBuilder,
      $$MembersTableUpdateCompanionBuilder,
      (Member, $$MembersTableReferences),
      Member,
      PrefetchHooks Function({
        bool householdId,
        bool txnsRefs,
        bool insurancePoliciesRefs,
      })
    >;
typedef $$ProvidersTableCreateCompanionBuilder = ProvidersCompanion Function({
  required String id,
  required String name,
  required String kind,
  Value<String?> smsSenders,
  Value<int> rowid,
});
typedef $$ProvidersTableUpdateCompanionBuilder = ProvidersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> kind,
  Value<String?> smsSenders,
  Value<int> rowid,
});

final class $$ProvidersTableReferences
    extends BaseReferences<_$AppDatabase, $ProvidersTable, FinProvider> {
  $$ProvidersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AccountsTable, List<Account>> _accountsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.accounts,
    aliasName: 'providers__id__accounts__provider_id',
  );

  $$AccountsTableProcessedTableManager get accountsRefs {
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InsurancePoliciesTable, List<InsurancePolicy>>
  _insurancePoliciesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.insurancePolicies,
        aliasName: 'providers__id__insurance_policies__provider_id',
      );

  $$InsurancePoliciesTableProcessedTableManager get insurancePoliciesRefs {
    final manager = $$InsurancePoliciesTableTableManager(
      $_db,
      $_db.insurancePolicies,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _insurancePoliciesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProvidersTableFilterComposer
    extends Composer<_$AppDatabase, $ProvidersTable> {
  $$ProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get smsSenders => $composableBuilder(
    column: $table.smsSenders,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> accountsRefs(
    Expression<bool> Function($$AccountsTableFilterComposer f) f,
  ) {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> insurancePoliciesRefs(
    Expression<bool> Function($$InsurancePoliciesTableFilterComposer f) f,
  ) {
    final $$InsurancePoliciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.insurancePolicies,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsurancePoliciesTableFilterComposer(
            $db: $db,
            $table: $db.insurancePolicies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProvidersTableOrderingComposer
    extends Composer<_$AppDatabase, $ProvidersTable> {
  $$ProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get smsSenders => $composableBuilder(
    column: $table.smsSenders,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProvidersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProvidersTable> {
  $$ProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get smsSenders => $composableBuilder(
    column: $table.smsSenders,
    builder: (column) => column,
  );

  Expression<T> accountsRefs<T extends Object>(
    Expression<T> Function($$AccountsTableAnnotationComposer a) f,
  ) {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> insurancePoliciesRefs<T extends Object>(
    Expression<T> Function($$InsurancePoliciesTableAnnotationComposer a) f,
  ) {
    final $$InsurancePoliciesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.insurancePolicies,
          getReferencedColumn: (t) => t.providerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InsurancePoliciesTableAnnotationComposer(
                $db: $db,
                $table: $db.insurancePolicies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProvidersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProvidersTable,
          FinProvider,
          $$ProvidersTableFilterComposer,
          $$ProvidersTableOrderingComposer,
          $$ProvidersTableAnnotationComposer,
          $$ProvidersTableCreateCompanionBuilder,
          $$ProvidersTableUpdateCompanionBuilder,
          (FinProvider, $$ProvidersTableReferences),
          FinProvider,
          PrefetchHooks Function({
            bool accountsRefs,
            bool insurancePoliciesRefs,
          })
        > {
  $$ProvidersTableTableManager(_$AppDatabase db, $ProvidersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> smsSenders = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProvidersCompanion(
                id: id,
                name: name,
                kind: kind,
                smsSenders: smsSenders,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String kind,
                Value<String?> smsSenders = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProvidersCompanion.insert(
                id: id,
                name: name,
                kind: kind,
                smsSenders: smsSenders,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProvidersTable, FinProvider>(table),
                  $$ProvidersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({accountsRefs = false, insurancePoliciesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (accountsRefs) db.accounts,
                    if (insurancePoliciesRefs) db.insurancePolicies,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (accountsRefs)
                        await $_getPrefetchedDataByColumns<
                          FinProvider,
                          $ProvidersTable,
                          Account,
                          $AccountsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProvidersTableReferences
                              ._accountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).accountsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'provider_id',
                          typedResults: items,
                        ),
                      if (insurancePoliciesRefs)
                        await $_getPrefetchedDataByColumns<
                          FinProvider,
                          $ProvidersTable,
                          InsurancePolicy,
                          $InsurancePoliciesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProvidersTableReferences
                              ._insurancePoliciesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).insurancePoliciesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'provider_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProvidersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProvidersTable,
      FinProvider,
      $$ProvidersTableFilterComposer,
      $$ProvidersTableOrderingComposer,
      $$ProvidersTableAnnotationComposer,
      $$ProvidersTableCreateCompanionBuilder,
      $$ProvidersTableUpdateCompanionBuilder,
      (FinProvider, $$ProvidersTableReferences),
      FinProvider,
      PrefetchHooks Function({bool accountsRefs, bool insurancePoliciesRefs})
    >;
typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  Value<String> id,
  required String householdId,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  required String name,
  required String type,
  Value<String?> providerId,
  Value<String?> number,
  Value<String> currency,
  Value<int> openingBalance,
  Value<DateTime> openingDate,
  Value<String?> ownerUserId,
  Value<String> visibility,
  Value<bool> archived,
  Value<int> rowid,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  Value<String> name,
  Value<String> type,
  Value<String?> providerId,
  Value<String?> number,
  Value<String> currency,
  Value<int> openingBalance,
  Value<DateTime> openingDate,
  Value<String?> ownerUserId,
  Value<String> visibility,
  Value<bool> archived,
  Value<int> rowid,
});

final class $$AccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTable, Account> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('accounts__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProvidersTable _providerIdTable(_$AppDatabase db) =>
      db.providers.createAlias('accounts__provider_id__providers__id');

  $$ProvidersTableProcessedTableManager? get providerId {
    final $_column = $_itemColumn<String>('provider_id');
    if ($_column == null) return null;
    final manager = $$ProvidersTableTableManager(
      $_db,
      $_db.providers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _ownerUserIdTable(_$AppDatabase db) =>
      db.users.createAlias('accounts__owner_user_id__users__id');

  $$UsersTableProcessedTableManager? get ownerUserId {
    final $_column = $_itemColumn<String>('owner_user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TxnsTable, List<Txn>> _txnsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.txns,
    aliasName: 'accounts__id__txns__account_id',
  );

  $$TxnsTableProcessedTableManager get txnsRefs {
    final manager = $$TxnsTableTableManager(
      $_db,
      $_db.txns,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_txnsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InsurancePoliciesTable, List<InsurancePolicy>>
  _insurancePoliciesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.insurancePolicies,
        aliasName: 'accounts__id__insurance_policies__pay_from_account_id',
      );

  $$InsurancePoliciesTableProcessedTableManager get insurancePoliciesRefs {
    final manager =
        $$InsurancePoliciesTableTableManager(
          $_db,
          $_db.insurancePolicies,
        ).filter(
          (f) => f.payFromAccountId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _insurancePoliciesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openingDate => $composableBuilder(
    column: $table.openingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProvidersTableFilterComposer get providerId {
    final $$ProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.providers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProvidersTableFilterComposer(
            $db: $db,
            $table: $db.providers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get ownerUserId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> txnsRefs(
    Expression<bool> Function($$TxnsTableFilterComposer f) f,
  ) {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> insurancePoliciesRefs(
    Expression<bool> Function($$InsurancePoliciesTableFilterComposer f) f,
  ) {
    final $$InsurancePoliciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.insurancePolicies,
      getReferencedColumn: (t) => t.payFromAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsurancePoliciesTableFilterComposer(
            $db: $db,
            $table: $db.insurancePolicies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openingDate => $composableBuilder(
    column: $table.openingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProvidersTableOrderingComposer get providerId {
    final $$ProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.providers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.providers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get ownerUserId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get openingDate => $composableBuilder(
    column: $table.openingDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProvidersTableAnnotationComposer get providerId {
    final $$ProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.providers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.providers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get ownerUserId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> txnsRefs<T extends Object>(
    Expression<T> Function($$TxnsTableAnnotationComposer a) f,
  ) {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> insurancePoliciesRefs<T extends Object>(
    Expression<T> Function($$InsurancePoliciesTableAnnotationComposer a) f,
  ) {
    final $$InsurancePoliciesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.insurancePolicies,
          getReferencedColumn: (t) => t.payFromAccountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InsurancePoliciesTableAnnotationComposer(
                $db: $db,
                $table: $db.insurancePolicies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          Account,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (Account, $$AccountsTableReferences),
          Account,
          PrefetchHooks Function({
            bool householdId,
            bool providerId,
            bool ownerUserId,
            bool txnsRefs,
            bool insurancePoliciesRefs,
          })
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> providerId = const Value.absent(),
                Value<String?> number = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> openingBalance = const Value.absent(),
                Value<DateTime> openingDate = const Value.absent(),
                Value<String?> ownerUserId = const Value.absent(),
                Value<String> visibility = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                name: name,
                type: type,
                providerId: providerId,
                number: number,
                currency: currency,
                openingBalance: openingBalance,
                openingDate: openingDate,
                ownerUserId: ownerUserId,
                visibility: visibility,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String householdId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String name,
                required String type,
                Value<String?> providerId = const Value.absent(),
                Value<String?> number = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> openingBalance = const Value.absent(),
                Value<DateTime> openingDate = const Value.absent(),
                Value<String?> ownerUserId = const Value.absent(),
                Value<String> visibility = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                name: name,
                type: type,
                providerId: providerId,
                number: number,
                currency: currency,
                openingBalance: openingBalance,
                openingDate: openingDate,
                ownerUserId: ownerUserId,
                visibility: visibility,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AccountsTable, Account>(table),
                  $$AccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                householdId = false,
                providerId = false,
                ownerUserId = false,
                txnsRefs = false,
                insurancePoliciesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (txnsRefs) db.txns,
                    if (insurancePoliciesRefs) db.insurancePolicies,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (householdId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.householdId,
                            referencedTable: $$AccountsTableReferences
                                ._householdIdTable(db),
                            referencedColumn: $$AccountsTableReferences
                                ._householdIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (providerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.providerId,
                            referencedTable: $$AccountsTableReferences
                                ._providerIdTable(db),
                            referencedColumn: $$AccountsTableReferences
                                ._providerIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (ownerUserId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ownerUserId,
                            referencedTable: $$AccountsTableReferences
                                ._ownerUserIdTable(db),
                            referencedColumn: $$AccountsTableReferences
                                ._ownerUserIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (txnsRefs)
                        await $_getPrefetchedDataByColumns<
                          Account,
                          $AccountsTable,
                          Txn,
                          $TxnsTable
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._txnsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(db, table, p0).txnsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'account_id',
                          typedResults: items,
                        ),
                      if (insurancePoliciesRefs)
                        await $_getPrefetchedDataByColumns<
                          Account,
                          $AccountsTable,
                          InsurancePolicy,
                          $InsurancePoliciesTable
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._insurancePoliciesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).insurancePoliciesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pay_from_account_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      Account,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (Account, $$AccountsTableReferences),
      Account,
      PrefetchHooks Function({
        bool householdId,
        bool providerId,
        bool ownerUserId,
        bool txnsRefs,
        bool insurancePoliciesRefs,
      })
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  required String householdId,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  required String name,
  required String kind,
  Value<String?> parentId,
  Value<String> iconKey,
  Value<String?> systemKey,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  Value<String> name,
  Value<String> kind,
  Value<String?> parentId,
  Value<String> iconKey,
  Value<String?> systemKey,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('categories__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TxnsTable, List<Txn>> _txnsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.txns,
    aliasName: 'categories__id__txns__category_id',
  );

  $$TxnsTableProcessedTableManager get txnsRefs {
    final manager = $$TxnsTableTableManager(
      $_db,
      $_db.txns,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_txnsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemKey => $composableBuilder(
    column: $table.systemKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> txnsRefs(
    Expression<bool> Function($$TxnsTableFilterComposer f) f,
  ) {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemKey => $composableBuilder(
    column: $table.systemKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<String> get systemKey =>
      $composableBuilder(column: $table.systemKey, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> txnsRefs<T extends Object>(
    Expression<T> Function($$TxnsTableAnnotationComposer a) f,
  ) {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool householdId, bool txnsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<String?> systemKey = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                name: name,
                kind: kind,
                parentId: parentId,
                iconKey: iconKey,
                systemKey: systemKey,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String householdId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String name,
                required String kind,
                Value<String?> parentId = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<String?> systemKey = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                name: name,
                kind: kind,
                parentId: parentId,
                iconKey: iconKey,
                systemKey: systemKey,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, Category>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({householdId = false, txnsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (txnsRefs) db.txns],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$CategoriesTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$CategoriesTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (txnsRefs)
                    await $_getPrefetchedDataByColumns<
                      Category,
                      $CategoriesTable,
                      Txn,
                      $TxnsTable
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._txnsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(db, table, p0).txnsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'category_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool householdId, bool txnsRefs})
    >;
typedef $$TxnsTableCreateCompanionBuilder = TxnsCompanion Function({
  Value<String> id,
  required String householdId,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  required String type,
  required int amount,
  required DateTime date,
  required String accountId,
  Value<String?> categoryId,
  Value<String?> memberId,
  Value<String?> policyId,
  Value<String?> payee,
  Value<String?> note,
  Value<String> source,
  Value<String> status,
  Value<String?> smsRef,
  Value<String?> transferGroupId,
  Value<String?> feeOfId,
  Value<String?> createdByUserId,
  Value<int> rowid,
});
typedef $$TxnsTableUpdateCompanionBuilder = TxnsCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  Value<String> type,
  Value<int> amount,
  Value<DateTime> date,
  Value<String> accountId,
  Value<String?> categoryId,
  Value<String?> memberId,
  Value<String?> policyId,
  Value<String?> payee,
  Value<String?> note,
  Value<String> source,
  Value<String> status,
  Value<String?> smsRef,
  Value<String?> transferGroupId,
  Value<String?> feeOfId,
  Value<String?> createdByUserId,
  Value<int> rowid,
});

final class $$TxnsTableReferences
    extends BaseReferences<_$AppDatabase, $TxnsTable, Txn> {
  $$TxnsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('txns__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('txns__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('txns__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _memberIdTable(_$AppDatabase db) =>
      db.members.createAlias('txns__member_id__members__id');

  $$MembersTableProcessedTableManager? get memberId {
    final $_column = $_itemColumn<String>('member_id');
    if ($_column == null) return null;
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ContributionsTable, List<Contribution>>
  _contributionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contributions,
    aliasName: 'txns__id__contributions__txn_id',
  );

  $$ContributionsTableProcessedTableManager get contributionsRefs {
    final manager = $$ContributionsTableTableManager(
      $_db,
      $_db.contributions,
    ).filter((f) => f.txnId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contributionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TxnsTableFilterComposer extends Composer<_$AppDatabase, $TxnsTable> {
  $$TxnsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get policyId => $composableBuilder(
    column: $table.policyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payee => $composableBuilder(
    column: $table.payee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get smsRef => $composableBuilder(
    column: $table.smsRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferGroupId => $composableBuilder(
    column: $table.transferGroupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feeOfId => $composableBuilder(
    column: $table.feeOfId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdByUserId => $composableBuilder(
    column: $table.createdByUserId,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get memberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> contributionsRefs(
    Expression<bool> Function($$ContributionsTableFilterComposer f) f,
  ) {
    final $$ContributionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contributions,
      getReferencedColumn: (t) => t.txnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContributionsTableFilterComposer(
            $db: $db,
            $table: $db.contributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TxnsTableOrderingComposer extends Composer<_$AppDatabase, $TxnsTable> {
  $$TxnsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get policyId => $composableBuilder(
    column: $table.policyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payee => $composableBuilder(
    column: $table.payee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get smsRef => $composableBuilder(
    column: $table.smsRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferGroupId => $composableBuilder(
    column: $table.transferGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feeOfId => $composableBuilder(
    column: $table.feeOfId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdByUserId => $composableBuilder(
    column: $table.createdByUserId,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get memberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TxnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TxnsTable> {
  $$TxnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get policyId =>
      $composableBuilder(column: $table.policyId, builder: (column) => column);

  GeneratedColumn<String> get payee =>
      $composableBuilder(column: $table.payee, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get smsRef =>
      $composableBuilder(column: $table.smsRef, builder: (column) => column);

  GeneratedColumn<String> get transferGroupId => $composableBuilder(
    column: $table.transferGroupId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get feeOfId =>
      $composableBuilder(column: $table.feeOfId, builder: (column) => column);

  GeneratedColumn<String> get createdByUserId => $composableBuilder(
    column: $table.createdByUserId,
    builder: (column) => column,
  );

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get memberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> contributionsRefs<T extends Object>(
    Expression<T> Function($$ContributionsTableAnnotationComposer a) f,
  ) {
    final $$ContributionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contributions,
      getReferencedColumn: (t) => t.txnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContributionsTableAnnotationComposer(
            $db: $db,
            $table: $db.contributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TxnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TxnsTable,
          Txn,
          $$TxnsTableFilterComposer,
          $$TxnsTableOrderingComposer,
          $$TxnsTableAnnotationComposer,
          $$TxnsTableCreateCompanionBuilder,
          $$TxnsTableUpdateCompanionBuilder,
          (Txn, $$TxnsTableReferences),
          Txn,
          PrefetchHooks Function({
            bool householdId,
            bool accountId,
            bool categoryId,
            bool memberId,
            bool contributionsRefs,
          })
        > {
  $$TxnsTableTableManager(_$AppDatabase db, $TxnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TxnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TxnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TxnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> memberId = const Value.absent(),
                Value<String?> policyId = const Value.absent(),
                Value<String?> payee = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> smsRef = const Value.absent(),
                Value<String?> transferGroupId = const Value.absent(),
                Value<String?> feeOfId = const Value.absent(),
                Value<String?> createdByUserId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TxnsCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                type: type,
                amount: amount,
                date: date,
                accountId: accountId,
                categoryId: categoryId,
                memberId: memberId,
                policyId: policyId,
                payee: payee,
                note: note,
                source: source,
                status: status,
                smsRef: smsRef,
                transferGroupId: transferGroupId,
                feeOfId: feeOfId,
                createdByUserId: createdByUserId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String householdId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String type,
                required int amount,
                required DateTime date,
                required String accountId,
                Value<String?> categoryId = const Value.absent(),
                Value<String?> memberId = const Value.absent(),
                Value<String?> policyId = const Value.absent(),
                Value<String?> payee = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> smsRef = const Value.absent(),
                Value<String?> transferGroupId = const Value.absent(),
                Value<String?> feeOfId = const Value.absent(),
                Value<String?> createdByUserId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TxnsCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                type: type,
                amount: amount,
                date: date,
                accountId: accountId,
                categoryId: categoryId,
                memberId: memberId,
                policyId: policyId,
                payee: payee,
                note: note,
                source: source,
                status: status,
                smsRef: smsRef,
                transferGroupId: transferGroupId,
                feeOfId: feeOfId,
                createdByUserId: createdByUserId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TxnsTable, Txn>(table),
                  $$TxnsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                householdId = false,
                accountId = false,
                categoryId = false,
                memberId = false,
                contributionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (contributionsRefs) db.contributions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (householdId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.householdId,
                            referencedTable: $$TxnsTableReferences
                                ._householdIdTable(db),
                            referencedColumn: $$TxnsTableReferences
                                ._householdIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$TxnsTableReferences
                                ._accountIdTable(db),
                            referencedColumn: $$TxnsTableReferences
                                ._accountIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$TxnsTableReferences
                                ._categoryIdTable(db),
                            referencedColumn: $$TxnsTableReferences
                                ._categoryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (memberId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.memberId,
                            referencedTable: $$TxnsTableReferences
                                ._memberIdTable(db),
                            referencedColumn: $$TxnsTableReferences
                                ._memberIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (contributionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Txn,
                          $TxnsTable,
                          Contribution,
                          $ContributionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$TxnsTableReferences
                              ._contributionsRefsTable(db),
                          managerFromTypedResult: (p0) => $$TxnsTableReferences(
                            db,
                            table,
                            p0,
                          ).contributionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'txn_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TxnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TxnsTable,
      Txn,
      $$TxnsTableFilterComposer,
      $$TxnsTableOrderingComposer,
      $$TxnsTableAnnotationComposer,
      $$TxnsTableCreateCompanionBuilder,
      $$TxnsTableUpdateCompanionBuilder,
      (Txn, $$TxnsTableReferences),
      Txn,
      PrefetchHooks Function({
        bool householdId,
        bool accountId,
        bool categoryId,
        bool memberId,
        bool contributionsRefs,
      })
    >;
typedef $$InsurancePoliciesTableCreateCompanionBuilder =
    InsurancePoliciesCompanion Function({
      Value<String> id,
      required String householdId,
      Value<DateTime> createdAt,
      Value<DateTime?> deletedAt,
      Value<String?> providerId,
      Value<String?> providerName,
      required String type,
      Value<String?> policyNumber,
      Value<String?> insuredMemberId,
      required int premium,
      Value<String> currency,
      Value<String> frequency,
      required DateTime nextDueDate,
      Value<int?> dueDay,
      Value<int?> coverAmount,
      Value<String?> payFromAccountId,
      Value<int> rowid,
    });
typedef $$InsurancePoliciesTableUpdateCompanionBuilder =
    InsurancePoliciesCompanion Function({
      Value<String> id,
      Value<String> householdId,
      Value<DateTime> createdAt,
      Value<DateTime?> deletedAt,
      Value<String?> providerId,
      Value<String?> providerName,
      Value<String> type,
      Value<String?> policyNumber,
      Value<String?> insuredMemberId,
      Value<int> premium,
      Value<String> currency,
      Value<String> frequency,
      Value<DateTime> nextDueDate,
      Value<int?> dueDay,
      Value<int?> coverAmount,
      Value<String?> payFromAccountId,
      Value<int> rowid,
    });

final class $$InsurancePoliciesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InsurancePoliciesTable,
          InsurancePolicy
        > {
  $$InsurancePoliciesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) => db.households
      .createAlias('insurance_policies__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProvidersTable _providerIdTable(_$AppDatabase db) => db.providers
      .createAlias('insurance_policies__provider_id__providers__id');

  $$ProvidersTableProcessedTableManager? get providerId {
    final $_column = $_itemColumn<String>('provider_id');
    if ($_column == null) return null;
    final manager = $$ProvidersTableTableManager(
      $_db,
      $_db.providers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _insuredMemberIdTable(_$AppDatabase db) => db.members
      .createAlias('insurance_policies__insured_member_id__members__id');

  $$MembersTableProcessedTableManager? get insuredMemberId {
    final $_column = $_itemColumn<String>('insured_member_id');
    if ($_column == null) return null;
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_insuredMemberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _payFromAccountIdTable(_$AppDatabase db) => db.accounts
      .createAlias('insurance_policies__pay_from_account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get payFromAccountId {
    final $_column = $_itemColumn<String>('pay_from_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_payFromAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ContributionsTable, List<Contribution>>
  _contributionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contributions,
    aliasName: 'insurance_policies__id__contributions__policy_id',
  );

  $$ContributionsTableProcessedTableManager get contributionsRefs {
    final manager = $$ContributionsTableTableManager(
      $_db,
      $_db.contributions,
    ).filter((f) => f.policyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contributionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InsurancePoliciesTableFilterComposer
    extends Composer<_$AppDatabase, $InsurancePoliciesTable> {
  $$InsurancePoliciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get premium => $composableBuilder(
    column: $table.premium,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coverAmount => $composableBuilder(
    column: $table.coverAmount,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProvidersTableFilterComposer get providerId {
    final $$ProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.providers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProvidersTableFilterComposer(
            $db: $db,
            $table: $db.providers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get insuredMemberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.insuredMemberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get payFromAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payFromAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> contributionsRefs(
    Expression<bool> Function($$ContributionsTableFilterComposer f) f,
  ) {
    final $$ContributionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contributions,
      getReferencedColumn: (t) => t.policyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContributionsTableFilterComposer(
            $db: $db,
            $table: $db.contributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InsurancePoliciesTableOrderingComposer
    extends Composer<_$AppDatabase, $InsurancePoliciesTable> {
  $$InsurancePoliciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get premium => $composableBuilder(
    column: $table.premium,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coverAmount => $composableBuilder(
    column: $table.coverAmount,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProvidersTableOrderingComposer get providerId {
    final $$ProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.providers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.providers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get insuredMemberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.insuredMemberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get payFromAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payFromAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InsurancePoliciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InsurancePoliciesTable> {
  $$InsurancePoliciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get premium =>
      $composableBuilder(column: $table.premium, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueDay =>
      $composableBuilder(column: $table.dueDay, builder: (column) => column);

  GeneratedColumn<int> get coverAmount => $composableBuilder(
    column: $table.coverAmount,
    builder: (column) => column,
  );

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProvidersTableAnnotationComposer get providerId {
    final $$ProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.providers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.providers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get insuredMemberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.insuredMemberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get payFromAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payFromAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> contributionsRefs<T extends Object>(
    Expression<T> Function($$ContributionsTableAnnotationComposer a) f,
  ) {
    final $$ContributionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contributions,
      getReferencedColumn: (t) => t.policyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContributionsTableAnnotationComposer(
            $db: $db,
            $table: $db.contributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InsurancePoliciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InsurancePoliciesTable,
          InsurancePolicy,
          $$InsurancePoliciesTableFilterComposer,
          $$InsurancePoliciesTableOrderingComposer,
          $$InsurancePoliciesTableAnnotationComposer,
          $$InsurancePoliciesTableCreateCompanionBuilder,
          $$InsurancePoliciesTableUpdateCompanionBuilder,
          (InsurancePolicy, $$InsurancePoliciesTableReferences),
          InsurancePolicy,
          PrefetchHooks Function({
            bool householdId,
            bool providerId,
            bool insuredMemberId,
            bool payFromAccountId,
            bool contributionsRefs,
          })
        > {
  $$InsurancePoliciesTableTableManager(
    _$AppDatabase db,
    $InsurancePoliciesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InsurancePoliciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InsurancePoliciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InsurancePoliciesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> providerId = const Value.absent(),
                Value<String?> providerName = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> policyNumber = const Value.absent(),
                Value<String?> insuredMemberId = const Value.absent(),
                Value<int> premium = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<DateTime> nextDueDate = const Value.absent(),
                Value<int?> dueDay = const Value.absent(),
                Value<int?> coverAmount = const Value.absent(),
                Value<String?> payFromAccountId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InsurancePoliciesCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                providerId: providerId,
                providerName: providerName,
                type: type,
                policyNumber: policyNumber,
                insuredMemberId: insuredMemberId,
                premium: premium,
                currency: currency,
                frequency: frequency,
                nextDueDate: nextDueDate,
                dueDay: dueDay,
                coverAmount: coverAmount,
                payFromAccountId: payFromAccountId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String householdId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> providerId = const Value.absent(),
                Value<String?> providerName = const Value.absent(),
                required String type,
                Value<String?> policyNumber = const Value.absent(),
                Value<String?> insuredMemberId = const Value.absent(),
                required int premium,
                Value<String> currency = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                required DateTime nextDueDate,
                Value<int?> dueDay = const Value.absent(),
                Value<int?> coverAmount = const Value.absent(),
                Value<String?> payFromAccountId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InsurancePoliciesCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                providerId: providerId,
                providerName: providerName,
                type: type,
                policyNumber: policyNumber,
                insuredMemberId: insuredMemberId,
                premium: premium,
                currency: currency,
                frequency: frequency,
                nextDueDate: nextDueDate,
                dueDay: dueDay,
                coverAmount: coverAmount,
                payFromAccountId: payFromAccountId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InsurancePoliciesTable, InsurancePolicy>(table),
                  $$InsurancePoliciesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                householdId = false,
                providerId = false,
                insuredMemberId = false,
                payFromAccountId = false,
                contributionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (contributionsRefs) db.contributions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (householdId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.householdId,
                            referencedTable: $$InsurancePoliciesTableReferences
                                ._householdIdTable(db),
                            referencedColumn: $$InsurancePoliciesTableReferences
                                ._householdIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (providerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.providerId,
                            referencedTable: $$InsurancePoliciesTableReferences
                                ._providerIdTable(db),
                            referencedColumn: $$InsurancePoliciesTableReferences
                                ._providerIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (insuredMemberId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.insuredMemberId,
                            referencedTable: $$InsurancePoliciesTableReferences
                                ._insuredMemberIdTable(db),
                            referencedColumn: $$InsurancePoliciesTableReferences
                                ._insuredMemberIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (payFromAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.payFromAccountId,
                            referencedTable: $$InsurancePoliciesTableReferences
                                ._payFromAccountIdTable(db),
                            referencedColumn: $$InsurancePoliciesTableReferences
                                ._payFromAccountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (contributionsRefs)
                        await $_getPrefetchedDataByColumns<
                          InsurancePolicy,
                          $InsurancePoliciesTable,
                          Contribution,
                          $ContributionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$InsurancePoliciesTableReferences
                              ._contributionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InsurancePoliciesTableReferences(
                                db,
                                table,
                                p0,
                              ).contributionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'policy_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InsurancePoliciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InsurancePoliciesTable,
      InsurancePolicy,
      $$InsurancePoliciesTableFilterComposer,
      $$InsurancePoliciesTableOrderingComposer,
      $$InsurancePoliciesTableAnnotationComposer,
      $$InsurancePoliciesTableCreateCompanionBuilder,
      $$InsurancePoliciesTableUpdateCompanionBuilder,
      (InsurancePolicy, $$InsurancePoliciesTableReferences),
      InsurancePolicy,
      PrefetchHooks Function({
        bool householdId,
        bool providerId,
        bool insuredMemberId,
        bool payFromAccountId,
        bool contributionsRefs,
      })
    >;
typedef $$ContributionsTableCreateCompanionBuilder =
    ContributionsCompanion Function({
      Value<String> id,
      required String householdId,
      Value<DateTime> createdAt,
      Value<DateTime?> deletedAt,
      required String policyId,
      required String txnId,
      required DateTime periodDue,
      Value<int> rowid,
    });
typedef $$ContributionsTableUpdateCompanionBuilder =
    ContributionsCompanion Function({
      Value<String> id,
      Value<String> householdId,
      Value<DateTime> createdAt,
      Value<DateTime?> deletedAt,
      Value<String> policyId,
      Value<String> txnId,
      Value<DateTime> periodDue,
      Value<int> rowid,
    });

final class $$ContributionsTableReferences
    extends BaseReferences<_$AppDatabase, $ContributionsTable, Contribution> {
  $$ContributionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('contributions__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InsurancePoliciesTable _policyIdTable(_$AppDatabase db) => db
      .insurancePolicies
      .createAlias('contributions__policy_id__insurance_policies__id');

  $$InsurancePoliciesTableProcessedTableManager get policyId {
    final $_column = $_itemColumn<String>('policy_id')!;

    final manager = $$InsurancePoliciesTableTableManager(
      $_db,
      $_db.insurancePolicies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_policyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TxnsTable _txnIdTable(_$AppDatabase db) =>
      db.txns.createAlias('contributions__txn_id__txns__id');

  $$TxnsTableProcessedTableManager get txnId {
    final $_column = $_itemColumn<String>('txn_id')!;

    final manager = $$TxnsTableTableManager(
      $_db,
      $_db.txns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_txnIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContributionsTableFilterComposer
    extends Composer<_$AppDatabase, $ContributionsTable> {
  $$ContributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get periodDue => $composableBuilder(
    column: $table.periodDue,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InsurancePoliciesTableFilterComposer get policyId {
    final $$InsurancePoliciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.policyId,
      referencedTable: $db.insurancePolicies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsurancePoliciesTableFilterComposer(
            $db: $db,
            $table: $db.insurancePolicies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TxnsTableFilterComposer get txnId {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.txnId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContributionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContributionsTable> {
  $$ContributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get periodDue => $composableBuilder(
    column: $table.periodDue,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InsurancePoliciesTableOrderingComposer get policyId {
    final $$InsurancePoliciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.policyId,
      referencedTable: $db.insurancePolicies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InsurancePoliciesTableOrderingComposer(
            $db: $db,
            $table: $db.insurancePolicies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TxnsTableOrderingComposer get txnId {
    final $$TxnsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.txnId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableOrderingComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContributionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContributionsTable> {
  $$ContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get periodDue =>
      $composableBuilder(column: $table.periodDue, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InsurancePoliciesTableAnnotationComposer get policyId {
    final $$InsurancePoliciesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.policyId,
          referencedTable: $db.insurancePolicies,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InsurancePoliciesTableAnnotationComposer(
                $db: $db,
                $table: $db.insurancePolicies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TxnsTableAnnotationComposer get txnId {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.txnId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContributionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContributionsTable,
          Contribution,
          $$ContributionsTableFilterComposer,
          $$ContributionsTableOrderingComposer,
          $$ContributionsTableAnnotationComposer,
          $$ContributionsTableCreateCompanionBuilder,
          $$ContributionsTableUpdateCompanionBuilder,
          (Contribution, $$ContributionsTableReferences),
          Contribution,
          PrefetchHooks Function({bool householdId, bool policyId, bool txnId})
        > {
  $$ContributionsTableTableManager(_$AppDatabase db, $ContributionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContributionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContributionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContributionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> policyId = const Value.absent(),
                Value<String> txnId = const Value.absent(),
                Value<DateTime> periodDue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContributionsCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                policyId: policyId,
                txnId: txnId,
                periodDue: periodDue,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String householdId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String policyId,
                required String txnId,
                required DateTime periodDue,
                Value<int> rowid = const Value.absent(),
              }) => ContributionsCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                policyId: policyId,
                txnId: txnId,
                periodDue: periodDue,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ContributionsTable, Contribution>(table),
                  $$ContributionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({householdId = false, policyId = false, txnId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (householdId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.householdId,
                            referencedTable: $$ContributionsTableReferences
                                ._householdIdTable(db),
                            referencedColumn: $$ContributionsTableReferences
                                ._householdIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (policyId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.policyId,
                            referencedTable: $$ContributionsTableReferences
                                ._policyIdTable(db),
                            referencedColumn: $$ContributionsTableReferences
                                ._policyIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (txnId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.txnId,
                            referencedTable: $$ContributionsTableReferences
                                ._txnIdTable(db),
                            referencedColumn: $$ContributionsTableReferences
                                ._txnIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ContributionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContributionsTable,
      Contribution,
      $$ContributionsTableFilterComposer,
      $$ContributionsTableOrderingComposer,
      $$ContributionsTableAnnotationComposer,
      $$ContributionsTableCreateCompanionBuilder,
      $$ContributionsTableUpdateCompanionBuilder,
      (Contribution, $$ContributionsTableReferences),
      Contribution,
      PrefetchHooks Function({bool householdId, bool policyId, bool txnId})
    >;
typedef $$ExchangeRatesTableCreateCompanionBuilder =
    ExchangeRatesCompanion Function({
      required String currency,
      required DateTime date,
      required double rateToBase,
      Value<int> rowid,
    });
typedef $$ExchangeRatesTableUpdateCompanionBuilder =
    ExchangeRatesCompanion Function({
      Value<String> currency,
      Value<DateTime> date,
      Value<double> rateToBase,
      Value<int> rowid,
    });

class $$ExchangeRatesTableFilterComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rateToBase => $composableBuilder(
    column: $table.rateToBase,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExchangeRatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rateToBase => $composableBuilder(
    column: $table.rateToBase,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExchangeRatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get rateToBase => $composableBuilder(
    column: $table.rateToBase,
    builder: (column) => column,
  );
}

class $$ExchangeRatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExchangeRatesTable,
          ExchangeRate,
          $$ExchangeRatesTableFilterComposer,
          $$ExchangeRatesTableOrderingComposer,
          $$ExchangeRatesTableAnnotationComposer,
          $$ExchangeRatesTableCreateCompanionBuilder,
          $$ExchangeRatesTableUpdateCompanionBuilder,
          (
            ExchangeRate,
            BaseReferences<_$AppDatabase, $ExchangeRatesTable, ExchangeRate>,
          ),
          ExchangeRate,
          PrefetchHooks Function()
        > {
  $$ExchangeRatesTableTableManager(_$AppDatabase db, $ExchangeRatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExchangeRatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExchangeRatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExchangeRatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> currency = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> rateToBase = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExchangeRatesCompanion(
                currency: currency,
                date: date,
                rateToBase: rateToBase,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String currency,
                required DateTime date,
                required double rateToBase,
                Value<int> rowid = const Value.absent(),
              }) => ExchangeRatesCompanion.insert(
                currency: currency,
                date: date,
                rateToBase: rateToBase,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExchangeRatesTable, ExchangeRate>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ExchangeRatesTable,
                    ExchangeRate
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExchangeRatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExchangeRatesTable,
      ExchangeRate,
      $$ExchangeRatesTableFilterComposer,
      $$ExchangeRatesTableOrderingComposer,
      $$ExchangeRatesTableAnnotationComposer,
      $$ExchangeRatesTableCreateCompanionBuilder,
      $$ExchangeRatesTableUpdateCompanionBuilder,
      (
        ExchangeRate,
        BaseReferences<_$AppDatabase, $ExchangeRatesTable, ExchangeRate>,
      ),
      ExchangeRate,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HouseholdsTableTableManager get households =>
      $$HouseholdsTableTableManager(_db, _db.households);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$ProvidersTableTableManager get providers =>
      $$ProvidersTableTableManager(_db, _db.providers);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$TxnsTableTableManager get txns => $$TxnsTableTableManager(_db, _db.txns);
  $$InsurancePoliciesTableTableManager get insurancePolicies =>
      $$InsurancePoliciesTableTableManager(_db, _db.insurancePolicies);
  $$ContributionsTableTableManager get contributions =>
      $$ContributionsTableTableManager(_db, _db.contributions);
  $$ExchangeRatesTableTableManager get exchangeRates =>
      $$ExchangeRatesTableTableManager(_db, _db.exchangeRates);
}
