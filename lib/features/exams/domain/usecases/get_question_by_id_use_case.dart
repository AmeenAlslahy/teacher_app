import '../../data/repositories/exam_repository.dart';
import '../entities/exam.dart';

class GetQuestionByIdUseCase {
  final ExamRepository _repository;
  
  const GetQuestionByIdUseCase(this._repository);
  
  Future<Question?> call(String id) async {
    // نحتاج إلى إضافة هذه الدالة في ExamRepository
    // سنقوم بتعديل الـ Repository لاحقاً
    return await _repository.getQuestionById(id);
  }
}