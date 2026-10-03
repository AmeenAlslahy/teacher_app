import 'package:get_it/get_it.dart';
import '../../app/database/app_database.dart';
import '../../features/students/data/repositories/student_repository.dart';
import '../../features/schools/data/repositories/school_repository.dart';
import '../../features/classes/data/repositories/class_repository.dart';
import '../../features/subjects/data/repositories/subject_repository.dart';
import '../../features/exams/data/repositories/exam_repository.dart';
import '../../features/exams/data/repositories/exam_repository_impl.dart';
import '../../features/exams/domain/entities/exam.dart';
import '../../features/exams/domain/usecases/get_exams_use_case.dart';
import '../../features/exams/domain/usecases/get_exam_by_id_use_case.dart';
import '../../features/exams/domain/usecases/get_questions_for_exam_use_case.dart';
import '../../features/exams/domain/usecases/get_question_by_id_use_case.dart'; // <- إضافة جديدة
import '../../features/exams/domain/usecases/save_exam_use_case.dart';
import '../../features/exams/domain/usecases/save_question_use_case.dart';
import '../../features/exams/domain/usecases/delete_question_use_case.dart';
import '../../features/exams/domain/usecases/delete_exam_use_case.dart';
import '../../features/exams/domain/usecases/duplicate_exam_use_case.dart';
import '../../features/exams/domain/usecases/validate_exam_use_case.dart';
import '../../features/exams/domain/usecases/get_exam_with_questions_use_case.dart';
import '../../features/exams/providers/exam_provider.dart';
import '../../features/exams/providers/question_editor_provider.dart';

final getIt = GetIt.instance;

class Injection {
  static Future<void> init() async {
    // Database
    final database = AppDatabase();
    getIt.registerSingleton<AppDatabase>(database);
    
    // Repositories
    getIt.registerLazySingleton<ExamRepository>(
      () => ExamRepositoryImpl(getIt<AppDatabase>()),
    );
    getIt.registerLazySingleton<StudentRepository>(
      () => StudentRepository(getIt<AppDatabase>()),
    );
    
    // Context Repositories
    getIt.registerLazySingleton<SchoolRepository>(
      () => SchoolRepository(getIt<AppDatabase>()),
    );
    getIt.registerLazySingleton<ClassRepository>(
      () => ClassRepository(getIt<AppDatabase>()),
    );
    getIt.registerLazySingleton<SubjectRepository>(
      () => SubjectRepository(getIt<AppDatabase>()),
    );
    
    // Use Cases - Exams
    getIt.registerLazySingleton(() => GetExamsUseCase(getIt<ExamRepository>()));
    getIt.registerLazySingleton(() => GetExamByIdUseCase(getIt<ExamRepository>()));
    getIt.registerLazySingleton(() => GetQuestionsForExamUseCase(getIt<ExamRepository>()));
    getIt.registerLazySingleton(() => GetQuestionByIdUseCase(getIt<ExamRepository>())); // <- إضافة جديدة
    getIt.registerLazySingleton(() => SaveExamUseCase(getIt<ExamRepository>()));
    getIt.registerLazySingleton(() => SaveQuestionUseCase(getIt<ExamRepository>()));
    getIt.registerLazySingleton(() => DeleteQuestionUseCase(getIt<ExamRepository>()));
    getIt.registerLazySingleton(() => DeleteExamUseCase(getIt<ExamRepository>()));
    getIt.registerLazySingleton(() => DuplicateExamUseCase(getIt<ExamRepository>()));
    getIt.registerLazySingleton(() => ValidateExamUseCase(getIt<ExamRepository>()));
    getIt.registerLazySingleton(() => GetExamWithQuestionsUseCase(getIt<ExamRepository>()));
    
    // Providers
    getIt.registerLazySingleton<ExamProvider>(
      () => ExamProvider(
        getExamsUseCase: getIt<GetExamsUseCase>(),
        getExamByIdUseCase: getIt<GetExamByIdUseCase>(),
        getQuestionsForExamUseCase: getIt<GetQuestionsForExamUseCase>(),
        saveExamUseCase: getIt<SaveExamUseCase>(),
        validateExamUseCase: getIt<ValidateExamUseCase>(),
        deleteExamUseCase: getIt<DeleteExamUseCase>(),
        duplicateExamUseCase: getIt<DuplicateExamUseCase>(),
        deleteQuestionUseCase: getIt<DeleteQuestionUseCase>(),
        saveQuestionUseCase: getIt<SaveQuestionUseCase>(),
        getQuestionByIdUseCase: getIt<GetQuestionByIdUseCase>(), // <- إضافة جديدة
      ),
    );
    
    // QuestionEditorProvider - مصنع مع معاملات
    getIt.registerFactoryParam<QuestionEditorProvider, QuestionEditorParams, dynamic>(
      (params, _) => QuestionEditorProvider(
        type: params.type,
        questionId: params.questionId,
        examId: params.examId,
        parentId: params.parentId,
        saveQuestionUseCase: getIt<SaveQuestionUseCase>(),
        getQuestionByIdUseCase: getIt<GetQuestionByIdUseCase>(),
      ),
    );
  }
}

// معاملات محرر السؤال
class QuestionEditorParams {
  final QuestionType type;
  final String? questionId;
  final String examId;
  final String? parentId;
  
  const QuestionEditorParams({
    required this.type,
    this.questionId,
    required this.examId,
    this.parentId,
  });
}