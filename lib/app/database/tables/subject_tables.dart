import 'package:drift/drift.dart';
import 'teacher_tables.dart';

class Subjects extends Table {
  TextColumn get id => text().unique()();
  TextColumn get schoolId => text().references(Schools, #id)();
  TextColumn get name => text()();
  TextColumn get color => text().nullable()();
  TextColumn get icon => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();   // ✅ جديد

  @override
  Set<Column> get primaryKey => {id};
}
