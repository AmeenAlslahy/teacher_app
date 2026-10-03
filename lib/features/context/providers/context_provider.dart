import '../../../app/database/app_database.dart';
import '../../../core/state/base_provider.dart';
import '../../schools/data/repositories/school_repository.dart';
import '../../classes/data/repositories/class_repository.dart';
import '../../subjects/data/repositories/subject_repository.dart';
import '../data/services/context_preferences.dart';

class ContextProvider extends BaseProvider {
  final SchoolRepository _schoolRepo;
  final ClassRepository _classRepo;
  final SubjectRepository _subjectRepo;

  ContextProvider(this._schoolRepo, this._classRepo, this._subjectRepo);

  // ===== State =====
  List<School> _schools = [];
  List<ClassesData> _classes = [];
  List<Section> _sections = [];
  List<Subject> _subjects = [];

  School? _selectedSchool;
  ClassesData? _selectedClass;
  Section? _selectedSection;
  Subject? _selectedSubject;

  // ===== Getters =====
  List<School> get schools => _schools;
  List<ClassesData> get classes => _classes;
  List<Section> get sections => _sections;
  List<Subject> get subjects => _subjects;

  School? get selectedSchool => _selectedSchool;
  ClassesData? get selectedClass => _selectedClass;
  Section? get selectedSection => _selectedSection;
  Subject? get selectedSubject => _selectedSubject;

  String? get schoolId => _selectedSchool?.id;
  String? get classId => _selectedClass?.id;
  String? get sectionId => _selectedSection?.id;
  String? get subjectId => _selectedSubject?.id;

  String get schoolName => _selectedSchool?.name ?? 'غير محدد';
  String get className => _selectedClass?.name ?? 'غير محدد';
  String get sectionName => _selectedSection?.name ?? '';
  String get subjectName => _selectedSubject?.name ?? 'غير محدد';

  bool get isComplete =>
      _selectedSchool != null &&
      _selectedClass != null &&
      _selectedSubject != null;

  // ===== Loading =====
  Future<void> loadAll() async {
    setLoading(true);
    clearError();

    try {
      await _schoolRepo.seedIfEmpty();

      _schools = await _schoolRepo.getAll();
      _subjects = await _subjectRepo.getAll();

      final saved = await ContextPreferences.load();
      _selectedSchool = _findSchool(saved['schoolId']);
      _selectedSubject = _findSubject(saved['subjectId']);

      if (_selectedSchool != null) {
        _classes = await _classRepo.getBySchool(_selectedSchool!.id);
        _selectedClass = _findClass(saved['classId']);
      } else if (_schools.isNotEmpty) {
        // Auto-select first school if none is saved (first run)
        _selectedSchool = _schools.first;
        _classes = await _classRepo.getBySchool(_selectedSchool!.id);
      }

      if (_selectedClass != null) {
        _sections = await _classRepo.getSectionsByClass(_selectedClass!.id);
        _selectedSection = _findSection(saved['sectionId']);
      }
    } catch (e) {
      setError('فشل في تحميل السياق: $e');
    } finally {
      setLoading(false);
    }
  }

  // ===== Selection =====
  Future<void> selectSchool(School? school) async {
    _selectedSchool = school;
    _selectedClass = null;
    _selectedSection = null;
    _classes = [];
    _sections = [];

    if (school != null) {
      _classes = await _classRepo.getBySchool(school.id);
    }
    notifyListeners();
  }

  Future<void> selectClass(ClassesData? cls) async {
    _selectedClass = cls;
    _selectedSection = null;
    _sections = [];

    if (cls != null) {
      _sections = await _classRepo.getSectionsByClass(cls.id);
    }
    notifyListeners();
  }

  void selectSection(Section? section) {
    _selectedSection = section;
    notifyListeners();
  }

  void selectSubject(Subject? subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  // ===== Persistence =====
  Future<void> persist() async {
    await ContextPreferences.save(
      schoolId: _selectedSchool?.id,
      classId: _selectedClass?.id,
      sectionId: _selectedSection?.id,
      subjectId: _selectedSubject?.id,
    );
  }

  // ===== Helpers =====
  School? _findSchool(String? id) {
    if (id == null) return null;
    for (final s in _schools) {
      if (s.id == id) return s;
    }
    return null;
  }

  ClassesData? _findClass(String? id) {
    if (id == null) return null;
    for (final c in _classes) {
      if (c.id == id) return c;
    }
    return null;
  }

  Section? _findSection(String? id) {
    if (id == null) return null;
    for (final s in _sections) {
      if (s.id == id) return s;
    }
    return null;
  }

  Subject? _findSubject(String? id) {
    if (id == null) return null;
    for (final s in _subjects) {
      if (s.id == id) return s;
    }
    return null;
  }
}
