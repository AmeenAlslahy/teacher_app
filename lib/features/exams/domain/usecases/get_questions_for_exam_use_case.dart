import '../../data/repositories/exam_repository.dart';
import '../entities/exam.dart';

class GetQuestionsForExamUseCase {
  final ExamRepository _repository;
  
  const GetQuestionsForExamUseCase(this._repository);
  
  Future<List<Question>> call(String examId) async {
    return await _repository.getQuestionsForExam(examId);
  }
}