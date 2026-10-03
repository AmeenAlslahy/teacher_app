import '../../../../core/state/base_provider.dart';
import '../data/repositories/student_repository.dart';
import '../data/services/student_import_service.dart';
import '../domain/entities/student.dart';
import '../domain/entities/class_section.dart';

enum StudentSortBy { name, number, className, dateAdded }

class StudentProvider extends BaseProvider {
  final StudentRepository _repository;
  
  StudentProvider(this._repository);
  
  List<ClassModel> _classes = [];
  List<ClassModel> get classes => _classes;
  
  List<SectionModel> _sections = [];
  List<SectionModel> get sections => _sections;
  
  List<StudentWithDetails> _students = [];
  List<StudentWithDetails>? _filteredStudentsCache;
  
  List<StudentWithDetails> get students {
    _filteredStudentsCache ??= _computeFiltered();
    return _filteredStudentsCache!;
  }

  List<StudentWithDetails> _computeFiltered() {
    var result = List<StudentWithDetails>.from(_students);
    
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result = result.where((s) =>
        s.student.name.toLowerCase().contains(q) ||
        s.student.studentNumber.toLowerCase().contains(q)
      ).toList();
    }
    
    if (_selectedClassId != null) {
      result = result.where((s) => s.student.classId == _selectedClassId).toList();
    }
    
    if (_selectedSectionId != null) {
      result = result.where((s) => s.student.sectionId == _selectedSectionId).toList();
    }
    
    result.sort((a, b) {
      int cmp;
      switch (_sortBy) {
        case StudentSortBy.name:
          cmp = a.student.name.compareTo(b.student.name);
          break;
        case StudentSortBy.number:
          cmp = a.student.studentNumber.compareTo(b.student.studentNumber);
          break;
        case StudentSortBy.className:
          cmp = a.className.compareTo(b.className);
          break;
        case StudentSortBy.dateAdded:
          cmp = a.student.createdAt.compareTo(b.student.createdAt);
          break;
      }
      return _sortAscending ? cmp : -cmp;
    });
    
    return result;
  }
  

  
  final bool _hasMore = false;
  bool get hasMore => _hasMore;
  
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  
  StudentSortBy _sortBy = StudentSortBy.name;
  StudentSortBy get sortBy => _sortBy;
  
  bool _sortAscending = true;
  bool get sortAscending => _sortAscending;
  
  String? _selectedClassId;
  String? get selectedClassId => _selectedClassId;
  String? get selectedClassName {
    if (_selectedClassId == null) return null;
    return _classes
        .where((c) => c.id == _selectedClassId)
        .map((c) => c.name)
        .firstOrNull;
  }
  
  String? _selectedSectionId;
  String? get selectedSectionId => _selectedSectionId;
  String? get selectedSectionName {
    if (_selectedSectionId == null) return null;
    return _sections
        .where((s) => s.id == _selectedSectionId)
        .map((s) => s.name)
        .firstOrNull;
  }
  
  bool get hasActiveFilters => _searchQuery.isNotEmpty || _selectedClassId != null || _selectedSectionId != null;
  
  Future<void> loadInitialData() async {
    setLoading(true);
    notifyListeners();
    
    try {
      await _repository.seedDefaultClassesAndSections();
      
      final dbClasses = await _repository.getClasses();
      _classes = dbClasses
          .map((c) => ClassModel(id: c.id, name: c.name, gradeLevel: c.gradeLevel))
          .toList();
      
      final dbSections = await _repository.getSections();
      _sections = dbSections
          .map((s) => SectionModel(id: s.id, classId: s.classId, name: s.name))
          .toList();
      
      final dbStudents = await _repository.getAllStudents();
      _students = dbStudents.map((s) {
        final className = dbClasses.where((c) => c.id == s.classId).map((e) => e.name).firstOrNull ?? 'غير محدد';
        final sectionName = dbSections.where((sec) => sec.id == s.sectionId).map((e) => e.name).firstOrNull;
        return StudentWithDetails(
          student: s,
          className: className,
          sectionName: sectionName,
        );
      }).toList();
    } catch (e) {
      _students = [];
    }
    
    _filteredStudentsCache = null;
    setLoading(false);
    notifyListeners();
  }
  
  Future<void> loadMoreStudents() async {
    //
  }
  
  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    _filteredStudentsCache = null;
    notifyListeners();
  }
  
  void setClassFilter(String? classId) {
    if (_selectedClassId == classId) return;
    _selectedClassId = classId;
    _filteredStudentsCache = null;
    notifyListeners();
  }
  
  void setSectionFilter(String? sectionId) {
    if (_selectedSectionId == sectionId) return;
    _selectedSectionId = sectionId;
    _filteredStudentsCache = null;
    notifyListeners();
  }
  
  void setSortBy(StudentSortBy sort) {
    if (_sortBy == sort) {
      _sortAscending = !_sortAscending;
    } else {
      _sortBy = sort;
      _sortAscending = true;
    }
    _filteredStudentsCache = null;
    notifyListeners();
  }
  
  void clearAllFilters() {
    _searchQuery = '';
    _selectedClassId = null;
    _selectedSectionId = null;
    _filteredStudentsCache = null;
    notifyListeners();
  }
  
  Future<List<Map<String, dynamic>>> exportStudents() async {
    // Return dummy data for export
    return _students.map((e) => e.student.toJson()..addAll({
      'className': e.className,
      'sectionName': e.sectionName,
    })).toList();
  }
  
  Future<void> deleteStudent(String id) async {
    try {
      await _repository.softDeleteStudent(id);
      _students.removeWhere((e) => e.student.id == id);
      _filteredStudentsCache = null;
      notifyListeners();
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في حذف الطالب');
      rethrow;
    }
  }
  
  Future<Student?> getStudentById(String id) async {
    return await _repository.getStudentById(id);
  }
  
  Future<StudentWithDetails?> getStudentWithDetails(String id) async {
    final s = await _repository.getStudentById(id);
    if (s == null) return null;
    
    final className = _classes
        .where((c) => c.id == s.classId)
        .map((c) => c.name)
        .firstOrNull ?? 'غير محدد';
    
    final sectionName = s.sectionId == null
        ? null
        : _sections
            .where((sec) => sec.id == s.sectionId)
            .map((sec) => sec.name)
            .firstOrNull;
    
    return StudentWithDetails(
      student: s,
      className: className,
      sectionName: sectionName,
    );
  }
  
  Future<void> addStudent(Student student) async {
    try {
      await _repository.createStudent(student);
      await loadInitialData();
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في إضافة الطالب');
      rethrow;
    }
  }
  
  Future<void> updateStudent(Student student) async {
    try {
      await _repository.updateStudent(student);
      await loadInitialData();
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في تحديث الطالب');
      rethrow;
    }
  }
  
  Future<ImportResult> importStudents(List<StudentImportModel> importedStudents) async {
    final result = await _repository.importStudents(importedStudents);
    await loadInitialData();
    return result;
  }
}
