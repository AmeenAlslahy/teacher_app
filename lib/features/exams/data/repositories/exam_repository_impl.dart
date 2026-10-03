import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../app/database/app_database.dart';
import '../../domain/entities/exam.dart';
import 'exam_repository.dart';

class ExamRepositoryImpl implements ExamRepository {
  final AppDatabase _database;
  
  ExamRepositoryImpl(this._database);
  
  @override
  Future<Exam> createExam(Exam exam) async {
    final examData = _mapExamToCompanion(exam);
    await _database.into(_database.exams).insert(examData);
    return exam;
  }
  
  @override
  Future<List<Exam>> getAllExams({
    String? schoolId,
    String? classId,
    String? subjectId,
    ExamStatus? status,
  }) async {
    final query = _database.select(_database.exams)
      ..where((tbl) => tbl.isDeleted.equals(false));
    
    if (schoolId != null) query.where((tbl) => tbl.schoolId.equals(schoolId));
    if (classId != null) query.where((tbl) => tbl.classId.equals(classId));
    if (subjectId != null) query.where((tbl) => tbl.subjectId.equals(subjectId));
    if (status != null) query.where((tbl) => tbl.status.equals(status.name));
    
    query.orderBy([(tbl) => OrderingTerm.desc(tbl.examDate)]);
    
    final exams = await query.get();
    return exams.map(_mapExamToEntity).toList();
  }
  
  @override
  Future<Exam?> getExamById(String id) async {
    final exam = await (_database.select(_database.exams)
      ..where((tbl) => tbl.id.equals(id) & tbl.isDeleted.equals(false)))
      .getSingleOrNull();
    
    return exam != null ? _mapExamToEntity(exam) : null;
  }
  
  @override
  Future<void> updateExam(Exam exam) async {
    await (_database.update(_database.exams)
      ..where((tbl) => tbl.id.equals(exam.id)))
      .write(_mapExamToCompanion(exam, isUpdate: true));
  }
  
  @override
  Future<void> deleteExam(String id) async {
    await (_database.update(_database.exams)
      ..where((tbl) => tbl.id.equals(id)))
      .write(ExamsCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(DateTime.now()),
      ));
  }
  
  @override
  Future<Exam> duplicateExam(String id) async {
    final original = await getExamById(id);
    if (original == null) throw Exception('الاختبار غير موجود');
    
    final newExam = original.copyWith(
      id: _generateId(),
      title: '${original.title} (نسخة)',
      status: ExamStatus.draft,
      createdAt: DateTime.now(),
    );
    
    return await _database.transaction(() async {
      await createExam(newExam);
      
      // نسخ الأسئلة
      final questions = await getQuestionsForExam(id);
      for (final question in questions) {
        final newQuestionId = _generateId() + question.order.toString();
        
        final newQuestion = question.copyWith(
          id: newQuestionId,
          examId: newExam.id,
          createdAt: DateTime.now(),
          options: question.options.map((o) => QuestionOption(
            id: '${newQuestionId}_opt_${o.order}',
            questionId: newQuestionId,
            content: o.content,
            order: o.order,
            isCorrect: o.isCorrect,
          )).toList(),
          blocks: question.blocks.map((b) => QuestionBlock(
            id: '${newQuestionId}_blk_${b.order}',
            questionId: newQuestionId,
            type: b.type,
            content: b.content,
            order: b.order,
            metadata: b.metadata,
          )).toList(),
        );
        
        await addQuestion(newQuestion);
      }
      
      return newExam;
    });
  }
  
  @override
  Future<Question> addQuestion(Question question) async {
    await _database.transaction(() async {
      final questionData = _mapQuestionToCompanion(question);
      await _database.into(_database.questions).insertOnConflictUpdate(questionData);

      // Synchronize child collections so edits can remove stale options/blocks.
      await (_database.delete(_database.questionOptions)
        ..where((tbl) => tbl.questionId.equals(question.id))).go();
      await (_database.delete(_database.questionBlocks)
        ..where((tbl) => tbl.questionId.equals(question.id))).go();

      // إضافة الخيارات
      for (final option in question.options) {
      await _database.into(_database.questionOptions).insertOnConflictUpdate(
        QuestionOptionsCompanion.insert(
          id: option.id,
          questionId: option.questionId,
          content: option.content,
          order: Value(option.order),
          isCorrect: Value(option.isCorrect),
        ),
      );
    }
    
      // إضافة الكتل
      for (final block in question.blocks) {
        await _database.into(_database.questionBlocks).insertOnConflictUpdate(
          QuestionBlocksCompanion.insert(
            id: block.id,
            questionId: block.questionId,
            type: block.type.name,
            content: block.content,
            metadata: Value(block.metadata != null ? jsonEncode(block.metadata) : null),
          ),
        );
      }
    });

    return question;
  }
  
  @override
  Future<List<Question>> getQuestionsForExam(String examId) async {
    final questions = await (_database.select(_database.questions)
      ..where((tbl) => tbl.examId.equals(examId) & tbl.isDeleted.equals(false))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.order)]))
      .get();
    
    final result = <Question>[];
    
    for (final q in questions) {
      final options = await _getOptionsForQuestion(q.id);
      final blocks = await _getBlocksForQuestion(q.id);
      
      result.add(_mapQuestionToEntity(q, options, blocks));
    }
    
    return result;
  }
  
  @override
  Future<void> deleteQuestion(String questionId) async {
    await (_database.update(_database.questions)
      ..where((tbl) => tbl.id.equals(questionId)))
      .write(QuestionsCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(DateTime.now()),
      ));
  }
  
  @override
  Future<void> reorderQuestions(List<String> questionIds) async {
    for (var i = 0; i < questionIds.length; i++) {
      await (_database.update(_database.questions)
        ..where((tbl) => tbl.id.equals(questionIds[i])))
        .write(QuestionsCompanion(
          order: Value(i),
          updatedAt: Value(DateTime.now()),
        ));
    }
  }

    @override
  Future<Question?> getQuestionById(String id) async {
    // البحث عن السؤال في قاعدة البيانات
    final question = await (_database.select(_database.questions)
      ..where((tbl) => tbl.id.equals(id) & tbl.isDeleted.equals(false)))
      .getSingleOrNull();
    
    if (question == null) return null;
    
    // جلب الخيارات والكتل
    final options = await _getOptionsForQuestion(id);
    final blocks = await _getBlocksForQuestion(id);
    
    return _mapQuestionToEntity(question, options, blocks);
  }

  
  @override
  Future<double> calculateTotalMarks(String examId) async {
    final questions = await getQuestionsForExam(examId);
    return questions.fold<double>(0.0, (sum, q) => sum + q.marks);
  }
  
  @override
  Future<List<String>> validateExam(String examId) async {
    final errors = <String>[];
    final exam = await getExamById(examId);
    
    if (exam == null) {
      errors.add('الاختبار غير موجود');
      return errors;
    }
    
    if (exam.title.isEmpty) errors.add('عنوان الاختبار مطلوب');
    if (exam.schoolId.isEmpty) errors.add('المدرسة مطلوبة');
    if (exam.classId.isEmpty) errors.add('الصف مطلوب');
    if (exam.subjectId.isEmpty) errors.add('المادة مطلوبة');
    
    final questions = await getQuestionsForExam(examId);
    if (questions.isEmpty) errors.add('يجب إضافة سؤال واحد على الأقل');
    
    final totalQuestionsMarks = questions.fold(0.0, (sum, q) => sum + q.marks);
    if (totalQuestionsMarks != exam.totalMarks) {
      errors.add('مجموع درجات الأسئلة ($totalQuestionsMarks) لا يساوي الدرجة النهائية (${exam.totalMarks})');
    }
    
    return errors;
  }
  
  // ============================
  // دوال مساعدة (Mapping)
  // ============================
  
  String _generateId() => DateTime.now().millisecondsSinceEpoch.toString();
  
  ExamsCompanion _mapExamToCompanion(Exam exam, {bool isUpdate = false}) {
    return ExamsCompanion(
      id: Value(exam.id),
      title: Value(exam.title),
      schoolId: Value(exam.schoolId),
      classId: Value(exam.classId),
      sectionId: Value(exam.sectionId),
      subjectId: Value(exam.subjectId),
      teacherId: Value(exam.teacherId),
      type: Value(exam.type.name),
      academicYear: Value(exam.academicYear),
      semester: Value(exam.semester.name),
      examDate: Value(exam.examDate),
      duration: Value(exam.duration),
      totalMarks: Value(exam.totalMarks),
      instructions: Value(exam.instructions),
      status: Value(exam.status.name),
      isTemplate: Value(exam.isTemplate),
      createdAt: isUpdate ? const Value.absent() : Value(exam.createdAt),
      updatedAt: isUpdate ? Value(DateTime.now()) : const Value.absent(),
    );
  }
  
  Exam _mapExamToEntity(ExamModel e) {
    return Exam(
      id: e.id,
      title: e.title,
      schoolId: e.schoolId,
      classId: e.classId,
      sectionId: e.sectionId,
      subjectId: e.subjectId,
      teacherId: e.teacherId,
      type: ExamType.values.firstWhere((t) => t.name == e.type, orElse: () => ExamType.custom),
      academicYear: e.academicYear,
      semester: Semester.values.firstWhere((s) => s.name == e.semester, orElse: () => Semester.first),
      examDate: e.examDate,
      duration: e.duration,
      totalMarks: e.totalMarks,
      instructions: e.instructions,
      status: ExamStatus.values.firstWhere((s) => s.name == e.status, orElse: () => ExamStatus.draft),
      isTemplate: e.isTemplate,
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
    );
  }
  
  QuestionsCompanion _mapQuestionToCompanion(Question question) {
    return QuestionsCompanion.insert(
      id: question.id,
      examId: Value(question.examId),
      parentId: Value(question.parentId),
      type: question.type.name,
      content: question.content,
      instructions: Value(question.instructions),
      marks: Value(question.marks),
      order: Value(question.order),
      difficulty: Value(question.difficulty.name),
      unit: Value(question.unit),
      lesson: Value(question.lesson),
      correctAnswer: Value(question.correctAnswer),
      explanation: Value(question.explanation),
      createdAt: Value(question.createdAt),
    );
  }
  
  Question _mapQuestionToEntity(
    QuestionModel q,
    List<QuestionOptionModel> options,
    List<QuestionBlockModel> blocks,
  ) {
    return Question(
      id: q.id,
      examId: q.examId,
      parentId: q.parentId,
      type: QuestionType.values.firstWhere(
        (t) => t.name == q.type,
        orElse: () => QuestionType.multipleChoice,
      ),
      content: q.content,
      instructions: q.instructions,
      marks: q.marks,
      order: q.order,
      difficulty: Difficulty.values.firstWhere(
        (d) => d.name == q.difficulty,
        orElse: () => Difficulty.medium,
      ),
      unit: q.unit,
      lesson: q.lesson,
      correctAnswer: q.correctAnswer,
      explanation: q.explanation,
      options: options.map((o) => QuestionOption(
        id: o.id,
        questionId: o.questionId,
        content: o.content,
        order: o.order,
        isCorrect: o.isCorrect,
      )).toList(),
      blocks: blocks.map((b) => QuestionBlock(
        id: b.id,
        questionId: b.questionId,
        type: BlockType.values.firstWhere(
          (t) => t.name == b.type,
          orElse: () => BlockType.text,
        ),
        content: b.content,
        order: b.order,
        metadata: b.metadata != null 
            ? Map<String, dynamic>.from(jsonDecode(b.metadata!)) 
            : null,
      )).toList(),
      createdAt: q.createdAt,
      updatedAt: q.updatedAt,
    );
  }
  
  Future<List<QuestionOptionModel>> _getOptionsForQuestion(String questionId) async {
    return await (_database.select(_database.questionOptions)
      ..where((tbl) => tbl.questionId.equals(questionId))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.order)]))
      .get();
  }
  
  Future<List<QuestionBlockModel>> _getBlocksForQuestion(String questionId) async {
    return await (_database.select(_database.questionBlocks)
      ..where((tbl) => tbl.questionId.equals(questionId))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.order)]))
      .get();
  }

}