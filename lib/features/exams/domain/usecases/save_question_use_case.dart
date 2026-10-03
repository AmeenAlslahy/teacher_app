import '../../data/repositories/exam_repository.dart';
import '../entities/exam.dart';

class SaveQuestionUseCase {
  final ExamRepository _repository;
  
  const SaveQuestionUseCase(this._repository);
  
  Future<Question> call(Question question) async {
    return await _repository.addQuestion(question);
  }
}