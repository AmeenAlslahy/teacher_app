import '../../data/repositories/exam_repository.dart';

class DeleteQuestionUseCase {
  final ExamRepository _repository;

  const DeleteQuestionUseCase(this._repository);

  Future<void> call(String questionId) => _repository.deleteQuestion(questionId);
}
