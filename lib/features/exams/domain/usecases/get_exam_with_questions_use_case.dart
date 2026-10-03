import '../../data/repositories/exam_repository.dart';
import '../entities/exam.dart';

class GetExamWithQuestionsUseCase {
  final ExamRepository _repository;
  
  const GetExamWithQuestionsUseCase(this._repository);
  
  Future<ExamWithQuestions> call(String examId) async {
    final exam = await _repository.getExamById(examId);
    if (exam == null) {
      throw Exception('الاختبار غير موجود');
    }
    final questions = await _repository.getQuestionsForExam(examId);
    return ExamWithQuestions(exam: exam, questions: questions);
  }
}

class ExamWithQuestions {
  final Exam exam;
  final List<Question> questions;
  
  const ExamWithQuestions({
    required this.exam,
    required this.questions,
  });
}