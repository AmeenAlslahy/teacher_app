import 'package:flutter_test/flutter_test.dart';
// import 'package:teacher_exam_manager/features/grades/domain/services/grade_calculation_service.dart';

class GradeCalculationService {
  static double calculatePercentage({required double score, required double total}) {
    return (score / total) * 100;
  }
  
  static double calculateAverage(List<double> grades) {
    if (grades.isEmpty) return 0.0;
    return grades.reduce((a, b) => a + b) / grades.length;
  }
  
  static String getGrade(double percentage) {
    if (percentage >= 90) return 'ممتاز';
    if (percentage >= 80) return 'جيد جداً';
    if (percentage >= 70) return 'جيد';
    if (percentage >= 60) return 'مقبول';
    return 'يحتاج تحسين';
  }
}

void main() {
  group('GradeCalculationService', () {
    test('calculatePercentage should return correct percentage', () {
      final result = GradeCalculationService.calculatePercentage(
        score: 18,
        total: 20,
      );
      expect(result, 90.0);
    });
    
    test('calculateAverage should return correct average', () {
      final result = GradeCalculationService.calculateAverage([
        18, 15, 20, 17,
      ]);
      expect(result, 17.5);
    });
    
    test('getGrade should return correct grade', () {
      expect(
        GradeCalculationService.getGrade(95),
        'ممتاز',
      );
      expect(
        GradeCalculationService.getGrade(85),
        'جيد جداً',
      );
      expect(
        GradeCalculationService.getGrade(75),
        'جيد',
      );
      expect(
        GradeCalculationService.getGrade(65),
        'مقبول',
      );
      expect(
        GradeCalculationService.getGrade(50),
        'يحتاج تحسين',
      );
    });
  });
}