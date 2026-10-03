import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../database/app_database.dart';
import '../../features/dashboard/providers/dashboard_provider.dart';
import '../../features/students/providers/student_provider.dart';
import '../../features/exams/providers/exam_provider.dart';
import '../../features/students/data/repositories/student_repository.dart';
import '../../core/di/injection.dart'; // Add getIt import
import '../../features/context/providers/context_provider.dart';
import '../../features/schools/data/repositories/school_repository.dart';
import '../../features/classes/data/repositories/class_repository.dart';
import '../../features/subjects/data/repositories/subject_repository.dart';
class AppProviders {
  static List<SingleChildWidget> getProviders(AppDatabase database) {
    return [
      // Database Provider
      Provider<AppDatabase>.value(value: database),
      
      // Core Providers
      ChangeNotifierProvider(
        create: (_) => ContextProvider(
          getIt<SchoolRepository>(),
          getIt<ClassRepository>(),
          getIt<SubjectRepository>(),
        ),
      ),
      
      // Feature Providers
      ChangeNotifierProxyProvider<ContextProvider, DashboardProvider>(
        create: (_) => DashboardProvider(database),
        update: (_, contextProvider, previous) =>
            previous!..updateContext(contextProvider),
      ),
      ChangeNotifierProvider(create: (_) => StudentProvider(getIt<StudentRepository>())),
      // ChangeNotifierProvider(create: (_) => AuthProvider(database)),
      // ChangeNotifierProvider(create: (_) => SchoolProvider(database)),
      // ChangeNotifierProvider(create: (_) => ClassProvider(database)),
      ChangeNotifierProvider(create: (_) => getIt<ExamProvider>()),
      // ChangeNotifierProvider(create: (_) => QuestionProvider(database)),
      // ChangeNotifierProvider(create: (_) => GradeProvider(database)),
      // ChangeNotifierProvider(create: (_) => AssignmentProvider(database)),
      // ChangeNotifierProvider(create: (_) => AttendanceProvider(database)),
      // ChangeNotifierProvider(create: (_) => ReportProvider(database)),
    ];
  }
}