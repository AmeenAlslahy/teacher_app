import 'package:drift/drift.dart';

import 'teacher_tables.dart';

class Students extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text().withLength(min: 2, max: 100)();
  TextColumn get studentNumber => text().unique().withLength(min: 1, max: 50)();
  TextColumn get classId => text().references(Classes, #id)();
  TextColumn get sectionId => text().references(Sections, #id).nullable()();
  TextColumn get parentPhone => text().nullable()();
  TextColumn get profileImage => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get gender => text().nullable()(); // 'male', 'female', 'other'
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  @override
  Set<Column> get primaryKey => {id};
}
