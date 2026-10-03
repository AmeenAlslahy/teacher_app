import '../../../../app/database/app_database.dart' hide Student;
import 'package:drift/drift.dart';
import '../../domain/entities/student.dart';
import '../services/student_import_service.dart';
import 'package:flutter/foundation.dart';

class StudentRepository {
  final AppDatabase database;
  
  StudentRepository(this.database);
  
  Future<List<Student>> getAllStudents() async {
    final list = await (database.select(database.students)..where((tbl) => tbl.isDeleted.equals(false))).get();
    return list.map((s) => Student(
      id: s.id,
      name: s.name,
      studentNumber: s.studentNumber,
      classId: s.classId,
      sectionId: s.sectionId,
      parentPhone: s.parentPhone,
      profileImage: s.profileImage,
      notes: s.notes,
      gender: s.gender,
      email: s.email,
      address: s.address,
      createdAt: s.createdAt,
      updatedAt: s.updatedAt,
    )).toList();
  }
  
  Future<List<ClassesData>> getClasses() async {
    return await database.select(database.classes).get();
  }
  
  Future<List<Section>> getSections() async {
    return await database.select(database.sections).get();
  }
  
  Future<void> seedDefaultClassesAndSections() async {
    final existingClasses = await getClasses();
    if (existingClasses.isNotEmpty) return;
    
    // Seed default school
    await database.into(database.schools).insert(
      SchoolsCompanion.insert(
        id: 'school_1',
        name: 'مدرسة النور',
      ),
      mode: InsertMode.insertOrIgnore,
    );
    
    // Seed classes
    final classesData = [
      ClassesCompanion.insert(id: 'c1', schoolId: 'school_1', name: 'الصف الأول', gradeLevel: '1'),
      ClassesCompanion.insert(id: 'c2', schoolId: 'school_1', name: 'الصف الثاني', gradeLevel: '2'),
      ClassesCompanion.insert(id: 'c3', schoolId: 'school_1', name: 'الصف الثالث', gradeLevel: '3'),
    ];
    for (var c in classesData) {
      await database.into(database.classes).insert(c, mode: InsertMode.insertOrIgnore);
    }
    
    // Seed sections
    final sectionsData = [
      SectionsCompanion.insert(id: 's1_a', classId: 'c1', name: 'شعبة أ'),
      SectionsCompanion.insert(id: 's1_b', classId: 'c1', name: 'شعبة ب'),
      SectionsCompanion.insert(id: 's2_a', classId: 'c2', name: 'شعبة أ'),
      SectionsCompanion.insert(id: 's3_a', classId: 'c3', name: 'شعبة أ'),
    ];
    for (var s in sectionsData) {
      await database.into(database.sections).insert(s, mode: InsertMode.insertOrIgnore);
    }
  }

  Future<Student?> getStudentById(String id) async {
    final s = await (database.select(database.students)..where((tbl) => tbl.id.equals(id) & tbl.isDeleted.equals(false))).getSingleOrNull();
    if (s == null) return null;
    return Student(
      id: s.id,
      name: s.name,
      studentNumber: s.studentNumber,
      classId: s.classId,
      sectionId: s.sectionId,
      parentPhone: s.parentPhone,
      profileImage: s.profileImage,
      notes: s.notes,
      gender: s.gender,
      email: s.email,
      address: s.address,
      createdAt: s.createdAt,
      updatedAt: s.updatedAt,
    );
  }
  
  Future<void> updateStudent(Student student) async {
    await (database.update(database.students)..where((tbl) => tbl.id.equals(student.id))).write(
      StudentsCompanion(
        name: Value(student.name),
        studentNumber: Value(student.studentNumber),
        classId: Value(student.classId),
        sectionId: Value(student.sectionId),
        parentPhone: Value(student.parentPhone),
        profileImage: Value(student.profileImage),
        notes: Value(student.notes),
        gender: Value(student.gender),
        email: Value(student.email),
        address: Value(student.address),
        updatedAt: Value(DateTime.now()),
      )
    );
  }
  
  Future<void> createStudent(Student student) async {
    await database.into(database.students).insert(
      StudentsCompanion.insert(
        id: student.id,
        name: student.name,
        studentNumber: student.studentNumber,
        classId: student.classId,
        sectionId: Value(student.sectionId),
        parentPhone: Value(student.parentPhone),
        profileImage: Value(student.profileImage),
        notes: Value(student.notes),
        gender: Value(student.gender),
        email: Value(student.email),
        address: Value(student.address),
        createdAt: Value(student.createdAt),
      )
    );
  }
  
  Future<void> softDeleteStudent(String id) async {
    await (database.update(database.students)..where((tbl) => tbl.id.equals(id))).write(
      StudentsCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(DateTime.now()),
      )
    );
  }
  
  Future<ImportResult> importStudents(List<StudentImportModel> students) async {
    int success = 0;
    int failed = 0;
    
    final classes = await getClasses();
    final sections = await getSections();

    await database.transaction(() async {
      for (final s in students) {
        try {
          final classId = classes.firstWhere(
            (c) => c.name == s.className,
            orElse: () => classes.first,
          ).id;

          String? sectionId;
          if (s.sectionName != null && s.sectionName!.isNotEmpty) {
             final matchingSections = sections.where((sec) => sec.name == s.sectionName && sec.classId == classId).toList();
             if (matchingSections.isNotEmpty) {
               sectionId = matchingSections.first.id;
             }
          }

          await createStudent(Student(
            id: DateTime.now().microsecondsSinceEpoch.toString() + success.toString(),
            name: s.name,
            studentNumber: s.studentNumber,
            classId: classId,
            sectionId: sectionId,
            createdAt: DateTime.now(),
          ));
          success++;
          debugPrint('✅ Successfully imported student: ${s.name}');
        } catch (e) {
          failed++;
          debugPrint('❌ Failed to import student ${s.name}: $e');
        }
      }
    });
    
    debugPrint('📊 Import finished: $success successful, $failed failed.');
    return ImportResult(successCount: success, failedCount: failed);
  }
}