import '../../data/repositories/exam_repository.dart';
import '../entities/exam.dart';

class GetExamsUseCase {
  final ExamRepository _repository;
  
  const GetExamsUseCase(this._repository);
  
  Future<List<Exam>> call({
    String? schoolId,
    String? classId,
    String? subjectId,
    ExamStatus? status,
  }) async {
    return await _repository.getAllExams(
      schoolId: schoolId,
      classId: classId,
      subjectId: subjectId,
      status: status,
    );
  }
}