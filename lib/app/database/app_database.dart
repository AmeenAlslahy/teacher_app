import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'tables/teacher_tables.dart';
import 'tables/subject_tables.dart';
import 'tables/student_tables.dart';
import 'tables/exam_tables.dart';
// import 'daos/daos.dart';
part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Teachers,
    Schools,
    Classes,
    Sections,
    Subjects,
    Students,
    Exams,
    Questions,
    QuestionBlocks,
    QuestionOptions,
    QuestionBankItems,
    ExamGrades,
    ExamTemplates,
    /*
    Grades,
    GradeComponents,
    Assignments,
    AssignmentGrades,
    Attendance,
    AttendanceRecords,
    Reports,
    AppSettings,
    BackupMetadata,
    */
  ],
  /*
  daos: [
    TeacherDao,
    SchoolDao,
    ClassDao,
    SubjectDao,
    StudentDao,
    ExamDao,
    QuestionDao,
    GradeDao,
    AssignmentDao,
    AttendanceDao,
    TemplateDao,
    ReportDao,
    SettingsDao,
  ],
  */
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        // ✅ تفعيل قيود Foreign Keys في SQLite (معطّلة افتراضيًا)
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // ⚠️ DEVELOPMENT MIGRATION — يمسح كل البيانات
          // TODO: قبل الإنتاج، استبدل بـ migration حقيقي يحفظ البيانات
          if (from < 2) {
            for (final table in allTables) {
              await m.deleteTable(table.actualTableName);
            }
            await m.createAll();
          }
        },
      );

  static const int _backupVersion = 1;

  Future<Map<String, dynamic>> exportData() async {
    return {
      'version': _backupVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'schools': (await select(schools).get()).map((s) => s.toJson()).toList(),
      'classes': (await select(classes).get()).map((c) => c.toJson()).toList(),
      'sections':
          (await select(sections).get()).map((s) => s.toJson()).toList(),
      'subjects':
          (await select(subjects).get()).map((s) => s.toJson()).toList(),
      'students':
          (await select(students).get()).map((s) => s.toJson()).toList(),
      'exams': (await select(exams).get()).map((e) => e.toJson()).toList(),
      'questions':
          (await select(questions).get()).map((q) => q.toJson()).toList(),
      'questionOptions':
          (await select(questionOptions).get()).map((o) => o.toJson()).toList(),
      'examGrades':
          (await select(examGrades).get()).map((g) => g.toJson()).toList(),
      'questionBlocks':
          (await select(questionBlocks).get()).map((b) => b.toJson()).toList(),
      'examTemplates':
          (await select(examTemplates).get()).map((e) => e.toJson()).toList(),
    };
  }

  /// استيراد البيانات
  Future<void> importData(Map<String, dynamic> data) async {
    final version = data['version'] as int? ?? 1;
    if (version > _backupVersion) {
      throw Exception('النسخة الاحتياطية أحدث من التطبيق الحالي');
    }

    await transaction(() async {
      if (data['schools'] is List) {
        for (var item in data['schools']) {
          await into(schools).insert(
            School.fromJson(item as Map<String, dynamic>),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
      if (data['classes'] is List) {
        for (var item in data['classes']) {
          await into(classes).insert(
            ClassesData.fromJson(item as Map<String, dynamic>),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
      if (data['sections'] is List) {
        for (var item in data['sections']) {
          await into(sections).insert(
            Section.fromJson(item as Map<String, dynamic>),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
      if (data['subjects'] is List) {
        for (var item in data['subjects']) {
          await into(subjects).insert(
            Subject.fromJson(item as Map<String, dynamic>),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
      if (data['students'] is List) {
        for (var item in data['students']) {
          await into(students).insert(
            Student.fromJson(item as Map<String, dynamic>),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
      if (data['exams'] is List) {
        for (var item in data['exams']) {
          await into(exams).insert(
            ExamModel.fromJson(item as Map<String, dynamic>),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
      if (data['questions'] is List) {
        for (var item in data['questions']) {
          await into(questions).insert(
            QuestionModel.fromJson(item as Map<String, dynamic>),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
      if (data['questionOptions'] is List) {
        for (var item in data['questionOptions']) {
          await into(questionOptions).insert(
            QuestionOptionModel.fromJson(item as Map<String, dynamic>),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
      if (data['examGrades'] is List) {
        for (var item in data['examGrades']) {
          await into(examGrades).insert(
            ExamGradeModel.fromJson(item as Map<String, dynamic>),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
      if (data['questionBlocks'] is List) {
        for (var item in data['questionBlocks']) {
          await into(questionBlocks).insert(
            QuestionBlockModel.fromJson(item as Map<String, dynamic>),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
      if (data['examTemplates'] is List) {
        for (var item in data['examTemplates']) {
          await into(examTemplates).insert(
            ExamTemplateModel.fromJson(item as Map<String, dynamic>),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
    });
  }
}

/// فتح قاعدة البيانات
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'teacher_exam_manager.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
