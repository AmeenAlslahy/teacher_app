import 'package:drift/drift.dart';
import '../../../../app/database/app_database.dart';

class SchoolRepository {
  final AppDatabase _database;

  SchoolRepository(this._database);

  Future<List<School>> getAll() async {
    return await _database.select(_database.schools).get();
  }

  Future<School?> getById(String id) async {
    return await (_database.select(_database.schools)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<School?> getDefault() async {
    return await (_database.select(_database.schools)
          ..where((t) => t.isDefault.equals(true)))
        .getSingleOrNull();
  }

  Future<void> create(School school) async {
    await _database.into(_database.schools).insert(
          SchoolsCompanion.insert(
            id: school.id,
            name: school.name,
            logo: Value(school.logo),
            educationAuthority: Value(school.educationAuthority),
            address: Value(school.address),
            phone: Value(school.phone),
            academicYear: Value(school.academicYear),
            isDefault: Value(school.isDefault),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> update(School school) async {
    await (_database.update(_database.schools)
          ..where((t) => t.id.equals(school.id)))
        .write(
      SchoolsCompanion(
        name: Value(school.name),
        logo: Value(school.logo),
        educationAuthority: Value(school.educationAuthority),
        address: Value(school.address),
        phone: Value(school.phone),
        academicYear: Value(school.academicYear),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setDefault(String id) async {
    await _database.transaction(() async {
      await _database
          .update(_database.schools)
          .write(const SchoolsCompanion(isDefault: Value(false)));
      await (_database.update(_database.schools)
            ..where((t) => t.id.equals(id)))
          .write(const SchoolsCompanion(isDefault: Value(true)));
    });
  }

  Future<void> delete(String id) async {
    await (_database.delete(_database.schools)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  /// يملأ المدرسة الافتراضية + الصفوف + المواد إن كانت فارغة أو بحاجة لتحديث
  Future<void> seedIfEmpty() async {
    final existing = await getAll();
    
    // Check if we need to force re-seed to apply the new Yemeni curriculum
    bool needsReseed = false;
    if (existing.isEmpty) {
      needsReseed = true;
    } else {
      final defaultSchool = existing.firstWhere((s) => s.id == 'school_default', orElse: () => existing.first);
      if (defaultSchool.name != 'مدرسة الأنوار النموذجية') {
        needsReseed = true;
      }
    }

    if (!needsReseed) return;

    await _database.transaction(() async {
      // Force wipe old default data to avoid duplicates/conflicts during reseed
      await _database.delete(_database.subjects).go();
      await _database.delete(_database.sections).go();
      await _database.delete(_database.classes).go();
      await _database.delete(_database.schools).go();

      await _database.into(_database.schools).insert(
            SchoolsCompanion.insert(
              id: 'school_default',
              name: 'مدرسة الأنوار النموذجية',
              isDefault: const Value(true),
            ),
          );

      final classNames = [
        'الأول',
        'الثاني',
        'الثالث',
        'الرابع',
        'الخامس',
        'السادس',
        'السابع',
        'الثامن',
        'التاسع',
        'الأول ثانوي',
        'الثاني ثانوي',
        'الثالث الثانوي',
      ];

      for (var i = 0; i < classNames.length; i++) {
        final gradeLevel = i + 1;
        final classId = 'class_$gradeLevel';

        await _database.into(_database.classes).insert(
              ClassesCompanion.insert(
                id: classId,
                schoolId: 'school_default',
                name: 'الصف ${classNames[i]}',
                gradeLevel: gradeLevel.toString(),
              ),
            );

        final sectionNames = gradeLevel <= 9 ? ['أ', 'ب'] : ['أ', 'ب', 'ج', 'د'];
        for (var j = 0; j < sectionNames.length; j++) {
          await _database.into(_database.sections).insert(
                SectionsCompanion.insert(
                  id: 'section_${gradeLevel}_${j + 1}',
                  classId: classId,
                  name: sectionNames[j],
                ),
              );
        }
      }

      const subjects = [
        'القرآن الكريم وعلومه',
        'التربية الإسلامية',
        'اللغة العربية',
        'الرياضيات',
        'العلوم',
        'الفيزياء',
        'الكيمياء',
        'الأحياء',
        'التاريخ',
        'الجغرافيا',
        'المجتمع',
        'اللغة الإنجليزية',
        'الحاسوب',
      ];
      for (var i = 0; i < subjects.length; i++) {
        await _database.into(_database.subjects).insert(
              SubjectsCompanion.insert(
                id: 'subject_${i + 1}',
                schoolId: 'school_default',
                name: subjects[i],
              ),
            );
      }
    });
  }
}
