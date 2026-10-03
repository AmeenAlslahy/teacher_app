import 'package:drift/drift.dart';
import '../../../../app/database/app_database.dart';

class ClassRepository {
  final AppDatabase _database;

  ClassRepository(this._database);

  Future<List<ClassesData>> getAll() async {
    return await _database.select(_database.classes).get();
  }

  Future<List<ClassesData>> getBySchool(String schoolId) async {
    return await (_database.select(_database.classes)
          ..where((t) => t.schoolId.equals(schoolId))
          ..orderBy([(t) => OrderingTerm.asc(t.gradeLevel)]))
        .get();
  }

  Future<ClassesData?> getById(String id) async {
    return await (_database.select(_database.classes)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> create(ClassesData cls) async {
    await _database.into(_database.classes).insert(
          ClassesCompanion.insert(
            id: cls.id,
            schoolId: cls.schoolId,
            name: cls.name,
            gradeLevel: cls.gradeLevel,
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  // ===== الأقسام (Sections) =====

  Future<List<Section>> getAllSections() async {
    return await _database.select(_database.sections).get();
  }

  Future<List<Section>> getSectionsByClass(String classId) async {
    return await (_database.select(_database.sections)
          ..where((t) => t.classId.equals(classId)))
        .get();
  }

  Future<void> createSection(Section section) async {
    await _database.into(_database.sections).insert(
          SectionsCompanion.insert(
            id: section.id,
            classId: section.classId,
            name: section.name,
            academicYear: Value(section.academicYear),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }
}
