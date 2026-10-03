import '../../data/repositories/exam_repository.dart';

class DeleteExamUseCase {
  final ExamRepository _repository;
  
  const DeleteExamUseCase(this._repository);
  
  Future<void> call(String id) async {
    await _repository.deleteExam(id);
  }
}