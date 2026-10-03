import 'dart:io';
import '../../../core/state/base_provider.dart';
import '../data/services/student_import_service.dart';
import '../data/repositories/student_repository.dart';

class StudentImportProvider extends BaseProvider {
  final StudentRepository _repository;
  
  List<StudentImportModel>? _importedStudents;
  List<String> _validationErrors = [];
  bool _isImporting = false;
  String? _fileName;
  ImportResult? _importResult;
  
  // Getters
  List<StudentImportModel>? get importedStudents => _importedStudents;
  List<String> get validationErrors => _validationErrors;
  bool get isImporting => _isImporting;
  String? get fileName => _fileName;
  ImportResult? get importResult => _importResult;
  bool get hasValidatedStudents => _importedStudents != null;
  bool get canImport => _importedStudents != null && _validationErrors.isEmpty;
  
  StudentImportProvider(this._repository);
  
  // قراءة ملف الاستيراد
  Future<void> readFile(String filePath, {required bool isCsv}) async {
    setLoading(true);
    clearError();
    
    try {
      final students = isCsv
          ? await StudentImportService.importFromCsv(filePath)
          : await StudentImportService.importFromExcel(filePath);
      
      final errors = StudentImportService.validateStudents(students);
      
      _importedStudents = students;
      _validationErrors = errors;
      _fileName = File(filePath).uri.pathSegments.last;
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في قراءة الملف');
    } finally {
      setLoading(false);
    }
  }
  
  // إلغاء الاستيراد
  void cancelImport() {
    _importedStudents = null;
    _validationErrors = [];
    _fileName = null;
    _importResult = null;
    notifyListeners();
  }
  
  // تنفيذ الاستيراد
  Future<bool> importStudents() async {
    if (_importedStudents == null || _importedStudents!.isEmpty) {
      setError('لا يوجد طلاب للاستيراد');
      return false;
    }
    
    if (_validationErrors.isNotEmpty) {
      setError('يرجى تصحيح الأخطاء قبل الاستيراد');
      return false;
    }
    
    _isImporting = true;
    clearError();
    notifyListeners();
    
    try {
      final result = await _repository.importStudents(_importedStudents!);
      _importResult = result;
      return true;
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في الاستيراد');
      return false;
    } finally {
      _isImporting = false;
      notifyListeners();
    }
  }
}
