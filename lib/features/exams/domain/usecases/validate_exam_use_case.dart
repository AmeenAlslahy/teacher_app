import '../../data/repositories/exam_repository.dart';

class ValidateExamUseCase {
  final ExamRepository _repository;
  
  const ValidateExamUseCase(this._repository);
  
  Future<ValidationResult> call(String examId) async {
    final errors = await _repository.validateExam(examId);
    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }
}

class ValidationResult {
  final bool isValid;
  final List<String> errors;
  
  const ValidationResult({
    required this.isValid,
    this.errors = const [],
  });
}