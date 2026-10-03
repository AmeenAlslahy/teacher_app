import 'package:drift/drift.dart';
import 'teacher_tables.dart';
import 'subject_tables.dart';
import 'student_tables.dart';

// جدول الاختبارات
@DataClassName('ExamModel')
class Exams extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get schoolId => text().references(Schools, #id)();
  TextColumn get classId => text().references(Classes, #id)();
  TextColumn get sectionId => text().references(Sections, #id).nullable()();
  TextColumn get subjectId => text().references(Subjects, #id)();
  TextColumn get teacherId => text().references(Teachers, #id).nullable()();
  TextColumn get type => text().withDefault(const Constant('custom'))();
  TextColumn get academicYear =>
      text().withDefault(const Constant('2024-2025'))();
  TextColumn get semester => text().withDefault(const Constant('first'))();
  DateTimeColumn get examDate => dateTime()();
  IntColumn get duration => integer().withDefault(const Constant(45))();
  RealColumn get totalMarks => real().withDefault(const Constant(20))();
  TextColumn get instructions => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  BoolColumn get isTemplate => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// جدول الأسئلة
@DataClassName('QuestionModel')
class Questions extends Table {
  TextColumn get id => text()();
  TextColumn get examId => text().references(Exams, #id).nullable()();
  TextColumn get parentId =>
      text().nullable().references(Questions, #id)();
  TextColumn get questionBankId =>
      text().references(QuestionBankItems, #id).nullable()();
  TextColumn get type => text()();
  TextColumn get content => text()();
  TextColumn get instructions => text().nullable()();
  RealColumn get marks => real().withDefault(const Constant(1))();
  IntColumn get order => integer().withDefault(const Constant(0))();
  TextColumn get difficulty =>
      text().withDefault(const Constant('medium'))();
  TextColumn get unit => text().nullable()();
  TextColumn get lesson => text().nullable()();
  TextColumn get correctAnswer => text().nullable()();
  TextColumn get explanation => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// جدول خيارات الأسئلة
@DataClassName('QuestionOptionModel')
class QuestionOptions extends Table {
  TextColumn get id => text()();
  TextColumn get questionId => text().references(Questions, #id)();
  TextColumn get content => text()();
  IntColumn get order => integer().withDefault(const Constant(0))();
  BoolColumn get isCorrect => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// جدول كتل المحتوى
@DataClassName('QuestionBlockModel')
class QuestionBlocks extends Table {
  TextColumn get id => text()();
  TextColumn get questionId => text().references(Questions, #id)();
  TextColumn get type => text()();
  TextColumn get content => text()();
  IntColumn get order => integer().withDefault(const Constant(0))();
  TextColumn get metadata => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ✅ تم حذف ExamQuestions (لم يكن مستخدمًا)

// جدول بنك الأسئلة
@DataClassName('QuestionBankItemModel')
class QuestionBankItems extends Table {
  TextColumn get id => text()();
  TextColumn get subjectId => text().references(Subjects, #id)();
  TextColumn get classId => text().references(Classes, #id).nullable()();
  TextColumn get type => text()();
  TextColumn get content => text()();
  TextColumn get unit => text().nullable()();
  TextColumn get lesson => text().nullable()();
  TextColumn get difficulty =>
      text().withDefault(const Constant('medium'))();
  RealColumn get marks => real().withDefault(const Constant(1))();
  TextColumn get correctAnswer => text().nullable()();
  TextColumn get explanation => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// جدول درجات الاختبار
@DataClassName('ExamGradeModel')
class ExamGrades extends Table {
  TextColumn get id => text()();
  TextColumn get examId => text().references(Exams, #id)();
  TextColumn get studentId => text().references(Students, #id)();
  RealColumn get score => real().withDefault(const Constant(0))();
  TextColumn get grade => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isAbsent => boolean().withDefault(const Constant(false))();
  DateTimeColumn get gradedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// جدول قوالب الاختبارات
@DataClassName('ExamTemplateModel')
class ExamTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get schoolId => text().references(Schools, #id).nullable()();
  TextColumn get classId => text().references(Classes, #id).nullable()();
  TextColumn get subjectId => text().references(Subjects, #id).nullable()();
  TextColumn get type => text().nullable()();
  IntColumn get duration => integer().nullable()();
  RealColumn get totalMarks => real().nullable()();
  TextColumn get structure => text().nullable()();
  TextColumn get settings => text().nullable()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
