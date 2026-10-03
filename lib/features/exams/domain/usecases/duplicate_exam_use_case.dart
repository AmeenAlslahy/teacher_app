import '../../data/repositories/exam_repository.dart';
import '../entities/exam.dart';

class DuplicateExamUseCase {
  final ExamRepository _repository;
  
  const DuplicateExamUseCase(this._repository);
  
  Future<Exam> call(String id) async {
    return await _repository.duplicateExam(id);
  }
}