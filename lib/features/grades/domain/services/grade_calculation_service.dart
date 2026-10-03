class GradeCalculationService {
static double calculatePercentage({required num score, required num total}) => (score / total) * 100;
static double calculateAverage(List<num> scores) {
if (scores.isEmpty) return 0.0;
return scores.reduce((a, b) => a + b) / scores.length;
}
static String getGrade(double percentage) {
if (percentage >= 90) return 'ممتاز';
if (percentage >= 80) return 'جيد جداً';
if (percentage >= 70) return 'جيد';
if (percentage >= 60) return 'مقبول';
return 'يحتاج تحسين';
}
}