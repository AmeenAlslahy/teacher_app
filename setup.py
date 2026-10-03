import os

files = {
    "lib/main.dart": """import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import 'app/app.dart';
import 'app/database/app_database.dart';
import 'app/providers/app_providers.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  final database = AppDatabase();
  
  runApp(
    MultiProvider(
      providers: AppProviders.getProviders(database),
      child: const TeacherExamApp(),
    ),
  );
}""",
    
    "lib/app/app.dart": """import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'app_router.dart';
import '../features/settings/providers/settings_provider.dart';
import '../core/theme/theme_provider.dart';
import '../core/theme/app_theme.dart';
import '../core/localization/app_localizations.dart';

class TeacherExamApp extends StatelessWidget {
  const TeacherExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    
    return MaterialApp.router(
      title: 'مدير الاختبارات',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      locale: settingsProvider.locale,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: AppRouter.router,
    );
  }
}""",
    
    "lib/app/database/app_database.dart": """import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'tables/teacher_tables.dart';
import 'tables/subject_tables.dart';
import 'tables/tables.dart';
import 'daos/daos.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Teachers,
    Schools,
    Classes,
    Sections,
    Subjects,
    Students,
    Exams,
    ExamModels,
    Questions,
    QuestionBlocks,
    QuestionOptions,
    QuestionBankItems,
    ExamQuestions,
    Grades,
    GradeComponents,
    Assignments,
    AssignmentGrades,
    Attendance,
    AttendanceRecords,
    ExamTemplates,
    Reports,
    AppSettings,
    BackupMetadata,
  ],
  daos: [
    TeacherDao,
    SchoolDao,
    ClassDao,
    SubjectDao,
    StudentDao,
    ExamDao,
    QuestionDao,
    GradeDao,
    AssignmentDao,
    AttendanceDao,
    TemplateDao,
    ReportDao,
    SettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // Add future migrations here
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'teacher_exam_manager.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}""",
    
    "lib/app/database/tables/teacher_tables.dart": """import 'package:drift/drift.dart';

class Teachers extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text()();
  TextColumn get specialty => text().nullable()();
  TextColumn get profileImage => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}

class Schools extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text()();
  TextColumn get logo => text().nullable()();
  TextColumn get educationAuthority => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get academicYear => text().withDefault(const Constant('2024-2025'))();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}

class Classes extends Table {
  TextColumn get id => text().unique()();
  TextColumn get schoolId => text().references(Schools, #id)();
  TextColumn get name => text()();
  TextColumn get gradeLevel => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}

class Sections extends Table {
  TextColumn get id => text().unique()();
  TextColumn get classId => text().references(Classes, #id)();
  TextColumn get name => text()();
  TextColumn get academicYear => text().withDefault(const Constant('2024-2025'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}""",
    
    "lib/app/database/tables/subject_tables.dart": """import 'package:drift/drift.dart';
import 'teacher_tables.dart';

class Subjects extends Table {
  TextColumn get id => text().unique()();
  TextColumn get schoolId => text().references(Schools, #id)();
  TextColumn get name => text()();
  TextColumn get color => text().nullable()();
  TextColumn get icon => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}

class Students extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text()();
  TextColumn get studentNumber => text()();
  TextColumn get classId => text().references(Classes, #id)();
  TextColumn get sectionId => text().references(Sections, #id).nullable()();
  TextColumn get parentPhone => text().nullable()();
  TextColumn get profileImage => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get gender => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  
  @override
  Set<Column> get primaryKey => {id};
}""",

    "lib/app/providers/app_providers.dart": """import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../database/app_database.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/dashboard/providers/dashboard_provider.dart';
import '../../features/schools/providers/school_provider.dart';
import '../../features/classes/providers/class_provider.dart';
import '../../features/students/providers/student_provider.dart';
import '../../features/exams/providers/exam_provider.dart';
import '../../features/questions/providers/question_provider.dart';
import '../../features/grades/providers/grade_provider.dart';
import '../../features/assignments/providers/assignment_provider.dart';
import '../../features/attendance/providers/attendance_provider.dart';
import '../../features/reports/providers/report_provider.dart';
import '../../features/settings/providers/settings_provider.dart';
import '../../core/theme/theme_provider.dart';

class AppProviders {
  static List<SingleChildWidget> getProviders(AppDatabase database) {
    return [
      // Core Providers
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => SettingsProvider(database)),
      
      // Feature Providers
      ChangeNotifierProvider(create: (_) => AuthProvider(database)),
      ChangeNotifierProvider(create: (_) => DashboardProvider(database)),
      ChangeNotifierProvider(create: (_) => SchoolProvider(database)),
      ChangeNotifierProvider(create: (_) => ClassProvider(database)),
      ChangeNotifierProvider(create: (_) => StudentProvider(database)),
      ChangeNotifierProvider(create: (_) => ExamProvider(database)),
      ChangeNotifierProvider(create: (_) => QuestionProvider(database)),
      ChangeNotifierProvider(create: (_) => GradeProvider(database)),
      ChangeNotifierProvider(create: (_) => AssignmentProvider(database)),
      ChangeNotifierProvider(create: (_) => AttendanceProvider(database)),
      ChangeNotifierProvider(create: (_) => ReportProvider(database)),
    ];
  }
}""",

    "lib/features/students/providers/student_provider.dart": """import 'package:flutter/foundation.dart';
import '../../../app/database/app_database.dart';
import '../domain/entities/student.dart';
import '../data/repositories/student_repository.dart';
import '../domain/usecases/student_usecases.dart';

class StudentProvider extends ChangeNotifier {
  final AppDatabase _database;
  late final StudentRepository _repository;
  late final StudentUseCases _useCases;
  
  List<Student> _students = [];
  List<Student> _filteredStudents = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String? _selectedClassId;
  String? _selectedSectionId;

  // Mock list of classes and sections
  List<dynamic> get classes => [];
  List<dynamic> get sections => [];
  
  StudentProvider(this._database) {
    _repository = StudentRepository(_database);
    _useCases = StudentUseCases(_repository);
  }
  
  List<Student> get students => _filteredStudents;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  Future<void> loadStudents() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _students = await _useCases.getAllStudents();
      _applyFilters();
    } catch (e) {
      _error = 'فشل في تحميل الطلاب: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }
  
  void setClassFilter(String? classId) {
    _selectedClassId = classId;
    _applyFilters();
  }
  
  void setSectionFilter(String? sectionId) {
    _selectedSectionId = sectionId;
    _applyFilters();
  }
  
  void _applyFilters() {
    _filteredStudents = _students.where((student) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final matchesSearch = student.name.contains(_searchQuery) ||
            student.studentNumber.contains(_searchQuery);
        if (!matchesSearch) return false;
      }
      
      // Class filter
      if (_selectedClassId != null && student.classId != _selectedClassId) {
        return false;
      }
      
      // Section filter
      if (_selectedSectionId != null && student.sectionId != _selectedSectionId) {
        return false;
      }
      
      return true;
    }).toList();
    
    notifyListeners();
  }
  
  Future<void> addStudent(Student student) async {
    try {
      await _useCases.createStudent(student);
      await loadStudents();
    } catch (e) {
      _error = 'فشل في إضافة الطالب: $e';
      notifyListeners();
    }
  }
  
  Future<void> updateStudent(Student student) async {
    try {
      await _useCases.updateStudent(student);
      await loadStudents();
    } catch (e) {
      _error = 'فشل في تحديث بيانات الطالب: $e';
      notifyListeners();
    }
  }
  
  Future<void> deleteStudent(String id) async {
    try {
      await _useCases.deleteStudent(id);
      await loadStudents();
    } catch (e) {
      _error = 'فشل في حذف الطالب: $e';
      notifyListeners();
    }
  }
  
  Future<void> importStudentsFromCsv(String filePath) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final importedCount = await _useCases.importStudentsFromCsv(filePath);
      await loadStudents();
      debugPrint('Imported $importedCount students');
    } catch (e) {
      _error = 'فشل في استيراد الطلاب: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}""",

    "lib/features/dashboard/presentation/pages/dashboard_page.dart": """import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/quick_actions.dart';
import '../widgets/statistics_cards.dart';
import '../widgets/upcoming_exams.dart';
import '../widgets/recent_exams.dart';
import '../widgets/alerts_section.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashboardProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return ResponsiveLayout(
            mobile: _buildMobileDashboard(context, provider),
            tablet: _buildTabletDashboard(context, provider),
          );
        },
      ),
    );
  }
  
  Widget _buildMobileDashboard(BuildContext context, DashboardProvider provider) {
    return RefreshIndicator(
      onRefresh: provider.refresh,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(context, provider),
          const SizedBox(height: 24),
          const QuickActions(),
          const SizedBox(height: 24),
          StatisticsCards(statistics: provider.statistics),
          const SizedBox(height: 24),
          UpcomingExams(exams: provider.upcomingExams),
          const SizedBox(height: 24),
          RecentExams(exams: provider.recentExams),
          const SizedBox(height: 24),
          AlertsSection(alerts: provider.alerts),
        ],
      ),
    );
  }
  
  Widget _buildTabletDashboard(BuildContext context, DashboardProvider provider) {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: 0,
          onDestinationSelected: (index) {
            // Handle navigation
          },
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('الرئيسية'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.assignment),
              label: Text('الاختبارات'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.people),
              label: Text('الطلاب'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.grade),
              label: Text('الدرجات'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.more_horiz),
              label: Text('المزيد'),
            ),
          ],
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: _buildMobileDashboard(context, provider),
        ),
      ],
    );
  }
  
  Widget _buildHeader(BuildContext context, DashboardProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مرحباً أستاذ ${provider.teacherName}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.school),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    provider.currentContext,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: () => context.push('/context-selector'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}""",

    "lib/features/exams/presentation/pages/exam_editor_page.dart": """import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/exam_provider.dart';
import '../widgets/question_card.dart';
import '../widgets/question_type_dialog.dart';
import '../widgets/exam_info_form.dart';

class ExamEditorPage extends StatefulWidget {
  final String? examId;
  
  const ExamEditorPage({super.key, this.examId});

  @override
  State<ExamEditorPage> createState() => _ExamEditorPageState();
}

class _ExamEditorPageState extends State<ExamEditorPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = context.read<ExamProvider>();
      if (widget.examId != null) {
        provider.loadExam(widget.examId!);
      } else {
        provider.createNewExam();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ExamProvider>(
          builder: (context, provider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(provider.currentExam?.title ?? 'اختبار جديد'),
                const SizedBox(height: 4),
                Text(
                  provider.saveStatus,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () {
              final examId = context.read<ExamProvider>().currentExam?.id;
              if (examId != null) {
                context.push('/exams/$examId/preview');
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              context.read<ExamProvider>().saveExam();
            },
          ),
        ],
      ),
      body: Consumer<ExamProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (provider.showExamInfo)
                ExamInfoForm(
                  exam: provider.currentExam!,
                  onSave: provider.updateExamInfo,
                ),
              const SizedBox(height: 24),
              ...provider.questions.map((question) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: QuestionCard(
                  question: question,
                  index: provider.questions.indexOf(question),
                  onEdit: () => _showQuestionEditor(question.id),
                  onDuplicate: () => provider.duplicateQuestion(question.id),
                  onDelete: () => provider.deleteQuestion(question.id),
                  onMoveUp: () => provider.moveQuestionUp(question.id),
                  onMoveDown: () => provider.moveQuestionDown(question.id),
                  onSaveToBank: () => _showSaveToBankDialog(question.id),
                ),
              )),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddQuestionDialog(),
        icon: const Icon(Icons.add),
        label: const Text('إضافة سؤال'),
      ),
    );
  }
  
  void _showAddQuestionDialog() {
    showDialog(
      context: context,
      builder: (context) => const QuestionTypeDialog(),
    );
  }
  
  void _showQuestionEditor(String questionId) {
    context.push('/questions/$questionId/edit');
  }
  
  void _showSaveToBankDialog(String questionId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حفظ في بنك الأسئلة'),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'المادة'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'الوحدة'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'الدرس'),
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'الصعوبة'),
                items: const [
                  DropdownMenuItem(value: 'easy', child: Text('سهل')),
                  DropdownMenuItem(value: 'medium', child: Text('متوسط')),
                  DropdownMenuItem(value: 'hard', child: Text('صعب')),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}""",

    "lib/core/services/pdf_service.dart": """import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/exams/domain/entities/exam.dart';
import '../../features/exams/domain/entities/question.dart';

class PdfService {
  Future<File> generateExamPdf({
    required Exam exam,
    required List<Question> questions,
    required String schoolName,
    String? schoolLogo,
    required String teacherName,
    required String className,
    required String subjectName,
    dynamic examModel,
  }) async {
    final pdf = pw.Document();
    
    // Load font
    final font = await PdfGoogleFonts.cairoRegular();
    final fontBold = await PdfGoogleFonts.cairoBold();
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        textDirection: pw.TextDirection.rtl,
        build: (context) => [
          _buildExamHeader(
            exam: exam,
            schoolName: schoolName,
            schoolLogo: schoolLogo,
            teacherName: teacherName,
            className: className,
            subjectName: subjectName,
            font: font,
            fontBold: fontBold,
          ),
          pw.SizedBox(height: 24),
          ..._buildQuestions(questions, examModel, font, fontBold),
        ],
      ),
    );
    
    // Save to file
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/exam_${exam.id}.pdf");
    await file.writeAsBytes(await pdf.save());
    
    return file;
  }
  
  pw.Widget _buildExamHeader({
    required Exam exam,
    required String schoolName,
    String? schoolLogo,
    required String teacherName,
    required String className,
    required String subjectName,
    required pw.Font font,
    required pw.Font fontBold,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Center(
          child: pw.Text(
            'بسم الله الرحمن الرحيم',
            style: pw.TextStyle(font: fontBold, fontSize: 16),
          ),
        ),
        pw.SizedBox(height: 16),
        pw.Center(
          child: pw.Text(
            'وزارة التربية والتعليم',
            style: pw.TextStyle(font: fontBold, fontSize: 14),
          ),
        ),
        pw.SizedBox(height: 24),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (schoolLogo != null)
                    pw.Image(
                      pw.MemoryImage(File(schoolLogo).readAsBytesSync()),
                      height: 60,
                      width: 60,
                    ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    schoolName,
                    style: pw.TextStyle(font: fontBold, fontSize: 14),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'العام الدراسي: ${exam.academicYear}',
                    style: pw.TextStyle(font: font, fontSize: 12),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('المادة:', subjectName, font, fontBold),
                  pw.SizedBox(height: 4),
                  _buildInfoRow('الصف:', className, font, fontBold),
                  pw.SizedBox(height: 4),
                  _buildInfoRow('نوع الاختبار:', exam.type, font, fontBold),
                  pw.SizedBox(height: 4),
                  _buildInfoRow('التاريخ:', exam.date.toString(), font, fontBold),
                  pw.SizedBox(height: 4),
                  _buildInfoRow('الزمن:', '${exam.duration} دقيقة', font, fontBold),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 24),
        pw.Divider(),
        pw.SizedBox(height: 16),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'اسم الطالب: ......................................',
              style: pw.TextStyle(font: font, fontSize: 12),
            ),
            pw.Text(
              'الدرجة: ........ / ${exam.totalMarks}',
              style: pw.TextStyle(font: fontBold, fontSize: 12),
            ),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          'المدرس: $teacherName',
          style: pw.TextStyle(font: font, fontSize: 12),
        ),
        pw.SizedBox(height: 24),
      ],
    );
  }
  
  pw.Widget _buildInfoRow(String label, String value, pw.Font font, pw.Font fontBold) {
    return pw.Row(
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(font: fontBold, fontSize: 12),
        ),
        pw.SizedBox(width: 8),
        pw.Text(
          value,
          style: pw.TextStyle(font: font, fontSize: 12),
        ),
      ],
    );
  }
  
  List<pw.Widget> _buildQuestions(
    List<Question> questions,
    dynamic examModel,
    pw.Font font,
    pw.Font fontBold,
  ) {
    final widgets = <pw.Widget>[];
    
    for (var i = 0; i < questions.length; i++) {
      final question = questions[i];
      widgets.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  width: 24,
                  height: 24,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(),
                    shape: pw.BoxShape.circle,
                  ),
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    '${i + 1}',
                    style: pw.TextStyle(font: fontBold, fontSize: 12),
                  ),
                ),
                pw.SizedBox(width: 8),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildQuestionContent(question, font, fontBold),
                      pw.SizedBox(height: 8),
                      if (question.type == 'multiple_choice')
                        _buildMultipleChoiceOptions(question, font),
                      if (question.type == 'true_false')
                        pw.Row(
                          children: [
                            pw.Text('(   ) صح', style: pw.TextStyle(font: font)),
                            pw.SizedBox(width: 24),
                            pw.Text('(   ) خطأ', style: pw.TextStyle(font: font)),
                          ],
                        ),
                      if (question.type == 'essay')
                        pw.Container(
                          height: 80,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                      pw.SizedBox(height: 8),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          '(درجة السؤال: ${question.marks})',
                          style: pw.TextStyle(font: font, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 16),
          ],
        ),
      );
    }
    
    return widgets;
  }
  
  pw.Widget _buildQuestionContent(Question question, pw.Font font, pw.Font fontBold) {
    // Build question content from blocks
    if (question.blocks.isEmpty) {
      return pw.Text(
        question.content,
        style: pw.TextStyle(font: font, fontSize: 12),
        textDirection: pw.TextDirection.rtl,
      );
    }
    
    final spans = <pw.TextSpan>[];
    for (final block in question.blocks) {
      if (block.type == 'text') {
        spans.add(pw.TextSpan(
          text: block.content,
          style: pw.TextStyle(font: font, fontSize: 12),
        ));
      } else if (block.type == 'math') {
        spans.add(pw.TextSpan(
          text: block.content,
          style: pw.TextStyle(font: font, fontSize: 12),
        ));
      }
    }
    
    return pw.RichText(
      text: pw.TextSpan(children: spans),
      textDirection: pw.TextDirection.rtl,
    );
  }
  
  pw.Widget _buildMultipleChoiceOptions(Question question, pw.Font font) {
    final options = <pw.Widget>[];
    final letters = ['أ', 'ب', 'ج', 'د'];
    
    for (var i = 0; i < question.options.length && i < letters.length; i++) {
      options.add(
        pw.Row(
          children: [
            pw.Text(
              '(${letters[i]})',
              style: pw.TextStyle(font: font, fontSize: 12),
            ),
            pw.SizedBox(width: 8),
            pw.Text(
              question.options[i],
              style: pw.TextStyle(font: font, fontSize: 12),
            ),
          ],
        ),
      );
      options.add(pw.SizedBox(height: 4));
    }
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: options,
    );
  }
}""",

    "lib/core/services/backup_service.dart": """import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../app/database/app_database.dart';

class BackupService {
  final AppDatabase _database;
  
  BackupService(this._database);
  
  Future<File> createBackup() async {
    // Note: implementation needs exportData method in AppDatabase
    final data = <String, dynamic>{}; // await _database.exportData();
    final jsonData = jsonEncode(data);
    
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final fileName = 'teacher_exam_backup_$timestamp.json';
    
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(jsonData);
    
    return file;
  }
  
  Future<void> shareBackup(File backupFile) async {
    await Share.shareXFiles(
      [XFile(backupFile.path)],
      subject: 'نسخة احتياطية لتطبيق مدير الاختبارات',
    );
  }
  
  Future<bool> restoreBackup(File backupFile) async {
    try {
      final jsonData = await backupFile.readAsString();
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      
      // await _database.importData(data);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> validateBackup(File backupFile) async {
    try {
      final jsonData = await backupFile.readAsString();
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      
      final requiredKeys = [
        'teacher',
        'schools',
        'classes',
        'students',
        'subjects',
        'exams',
        'questions',
      ];
      
      for (final key in requiredKeys) {
        if (!data.containsKey(key)) {
          return false;
        }
      }
      
      return true;
    } catch (e) {
      return false;
    }
  }
}""",

    "lib/features/students/presentation/pages/students_page.dart": """import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/search_bar.dart';
import '../providers/student_provider.dart';
import '../widgets/student_card.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلاب'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_upload),
            onPressed: () {
              context.push('/students/import');
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
          ),
        ],
      ),
      body: Consumer<StudentProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (provider.students.isEmpty) {
            return EmptyState(
              icon: Icons.people,
              title: 'لا يوجد طلاب',
              message: 'أضف أول طالب للبدء',
              action: FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('إضافة طالب'),
                onPressed: () => context.push('/students/create'),
              ),
            );
          }
          
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppSearchBar(
                  onChanged: provider.setSearchQuery,
                  hintText: 'البحث عن طالب...',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.students.length,
                  itemBuilder: (context, index) {
                    final student = provider.students[index];
                    return StudentCard(
                      student: student,
                      onTap: () => context.push('/students/${student.id}'),
                      onEdit: () => context.push('/students/${student.id}/edit'),
                      onDelete: () => _confirmDelete(context, provider, student.id),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/students/create'),
        icon: const Icon(Icons.add),
        label: const Text('إضافة طالب'),
      ),
    );
  }
  
  void _showFilterBottomSheet(BuildContext context) {
    final provider = context.read<StudentProvider>();
    
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تصفية الطلاب',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'الصف',
                      border: OutlineInputBorder(),
                    ),
                    items: provider.classes.map((classItem) {
                      return DropdownMenuItem<String>(
                        value: classItem.id,
                        child: Text(classItem.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        provider.setClassFilter(value);
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'الشعبة',
                      border: OutlineInputBorder(),
                    ),
                    items: provider.sections.map((section) {
                      return DropdownMenuItem<String>(
                        value: section.id,
                        child: Text(section.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        provider.setSectionFilter(value);
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            provider.setClassFilter(null);
                            provider.setSectionFilter(null);
                            Navigator.pop(context);
                          },
                          child: const Text('مسح التصفية'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('تطبيق'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  
  void _confirmDelete(BuildContext context, StudentProvider provider, String studentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الطالب'),
        content: const Text('هل أنت متأكد من حذف هذا الطالب؟ سيتم حذف جميع بياناته.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              provider.deleteStudent(studentId);
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}""",

    "lib/features/settings/presentation/pages/settings_page.dart": """import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/settings_provider.dart';
import '../../../../core/services/backup_service.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../app/database/app_database.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            title: 'الحساب',
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('الملف الشخصي'),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => context.push('/settings/profile'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text('المدرسة'),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => context.push('/settings/school'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'المظهر',
            children: [
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, _) {
                  return ListTile(
                    leading: const Icon(Icons.dark_mode),
                    title: const Text('الوضع الليلي'),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.setThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                  );
                },
              ),
              const Divider(),
              Consumer<SettingsProvider>(
                builder: (context, settingsProvider, _) {
                  return ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('اللغة'),
                    trailing: DropdownButton<String>(
                      value: settingsProvider.locale.languageCode,
                      items: const [
                        DropdownMenuItem(value: 'ar', child: Text('العربية')),
                        DropdownMenuItem(value: 'en', child: Text('English')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          settingsProvider.setLocale(Locale(value));
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'الدرجات',
            children: [
              ListTile(
                leading: const Icon(Icons.grade),
                title: const Text('نظام التقديرات'),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => context.push('/settings/grades'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.calculate),
                title: const Text('أوزان الدرجات'),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => context.push('/settings/weights'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'البيانات',
            children: [
              ListTile(
                leading: const Icon(Icons.backup),
                title: const Text('النسخ الاحتياطي'),
                subtitle: const Text('إنشاء نسخة احتياطية من بياناتك'),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => _showBackupDialog(context),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.restore),
                title: const Text('استعادة النسخة الاحتياطية'),
                subtitle: const Text('استعادة بياناتك من نسخة احتياطية'),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => _showRestoreDialog(context),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.upload),
                title: const Text('تصدير البيانات'),
                subtitle: const Text('تصدير الطلاب والدرجات'),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => context.push('/settings/export'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'حول التطبيق',
            children: [
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('إصدار التطبيق'),
                trailing: const Text('1.0.0'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('سياسة الخصوصية'),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => context.push('/settings/privacy'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection(BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
  
  void _showBackupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إنشاء نسخة احتياطية'),
        content: const Text('سيتم إنشاء نسخة احتياطية من جميع بياناتك.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final backupService = BackupService(context.read<AppDatabase>());
              final file = await backupService.createBackup();
              await backupService.shareBackup(file);
            },
            child: const Text('إنشاء النسخة'),
          ),
        ],
      ),
    );
  }
  
  void _showRestoreDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('استعادة النسخة الاحتياطية'),
        content: const Text('سيتم استبدال جميع بياناتك الحالية بالبيانات الموجودة في النسخة الاحتياطية.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('استعادة'),
          ),
        ],
      ),
    );
  }
}""",

    "lib/core/theme/app_theme.dart": """import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4A90E2),
      brightness: Brightness.light,
    ),
    fontFamily: 'Cairo',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
  
  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4A90E2),
      brightness: Brightness.dark,
    ),
    fontFamily: 'Cairo',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
  );
}""",

    "lib/app/app_router.dart": """import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/auth/login_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/students/presentation/pages/students_page.dart';
import '../features/students/student_details_page.dart';
import '../features/students/student_form_page.dart';
import '../features/exams/exams_page.dart';
import '../features/exams/presentation/pages/exam_editor_page.dart';
import '../features/exams/exam_preview_page.dart';
import '../features/grades/grades_page.dart';
import '../features/assignments/assignments_page.dart';
import '../features/attendance/attendance_page.dart';
import '../features/reports/reports_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/students',
        builder: (context, state) => const StudentsPage(),
        routes: [
          GoRoute(
            path: 'create',
            builder: (context, state) => const StudentFormPage(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) => StudentDetailsPage(
              studentId: state.pathParameters['id']!,
            ),
          ),
          GoRoute(
            path: ':id/edit',
            builder: (context, state) => StudentFormPage(
              studentId: state.pathParameters['id'],
            ),
          ),
          GoRoute(
            path: 'import',
            builder: (context, state) => const Scaffold(body: Center(child: Text('StudentImportPage'))),
          ),
        ],
      ),
      GoRoute(
        path: '/exams',
        builder: (context, state) => const ExamsPage(),
        routes: [
          GoRoute(
            path: 'create',
            builder: (context, state) => const ExamEditorPage(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) => ExamEditorPage(
              examId: state.pathParameters['id'],
            ),
          ),
          GoRoute(
            path: ':id/preview',
            builder: (context, state) => ExamPreviewPage(
              examId: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/grades',
        builder: (context, state) => const GradesPage(),
      ),
      GoRoute(
        path: '/assignments',
        builder: (context, state) => const AssignmentsPage(),
      ),
      GoRoute(
        path: '/attendance',
        builder: (context, state) => const AttendancePage(),
      ),
      GoRoute(
        path: '/reports',
        builder: (context, state) => const ReportsPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}""",

    "test/unit/grade_calculation_test.dart": """import 'package:flutter_test/flutter_test.dart';
import 'package:teacher_exam_manager/features/grades/domain/services/grade_calculation_service.dart';

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
}"""
}

mock_files = {
    "lib/core/localization/app_localizations.dart": "import 'package:flutter/material.dart';\nclass AppLocalizations {\nstatic const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();\n}\nclass _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {\nconst _AppLocalizationsDelegate();\n@override bool isSupported(Locale locale) => true;\n@override Future<AppLocalizations> load(Locale locale) async => AppLocalizations();\n@override bool shouldReload(_AppLocalizationsDelegate old) => false;\n}",
    "lib/app/database/tables/tables.dart": "import 'package:drift/drift.dart';\nclass Exams extends Table { TextColumn get id => text()(); }\nclass ExamModels extends Table { TextColumn get id => text()(); }\nclass Questions extends Table { TextColumn get id => text()(); }\nclass QuestionBlocks extends Table { TextColumn get id => text()(); }\nclass QuestionOptions extends Table { TextColumn get id => text()(); }\nclass QuestionBankItems extends Table { TextColumn get id => text()(); }\nclass ExamQuestions extends Table { TextColumn get id => text()(); }\nclass Grades extends Table { TextColumn get id => text()(); }\nclass GradeComponents extends Table { TextColumn get id => text()(); }\nclass Assignments extends Table { TextColumn get id => text()(); }\nclass AssignmentGrades extends Table { TextColumn get id => text()(); }\nclass Attendance extends Table { TextColumn get id => text()(); }\nclass AttendanceRecords extends Table { TextColumn get id => text()(); }\nclass ExamTemplates extends Table { TextColumn get id => text()(); }\nclass Reports extends Table { TextColumn get id => text()(); }\nclass AppSettings extends Table { TextColumn get id => text()(); }\nclass BackupMetadata extends Table { TextColumn get id => text()(); }",
    "lib/app/database/daos/daos.dart": "class TeacherDao { TeacherDao(db); }\nclass SchoolDao { SchoolDao(db); }\nclass ClassDao { ClassDao(db); }\nclass SubjectDao { SubjectDao(db); }\nclass StudentDao { StudentDao(db); }\nclass ExamDao { ExamDao(db); }\nclass QuestionDao { QuestionDao(db); }\nclass GradeDao { GradeDao(db); }\nclass AssignmentDao { AssignmentDao(db); }\nclass AttendanceDao { AttendanceDao(db); }\nclass TemplateDao { TemplateDao(db); }\nclass ReportDao { ReportDao(db); }\nclass SettingsDao { SettingsDao(db); }",
    "lib/features/auth/providers/auth_provider.dart": "import 'package:flutter/material.dart';\nclass AuthProvider extends ChangeNotifier {\nAuthProvider(db);\n}",
    "lib/features/dashboard/providers/dashboard_provider.dart": "import 'package:flutter/material.dart';\nclass DashboardProvider extends ChangeNotifier {\nDashboardProvider(db);\nbool get isLoading => false;\nString get teacherName => 'Teacher';\nString get currentContext => 'School Context';\nList get statistics => [];\nList get upcomingExams => [];\nList get recentExams => [];\nList get alerts => [];\nFuture<void> refresh() async {}\n}",
    "lib/features/schools/providers/school_provider.dart": "import 'package:flutter/material.dart';\nclass SchoolProvider extends ChangeNotifier {\nSchoolProvider(db);\n}",
    "lib/features/classes/providers/class_provider.dart": "import 'package:flutter/material.dart';\nclass ClassProvider extends ChangeNotifier {\nClassProvider(db);\n}",
    "lib/features/exams/providers/exam_provider.dart": "import 'package:flutter/material.dart';\nimport '../domain/entities/exam.dart';\nimport '../domain/entities/question.dart';\nclass ExamProvider extends ChangeNotifier {\nExamProvider(db);\nbool get isLoading => false;\nbool get showExamInfo => true;\nExam? get currentExam => null;\nString get saveStatus => '';\nList<Question> get questions => [];\nvoid loadExam(String id) {}\nvoid createNewExam() {}\nvoid saveExam() {}\nvoid updateExamInfo(Exam exam) {}\nvoid duplicateQuestion(String id) {}\nvoid deleteQuestion(String id) {}\nvoid moveQuestionUp(String id) {}\nvoid moveQuestionDown(String id) {}\n}",
    "lib/features/questions/providers/question_provider.dart": "import 'package:flutter/material.dart';\nclass QuestionProvider extends ChangeNotifier {\nQuestionProvider(db);\n}",
    "lib/features/grades/providers/grade_provider.dart": "import 'package:flutter/material.dart';\nclass GradeProvider extends ChangeNotifier {\nGradeProvider(db);\n}",
    "lib/features/assignments/providers/assignment_provider.dart": "import 'package:flutter/material.dart';\nclass AssignmentProvider extends ChangeNotifier {\nAssignmentProvider(db);\n}",
    "lib/features/attendance/providers/attendance_provider.dart": "import 'package:flutter/material.dart';\nclass AttendanceProvider extends ChangeNotifier {\nAttendanceProvider(db);\n}",
    "lib/features/reports/providers/report_provider.dart": "import 'package:flutter/material.dart';\nclass ReportProvider extends ChangeNotifier {\nReportProvider(db);\n}",
    "lib/features/settings/providers/settings_provider.dart": "import 'package:flutter/material.dart';\nclass SettingsProvider extends ChangeNotifier {\nSettingsProvider(db);\nLocale get locale => const Locale('ar');\nvoid setLocale(Locale loc) {}\n}",
    "lib/core/theme/theme_provider.dart": "import 'package:flutter/material.dart';\nclass ThemeProvider extends ChangeNotifier {\nThemeMode get themeMode => ThemeMode.light;\nbool get isDarkMode => false;\nvoid setThemeMode(ThemeMode mode) {}\n}",
    "lib/features/students/domain/entities/student.dart": "class Student {\nfinal String id;\nfinal String name;\nfinal String studentNumber;\nfinal String classId;\nfinal String sectionId;\nStudent({required this.id, required this.name, required this.studentNumber, required this.classId, required this.sectionId});\n}",
    "lib/features/students/data/repositories/student_repository.dart": "class StudentRepository {\nStudentRepository(db);\n}",
    "lib/features/students/domain/usecases/student_usecases.dart": "import '../entities/student.dart';\nclass StudentUseCases {\nStudentUseCases(repo);\nFuture<List<Student>> getAllStudents() async => [];\nFuture<void> createStudent(Student student) async {}\nFuture<void> updateStudent(Student student) async {}\nFuture<void> deleteStudent(String id) async {}\nFuture<int> importStudentsFromCsv(String path) async => 0;\n}",
    "lib/core/widgets/responsive_layout.dart": "import 'package:flutter/material.dart';\nclass ResponsiveLayout extends StatelessWidget {\nfinal Widget mobile; final Widget tablet;\nconst ResponsiveLayout({super.key, required this.mobile, required this.tablet});\n@override Widget build(BuildContext context) => mobile;\n}",
    "lib/features/dashboard/presentation/widgets/quick_actions.dart": "import 'package:flutter/material.dart';\nclass QuickActions extends StatelessWidget {\nconst QuickActions({super.key});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/features/dashboard/presentation/widgets/statistics_cards.dart": "import 'package:flutter/material.dart';\nclass StatisticsCards extends StatelessWidget {\nfinal List statistics;\nconst StatisticsCards({super.key, required this.statistics});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/features/dashboard/presentation/widgets/upcoming_exams.dart": "import 'package:flutter/material.dart';\nclass UpcomingExams extends StatelessWidget {\nfinal List exams;\nconst UpcomingExams({super.key, required this.exams});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/features/dashboard/presentation/widgets/recent_exams.dart": "import 'package:flutter/material.dart';\nclass RecentExams extends StatelessWidget {\nfinal List exams;\nconst RecentExams({super.key, required this.exams});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/features/dashboard/presentation/widgets/alerts_section.dart": "import 'package:flutter/material.dart';\nclass AlertsSection extends StatelessWidget {\nfinal List alerts;\nconst AlertsSection({super.key, required this.alerts});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/core/widgets/loading_overlay.dart": "import 'package:flutter/material.dart';\nclass LoadingOverlay extends StatelessWidget {\nconst LoadingOverlay({super.key});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/features/exams/presentation/widgets/question_card.dart": "import 'package:flutter/material.dart';\nimport '../../domain/entities/question.dart';\nclass QuestionCard extends StatelessWidget {\nfinal Question question; final int index; final VoidCallback onEdit, onDuplicate, onDelete, onMoveUp, onMoveDown, onSaveToBank;\nconst QuestionCard({super.key, required this.question, required this.index, required this.onEdit, required this.onDuplicate, required this.onDelete, required this.onMoveUp, required this.onMoveDown, required this.onSaveToBank});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/features/exams/presentation/widgets/question_type_dialog.dart": "import 'package:flutter/material.dart';\nclass QuestionTypeDialog extends StatelessWidget {\nconst QuestionTypeDialog({super.key});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/features/exams/presentation/widgets/exam_info_form.dart": "import 'package:flutter/material.dart';\nimport '../../domain/entities/exam.dart';\nclass ExamInfoForm extends StatelessWidget {\nfinal Exam exam; final Function(Exam) onSave;\nconst ExamInfoForm({super.key, required this.exam, required this.onSave});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/features/exams/domain/entities/exam.dart": "class Exam {\nfinal String id; final String title; final String academicYear; final String type; final String date; final int duration; final int totalMarks;\nExam({required this.id, required this.title, required this.academicYear, required this.type, required this.date, required this.duration, required this.totalMarks});\n}",
    "lib/features/exams/domain/entities/question.dart": "class Question {\nfinal String id; final String type; final String content; final int marks; final List<dynamic> blocks; final List<String> options;\nQuestion({required this.id, required this.type, required this.content, required this.marks, required this.blocks, required this.options});\n}",
    "lib/core/widgets/empty_state.dart": "import 'package:flutter/material.dart';\nclass EmptyState extends StatelessWidget {\nfinal IconData icon; final String title; final String message; final Widget action;\nconst EmptyState({super.key, required this.icon, required this.title, required this.message, required this.action});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/core/widgets/search_bar.dart": "import 'package:flutter/material.dart';\nclass AppSearchBar extends StatelessWidget {\nfinal Function(String) onChanged; final String hintText;\nconst AppSearchBar({super.key, required this.onChanged, required this.hintText});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/features/students/presentation/widgets/student_card.dart": "import 'package:flutter/material.dart';\nimport '../../domain/entities/student.dart';\nclass StudentCard extends StatelessWidget {\nfinal Student student; final VoidCallback onTap, onEdit, onDelete;\nconst StudentCard({super.key, required this.student, required this.onTap, required this.onEdit, required this.onDelete});\n@override Widget build(BuildContext context) => const SizedBox();\n}",
    "lib/features/splash/splash_screen.dart": "import 'package:flutter/material.dart';\nclass SplashScreen extends StatelessWidget {\nconst SplashScreen({super.key});\n@override Widget build(BuildContext context) => const Scaffold();\n}",
    "lib/features/onboarding/onboarding_page.dart": "import 'package:flutter/material.dart';\nclass OnboardingPage extends StatelessWidget {\nconst OnboardingPage({super.key});\n@override Widget build(BuildContext context) => const Scaffold();\n}",
    "lib/features/auth/login_page.dart": "import 'package:flutter/material.dart';\nclass LoginPage extends StatelessWidget {\nconst LoginPage({super.key});\n@override Widget build(BuildContext context) => const Scaffold();\n}",
    "lib/features/students/student_details_page.dart": "import 'package:flutter/material.dart';\nclass StudentDetailsPage extends StatelessWidget {\nfinal String studentId;\nconst StudentDetailsPage({super.key, required this.studentId});\n@override Widget build(BuildContext context) => const Scaffold();\n}",
    "lib/features/students/student_form_page.dart": "import 'package:flutter/material.dart';\nclass StudentFormPage extends StatelessWidget {\nfinal String? studentId;\nconst StudentFormPage({super.key, this.studentId});\n@override Widget build(BuildContext context) => const Scaffold();\n}",
    "lib/features/exams/exams_page.dart": "import 'package:flutter/material.dart';\nclass ExamsPage extends StatelessWidget {\nconst ExamsPage({super.key});\n@override Widget build(BuildContext context) => const Scaffold();\n}",
    "lib/features/exams/exam_preview_page.dart": "import 'package:flutter/material.dart';\nclass ExamPreviewPage extends StatelessWidget {\nfinal String examId;\nconst ExamPreviewPage({super.key, required this.examId});\n@override Widget build(BuildContext context) => const Scaffold();\n}",
    "lib/features/grades/grades_page.dart": "import 'package:flutter/material.dart';\nclass GradesPage extends StatelessWidget {\nconst GradesPage({super.key});\n@override Widget build(BuildContext context) => const Scaffold();\n}",
    "lib/features/assignments/assignments_page.dart": "import 'package:flutter/material.dart';\nclass AssignmentsPage extends StatelessWidget {\nconst AssignmentsPage({super.key});\n@override Widget build(BuildContext context) => const Scaffold();\n}",
    "lib/features/attendance/attendance_page.dart": "import 'package:flutter/material.dart';\nclass AttendancePage extends StatelessWidget {\nconst AttendancePage({super.key});\n@override Widget build(BuildContext context) => const Scaffold();\n}",
    "lib/features/reports/reports_page.dart": "import 'package:flutter/material.dart';\nclass ReportsPage extends StatelessWidget {\nconst ReportsPage({super.key});\n@override Widget build(BuildContext context) => const Scaffold();\n}",
    "lib/features/grades/domain/services/grade_calculation_service.dart": "class GradeCalculationService {\nstatic double calculatePercentage({required num score, required num total}) => (score / total) * 100;\nstatic double calculateAverage(List<num> scores) {\nif (scores.isEmpty) return 0.0;\nreturn scores.reduce((a, b) => a + b) / scores.length;\n}\nstatic String getGrade(double percentage) {\nif (percentage >= 90) return 'ممتاز';\nif (percentage >= 80) return 'جيد جداً';\nif (percentage >= 70) return 'جيد';\nif (percentage >= 60) return 'مقبول';\nreturn 'يحتاج تحسين';\n}\n}"
}

files.update(mock_files)

for path, content in files.items():
    full_path = os.path.join(r"d:\Flutter projects\teacher_exam_manager", path)
    os.makedirs(os.path.dirname(full_path), exist_ok=True)
    with open(full_path, "w", encoding="utf-8") as f:
        f.write(content)

print("Files written successfully")
