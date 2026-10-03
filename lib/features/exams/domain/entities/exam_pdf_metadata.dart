/// بيانات رأس الاختبار الورقي.
class ExamPdfMetadata {
  // ==== القسم العلوي ====
  final String country;
  final String ministry;
  final String? educationAuthority;
  final String schoolName;
  final String? schoolLogoPath;

  // ==== العام ====
  final String academicYear;

  // ==== بيانات الاختبار ====
  final String examTypeName; // "شهري" / "نصفي" / ...
  final String subjectName;
  final String className;
  final String? sectionName;

  // ==== خيارات ====
  final bool showBasmala;

  const ExamPdfMetadata({
    // العلوي
    this.country = 'الجمهورية اليمنية',
    this.ministry = 'وزارة التربية والتعليم',
    this.educationAuthority,
    required this.schoolName,
    this.schoolLogoPath,
    // العام
    this.academicYear = '2024-2025',
    // الاختبار
    required this.examTypeName,
    required this.subjectName,
    required this.className,
    this.sectionName,
    // الخيارات
    this.showBasmala = true,
  });
}
