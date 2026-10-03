import 'package:drift/drift.dart';

class Teachers extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text()();
  TextColumn get specialty => text().nullable()();
  TextColumn get profileImage => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();   // ✅ جديد

  @override
  Set<Column> get primaryKey => {id};
}

class Schools extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text()();
  TextColumn get logo => text().nullable()();
  TextColumn get educationAuthority => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get academicYear =>
      text().withDefault(const Constant('2024-2025'))();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();   // ✅ جديد

  @override
  Set<Column> get primaryKey => {id};
}

class Classes extends Table {
  TextColumn get id => text().unique()();
  TextColumn get schoolId => text().references(Schools, #id)();
  TextColumn get name => text()();
  TextColumn get gradeLevel => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();   // ✅ جديد

  @override
  Set<Column> get primaryKey => {id};
}

class Sections extends Table {
  TextColumn get id => text().unique()();
  TextColumn get classId => text().references(Classes, #id)();
  TextColumn get name => text()();
  TextColumn get academicYear =>
      text().withDefault(const Constant('2024-2025'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();   // ✅ جديد

  @override
  Set<Column> get primaryKey => {id};
}