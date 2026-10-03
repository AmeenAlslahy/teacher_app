import '../../data/repositories/exam_repository.dart';
import '../entities/exam.dart';

class GetExamByIdUseCase {
  final ExamRepository _repository;
  
  const GetExamByIdUseCase(this._repository);
  
  Future<Exam?> call(String id) async {
    return await _repository.getExamById(id);
  }
}