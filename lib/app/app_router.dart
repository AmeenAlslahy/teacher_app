import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/exams/presentation/pages/exams_page.dart';
import 'main_shell.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/students/presentation/pages/students_page.dart';
import '../features/students/presentation/pages/student_form_page.dart';
import '../features/exams/presentation/pages/exam_editor_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../features/more/presentation/pages/more_page.dart';
import '../features/exams/domain/entities/exam.dart' show QuestionType;
import '../features/exams/presentation/pages/question_editor_page.dart';
import '../features/students/presentation/pages/student_details_page.dart';
import '../features/students/presentation/pages/student_import_page.dart';
import '../features/exams/presentation/pages/exam_preview_page.dart';

import '../features/splash/splash_screen.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/context/presentation/pages/context_selector_page.dart';
import '../features/more/presentation/pages/backup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class GradesPage extends StatelessWidget {
  const GradesPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class AssignmentsPage extends StatelessWidget {
  const AssignmentsPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class SchoolsPage extends StatelessWidget {
  const SchoolsPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class ClassesPage extends StatelessWidget {
  const ClassesPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class QuestionBankPage extends StatelessWidget {
  const QuestionBankPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String exams = '/exams';
  static const String examCreate = '/exams/create';
  static const String examEdit = '/exams/edit';
  static const String examPreview = '/exams/preview';
  static const String questionCreate = '/exams/questions/create';
  static const String students = '/students';
  static const String studentCreate = '/students/create';
  static const String studentDetails = '/students/details';
  static const String studentEdit = '/students/edit';
  static const String studentImport = '/students/import';
  static const String grades = '/grades';
  static const String assignments = '/assignments';
  static const String attendance = '/attendance';
  static const String reports = '/reports';
  static const String settings = '/settings';
  static const String backup = '/backup';
  static const String questionBank = '/question-bank';
  static const String schools = '/schools';
  static const String classes = '/classes';
  static const String subjects = '/subjects';
  static const String more = '/more';

  // الإضافات الجديدة
  static const String contextSelector = '/context-selector';
  static const String about = '/about';

  // Helper methods for navigation with parameters
  static String examEditWithId(String id) => '/exams/$id/edit';
  static String studentDetailsWithId(String id) => '/students/details/$id';
  static String studentEditWithId(String id) => '/students/edit/$id';
  static String examPreviewWithId(String id) => '/exams/$id/preview';
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('الصفحة غير موجودة: ${state.uri.path}'),
      ),
    ),
    routes: [
      // ============================
      // مسارات البداية (Splash, Login, Onboarding)
      // ============================
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),

      // ============================
      // ShellRoute (الصفحات الرئيسية مع شريط التبويب)
      // ============================
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            name: 'dashboard',
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: AppRoutes.exams,
            name: 'exams',
            builder: (context, state) => const ExamsPage(),
          ),
          GoRoute(
            path: AppRoutes.students,
            name: 'students',
            builder: (context, state) => const StudentsPage(),
          ),
          GoRoute(
            path: AppRoutes.grades,
            name: 'grades',
            builder: (context, state) => const GradesPage(),
          ),
          GoRoute(
            path: AppRoutes.more,
            name: 'more',
            builder: (context, state) => const MorePage(),
          ),
        ],
      ),

      // ============================
      // مسارات Full-Screen (خارج ShellRoute)
      // ============================

      // مسارات الاختبارات
      GoRoute(
        path: AppRoutes.examCreate,
        name: 'examCreate',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ExamEditorPage(),
      ),
      GoRoute(
        path:
            '/exams/:id/edit', // لا يمكن استخدام AppRoutes.examEdit هنا لأنه سيحتوي على مسار مختلف
        name: 'examEdit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ExamEditorPage(
          examId: state.pathParameters['id'],
        ),
      ),
      GoRoute(
        path: '/exams/:id/preview',
        name: 'examPreview',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ExamPreviewPage(
          examId: state.pathParameters['id']!,
        ),
      ),

      // مسار إنشاء سؤال
      GoRoute(
        path: AppRoutes.questionCreate,
        name: 'questionCreate',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final typeString = state.uri.queryParameters['type'];
          final examId = state.uri.queryParameters['examId'] ?? '';
          final parentId = state.uri.queryParameters['parentId'];
          final type = QuestionType.values.firstWhere(
            (t) => t.name == typeString,
            orElse: () => QuestionType.multipleChoice,
          );
          return QuestionEditorPage(
            type: type,
            examId: examId,
            parentId: parentId,
          );
        },
      ),

      // مسارات الطلاب
      GoRoute(
        path: AppRoutes.studentCreate,
        name: 'studentCreate',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const StudentFormPage(),
      ),
      GoRoute(
        path: '/students/details/:id',
        name: 'studentDetails',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => StudentDetailsPage(
          studentId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/students/edit/:id',
        name: 'studentEdit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => StudentFormPage(
          studentId: state.pathParameters['id'],
        ),
      ),
      GoRoute(
        path: AppRoutes.studentImport,
        name: 'studentImport',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const StudentImportPage(),
      ),

      // مسارات أخرى
      GoRoute(
        path: AppRoutes.assignments,
        name: 'assignments',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AssignmentsPage(),
      ),
      GoRoute(
        path: AppRoutes.attendance,
        name: 'attendance',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AttendancePage(),
      ),
      GoRoute(
        path: AppRoutes.reports,
        name: 'reports',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ReportsPage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.backup,
        name: 'backup',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const BackupPage(),
      ),
      GoRoute(
        path: AppRoutes.schools,
        name: 'schools',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SchoolsPage(),
      ),
      GoRoute(
        path: AppRoutes.classes,
        name: 'classes',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ClassesPage(),
      ),
      GoRoute(
        path: AppRoutes.subjects,
        name: 'subjects',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SubjectsPage(),
      ),
      GoRoute(
        path: AppRoutes.questionBank,
        name: 'questionBank',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const QuestionBankPage(),
      ),

      // مسار تعديل سؤال
      GoRoute(
        path: '/exams/questions/:id/edit',
        name: 'questionEdit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final typeString = state.uri.queryParameters['type'];
          final examId = state.uri.queryParameters['examId'] ?? '';
          final parentIdRaw = state.uri.queryParameters['parentId'];
          final parentId =
              (parentIdRaw == null || parentIdRaw.isEmpty) ? null : parentIdRaw;
          final type = QuestionType.values.firstWhere(
            (t) => t.name == typeString,
            orElse: () => QuestionType.multipleChoice,
          );
          return QuestionEditorPage(
            type: type,
            questionId: state.pathParameters['id'],
            examId: examId,
            parentId: parentId,
          );
        },
      ),

      // صفحة حول التطبيق
      GoRoute(
        path: '/about',
        name: 'about',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('حول التطبيق — قيد الإنشاء')),
        ),
      ),

      // صفحة اختيار السياق
      GoRoute(
        path: '/context-selector',
        name: 'contextSelector',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ContextSelectorPage(),
      ),
    ],
  );
}

// Extension for easy navigation
extension NavigationExtensions on BuildContext {
  void goToSplash() => goNamed('splash');
  void goToOnboarding() => goNamed('onboarding');
  void goToLogin() => goNamed('login');
  void goToDashboard() => goNamed('dashboard');
  void goToExams() => goNamed('exams');
  void goToExamCreate() => goNamed('examCreate');
  void goToExamEdit(String id) =>
      goNamed('examEdit', pathParameters: {'id': id});
  void goToExamPreview(String id) =>
      goNamed('examPreview', pathParameters: {'id': id});
  void goToStudents() => goNamed('students');
  void goToStudentCreate() => goNamed('studentCreate');
  void goToStudentDetails(String id) =>
      goNamed('studentDetails', pathParameters: {'id': id});
  void goToStudentEdit(String id) =>
      goNamed('studentEdit', pathParameters: {'id': id});
  void goToStudentImport() => goNamed('studentImport');
  void goToGrades() => goNamed('grades');
  void goToMore() => goNamed('more');

  // دوال جديدة
  void goToQuestionCreate(QuestionType type, String examId) {
    goNamed(
      'questionCreate',
      queryParameters: {
        'type': type.name,
        'examId': examId,
      },
    );
  }
}
