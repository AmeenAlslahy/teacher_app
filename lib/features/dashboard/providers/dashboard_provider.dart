import 'package:drift/drift.dart';
import '../../../app/database/app_database.dart';
import '../../../core/state/base_provider.dart';
import '../domain/entities/dashboard_data.dart';
import '../../context/providers/context_provider.dart';

class DashboardProvider extends BaseProvider {
  final AppDatabase _database;
  ContextProvider? _contextProvider;
  
  DashboardData? _dashboardData;
  DashboardData? get dashboardData => _dashboardData;
  
  DashboardProvider(this._database);

  void updateContext(ContextProvider contextProvider) {
    bool hasChanged = _contextProvider?.selectedSchool?.id != contextProvider.selectedSchool?.id ||
                      _contextProvider?.selectedClass?.id != contextProvider.selectedClass?.id ||
                      _contextProvider?.selectedSection?.id != contextProvider.selectedSection?.id ||
                      _contextProvider?.selectedSubject?.id != contextProvider.selectedSubject?.id;
    
    _contextProvider = contextProvider;
    
    if (hasChanged || _dashboardData == null) {
      loadDashboard();
    }
  }
  
  Future<void> loadDashboard() async {
    if (_contextProvider == null) return;
    
    setLoading(true);
    clearError();
    
    try {
      final data = await _fetchDashboardData();
      _dashboardData = data;
    } catch (e) {
      setError('فشل في تحميل لوحة التحكم: $e');
    } finally {
      setLoading(false);
    }
  }
  
  Future<DashboardData> _fetchDashboardData() async {
    final school = _contextProvider?.selectedSchool;
    final clazz = _contextProvider?.selectedClass;
    final section = _contextProvider?.selectedSection;
    final subject = _contextProvider?.selectedSubject;
    
    int totalStudents = 0;
    int totalExams = 0;
    double averageGrade = 0.0;
    List<UpcomingExam> upcomingExams = [];
    List<RecentExam> recentExams = [];
    List<DashboardAlert> alerts = [];

    // Query Students
    if (section != null) {
      final studentsList = await (_database.select(_database.students)
        ..where((t) => t.sectionId.equals(section.id))).get();
      totalStudents = studentsList.length;
    } else if (clazz != null) {
      final studentsList = await (_database.select(_database.students)
        ..where((t) => t.classId.equals(clazz.id))).get();
      totalStudents = studentsList.length;
    }

    // Query Exams for Subject
    if (subject != null) {
      final examsList = await (_database.select(_database.exams)
        ..where((t) => t.subjectId.equals(subject.id) & t.isDeleted.equals(false))).get();
      totalExams = examsList.length;

      final now = DateTime.now();

      // ✅ جلب كل الدرجات في استعلام واحد (منع N+1)
      final allGrades = await (_database.select(_database.examGrades)
            ..where((t) => t.examId.isIn(examsList.map((e) => e.id).toList())))
          .get();
      final gradesByExam = <String, List<double>>{};
      for (var g in allGrades) {
        gradesByExam.putIfAbsent(g.examId, () => []).add(g.score);
      }

      // ✅ Upcoming Exams — مبنية على التاريخ فقط
      final upcoming = examsList
          .where((e) => e.examDate.isAfter(now))
          .toList()
        ..sort((a, b) => a.examDate.compareTo(b.examDate));

      upcomingExams = upcoming.take(3).map((e) => UpcomingExam(
        id: e.id,
        title: e.title,
        subject: subject.name,
        type: e.type,
        date: e.examDate,
        duration: e.duration,
        totalMarks: e.totalMarks,
      )).toList();

      // ✅ Recent Exams — مبنية على التاريخ + وجود درجات
      final recent = examsList
          .where((e) => e.examDate.isBefore(now))
          .toList()
        ..sort((a, b) => b.examDate.compareTo(a.examDate));

      for (var e in recent.take(3)) {
        final scores = gradesByExam[e.id] ?? [];
        double avg = 0.0;
        if (scores.isNotEmpty) {
          avg = scores.reduce((a, b) => a + b) / scores.length;
        }
        recentExams.add(RecentExam(
          id: e.id,
          title: e.title,
          subject: subject.name,
          date: e.examDate,
          averageScore: avg,
          totalStudents: scores.length,
        ));
      }

      // ✅ Alerts — اختبارات ماضية بدون درجات
      final needsGrading = examsList
          .where((e) =>
              e.examDate.isBefore(now) &&
              (gradesByExam[e.id]?.isEmpty ?? true))
          .toList();

      for (var e in needsGrading.take(2)) {
        alerts.add(DashboardAlert(
          id: 'alert_${e.id}',
          title: 'درجات غير مدخلة',
          message: 'اختبار "${e.title}" بانتظار إدخال الدرجات.',
          type: AlertType.warning,
          createdAt: DateTime.now(),
          examId: e.id,
        ));
      }
      
      // Compute overall average grade
      if (examsList.isNotEmpty) {
        final examIds = examsList.map((e) => e.id).toList();
        final grades = await (_database.select(_database.examGrades)..where((t) => t.examId.isIn(examIds))).get();
        if (grades.isNotEmpty) {
          final totalScore = grades.fold(0.0, (sum, g) => sum + g.score);
          final maxScore = examsList.where((e) => grades.any((g) => g.examId == e.id))
              .map((e) => e.totalMarks * grades.where((g) => g.examId == e.id).length)
              .fold(0.0, (sum, val) => sum + val);
          
          if (maxScore > 0) {
             averageGrade = (totalScore / maxScore) * 100;
          }
        }
      }
    }
    
    String currentClassName = '';
    if (clazz != null) {
      currentClassName = clazz.name;
      if (section != null) {
        currentClassName += ' - ${section.name}';
      }
    }
    
    return DashboardData(
      teacherName: 'المعلم',
      currentSchool: school?.name ?? 'لا توجد مدرسة محددة',
      currentClass: currentClassName.isEmpty ? 'لا يوجد صف محدد' : currentClassName,
      currentSubject: subject?.name ?? 'الرجاء اختيار المادة',
      totalStudents: totalStudents,
      totalExams: totalExams,
      totalAssignments: 0,
      averageGrade: double.parse(averageGrade.toStringAsFixed(1)),
      upcomingExams: upcomingExams,
      recentExams: recentExams,
      alerts: alerts,
    );
  }
  
  Future<void> refresh() async {
    await loadDashboard();
  }
}