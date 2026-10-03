import '../../data/repositories/exam_repository.dart';
import '../entities/exam.dart';

class SaveExamUseCase {
  final ExamRepository _repository;
  
  const SaveExamUseCase(this._repository);
  
  Future<Exam> call(Exam exam) async {
    final existing = await _repository.getExamById(exam.id);
    if (existing != null) {
      await _repository.updateExam(exam);
      return exam;
    } else {
      return await _repository.createExam(exam);
    }
  }
}