import 'package:drift/drift.dart';
import '../../../../app/database/app_database.dart';

class SubjectRepository {
  final AppDatabase _database;

  SubjectRepository(this._database);

  Future<List<Subject>> getAll() async {
    return await _database.select(_database.subjects).get();
  }

  Future<List<Subject>> getBySchool(String schoolId) async {
    return await (_database.select(_database.subjects)
          ..where((t) => t.schoolId.equals(schoolId))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Future<Subject?> getById(String id) async {
    return await (_database.select(_database.subjects)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> create(Subject subject) async {
    await _database.into(_database.subjects).insert(
          SubjectsCompanion.insert(
            id: subject.id,
            schoolId: subject.schoolId,
            name: subject.name,
            color: Value(subject.color),
            icon: Value(subject.icon),
            description: Value(subject.description),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }
}
