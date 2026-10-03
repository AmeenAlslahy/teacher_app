
class DashboardData {
  final String teacherName;
  final String currentSchool;
  final String currentClass;
  final String currentSubject;
  final int totalStudents;
  final int totalExams;
  final int totalAssignments;
  final double averageGrade;
  final List<UpcomingExam> upcomingExams;
  final List<RecentExam> recentExams;
  final List<DashboardAlert> alerts;
  
  DashboardData({
    required this.teacherName,
    required this.currentSchool,
    required this.currentClass,
    required this.currentSubject,
    required this.totalStudents,
    required this.totalExams,
    required this.totalAssignments,
    required this.averageGrade,
    required this.upcomingExams,
    required this.recentExams,
    required this.alerts,
  });
}

class UpcomingExam {
  final String id;
  final String title;
  final String subject;
  final String type;
  final DateTime date;
  final int duration;
  final double totalMarks;
  
  UpcomingExam({
    required this.id,
    required this.title,
    required this.subject,
    required this.type,
    required this.date,
    required this.duration,
    required this.totalMarks,
  });
}

class RecentExam {
  final String id;
  final String title;
  final String subject;
  final DateTime date;
  final double averageScore;
  final int totalStudents;
  
  RecentExam({
    required this.id,
    required this.title,
    required this.subject,
    required this.date,
    required this.averageScore,
    required this.totalStudents,
  });
}

class DashboardAlert {
  final String id;
  final String title;
  final String message;
  final AlertType type;
  final DateTime createdAt;
  final String? examId;   // ✅ جديد — للتنقل

  DashboardAlert({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.examId,
  });
}

enum AlertType {
  warning,
  info,
  success,
  error,
}
