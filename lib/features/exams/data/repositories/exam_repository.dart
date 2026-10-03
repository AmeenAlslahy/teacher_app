import '../../domain/entities/exam.dart';

abstract class ExamRepository {
  // الاختبارات
  Future<Exam> createExam(Exam exam);
  Future<List<Exam>> getAllExams({
    String? schoolId,
    String? classId,
    String? subjectId,
    ExamStatus? status,
  });
  Future<Exam?> getExamById(String id);
  Future<void> updateExam(Exam exam);
  Future<void> deleteExam(String id);
  Future<Exam> duplicateExam(String id);
  
  // الأسئلة
    
  Future<Question> addQuestion(Question question);
  Future<List<Question>> getQuestionsForExam(String examId);
  Future<Question?> getQuestionById(String id); // <- إضافة جديدة
  Future<void> deleteQuestion(String questionId);
  Future<void> reorderQuestions(List<String> questionIds);
  
  // التحقق
  Future<double> calculateTotalMarks(String examId);
  Future<List<String>> validateExam(String examId);
}