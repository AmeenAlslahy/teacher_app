

class Exam {
  final String id;
  final String title;
  final String schoolId;
  final String classId;
  final String? sectionId;
  final String subjectId;
  final String? teacherId;
  final ExamType type;
  final String academicYear;
  final Semester semester;
  final DateTime examDate;
  final int duration;
  final double totalMarks;
  final String? instructions;
  final ExamStatus status;
  final bool isTemplate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  const Exam({
    required this.id,
    required this.title,
    required this.schoolId,
    required this.classId,
    this.sectionId,
    required this.subjectId,
    this.teacherId,
    required this.type,
    required this.academicYear,
    required this.semester,
    required this.examDate,
    required this.duration,
    required this.totalMarks,
    this.instructions,
    this.status = ExamStatus.draft,
    this.isTemplate = false,
    required this.createdAt,
    this.updatedAt,
  });
  
  Exam copyWith({
    String? id,
    String? title,
    String? schoolId,
    String? classId,
    String? sectionId,
    String? subjectId,
    String? teacherId,
    ExamType? type,
    String? academicYear,
    Semester? semester,
    DateTime? examDate,
    int? duration,
    double? totalMarks,
    String? instructions,
    ExamStatus? status,
    bool? isTemplate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Exam(
      id: id ?? this.id,
      title: title ?? this.title,
      schoolId: schoolId ?? this.schoolId,
      classId: classId ?? this.classId,
      sectionId: sectionId ?? this.sectionId,
      subjectId: subjectId ?? this.subjectId,
      teacherId: teacherId ?? this.teacherId,
      type: type ?? this.type,
      academicYear: academicYear ?? this.academicYear,
      semester: semester ?? this.semester,
      examDate: examDate ?? this.examDate,
      duration: duration ?? this.duration,
      totalMarks: totalMarks ?? this.totalMarks,
      instructions: instructions ?? this.instructions,
      status: status ?? this.status,
      isTemplate: isTemplate ?? this.isTemplate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  
}

enum ExamType {
  monthly('شهري'),
  midterm('نصفي'),
  finalExam('نهائي'),
  quiz('قصير'),
  practice('تجريبي'),
  assignment('واجب'),
  custom('مخصص');
  
  final String label;
  const ExamType(this.label);
}

enum Semester {
  first('الفصل الأول'),
  second('الفصل الثاني');
  
  final String label;
  const Semester(this.label);
}

enum ExamStatus {
  draft('مسودة'),
  ready('جاهز'),
  published('منشور'),
  archived('مؤرشف');
  
  final String label;
  const ExamStatus(this.label);
}

// كيان السؤال
class Question {
  final String id;
  final String? examId;
  final String? parentId;
  final QuestionType type;
  final String content;
  final String? instructions;
  final double marks;
  final int order;
  final Difficulty difficulty;
  final String? unit;
  final String? lesson;
  final String? correctAnswer;
  final String? explanation;
  final List<QuestionOption> options;
  final List<QuestionBlock> blocks;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  const Question({
    required this.id,
    this.examId,
    this.parentId,
    required this.type,
    required this.content,
    this.instructions,
    required this.marks,
    required this.order,
    this.difficulty = Difficulty.medium,
    this.unit,
    this.lesson,
    this.correctAnswer,
    this.explanation,
    this.options = const [],
    this.blocks = const [],
    required this.createdAt,
    this.updatedAt,
  });

  Question copyWith({
    String? id,
    String? examId,
    String? parentId,
    QuestionType? type,
    String? content,
    String? instructions,
    double? marks,
    int? order,
    Difficulty? difficulty,
    String? unit,
    String? lesson,
    String? correctAnswer,
    String? explanation,
    List<QuestionOption>? options,
    List<QuestionBlock>? blocks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Question(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      parentId: parentId ?? this.parentId,
      type: type ?? this.type,
      content: content ?? this.content,
      instructions: instructions ?? this.instructions,
      marks: marks ?? this.marks,
      order: order ?? this.order,
      difficulty: difficulty ?? this.difficulty,
      unit: unit ?? this.unit,
      lesson: lesson ?? this.lesson,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      explanation: explanation ?? this.explanation,
      options: options ?? this.options,
      blocks: blocks ?? this.blocks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

enum QuestionType {
  groupHeader('سؤال رئيسي'),
  multipleChoice('اختيار من متعدد'),
  trueFalse('صح وخطأ'),
  shortAnswer('إجابة قصيرة'),
  essay('مقالي'),
  fillBlank('ملء الفراغ'),
  matching('مطابقة'),
  ordering('ترتيب'),
  multipleAnswers('إجابات متعددة'),
  image('صورة'),
  table('جدول'),
  math('معادلة رياضية');
  
  final String label;
  const QuestionType(this.label);
}

enum Difficulty {
  easy('سهل'),
  medium('متوسط'),
  hard('صعب');
  
  final String label;
  const Difficulty(this.label);
}

class QuestionOption {
  final String id;
  final String questionId;
  final String content;
  final int order;
  final bool isCorrect;
  
  const QuestionOption({
    required this.id,
    required this.questionId,
    required this.content,
    required this.order,
    this.isCorrect = false,
  });
}

enum BlockType {
  text,
  math,
  image,
  table,
  chemistry,
  physics,
}

class QuestionBlock {
  final String id;
  final String questionId;
  final BlockType type;
  final String content;
  final int order;
  final Map<String, dynamic>? metadata;
  
  const QuestionBlock({
    required this.id,
    required this.questionId,
    required this.type,
    required this.content,
    required this.order,
    this.metadata,
  });
}