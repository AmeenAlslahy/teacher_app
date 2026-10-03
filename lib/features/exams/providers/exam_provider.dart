import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../../core/state/base_provider.dart';
import '../domain/entities/exam.dart';
import '../domain/usecases/get_exams_use_case.dart';
import '../domain/usecases/get_exam_by_id_use_case.dart';
import '../domain/usecases/get_question_by_id_use_case.dart';
import '../domain/usecases/get_questions_for_exam_use_case.dart';
import '../domain/usecases/save_exam_use_case.dart';
import '../domain/usecases/save_question_use_case.dart';
import '../domain/usecases/validate_exam_use_case.dart';
import '../domain/usecases/delete_exam_use_case.dart';
import '../domain/usecases/delete_question_use_case.dart';
import '../domain/usecases/duplicate_exam_use_case.dart';

class ExamProvider extends BaseProvider {
  // Use Cases
  final GetExamsUseCase _getExamsUseCase;
  final GetExamByIdUseCase _getExamByIdUseCase;
  final GetQuestionsForExamUseCase _getQuestionsForExamUseCase;
  final SaveExamUseCase _saveExamUseCase;
  final ValidateExamUseCase _validateExamUseCase;
  final DeleteExamUseCase _deleteExamUseCase;
  final DuplicateExamUseCase _duplicateExamUseCase;
  final SaveQuestionUseCase _saveQuestionUseCase;
  final GetQuestionByIdUseCase _getQuestionByIdUseCase;
  final DeleteQuestionUseCase _deleteQuestionUseCase;

  
  // البيانات
  List<Exam> _exams = [];
  List<Exam> _filteredExams = [];
  Exam? _currentExam;
  List<Question> _currentQuestions = [];
  bool _isNewExam = false;
  
  // ✅ السؤال المُضاف حديثًا (للتمييز البصري)
  String? _lastAddedQuestionId;
  Timer? _highlightTimer;
  
  // ✅ السياق الحالي لإنشاء اختبار جديد
  String _contextSchoolId = '';
  String _contextClassId = '';
  String? _contextSectionId;
  String _contextSubjectId = '';
  String _contextSubjectName = '';
  
  // الحالة
  bool _isSaving = false;
  String _saveStatus = '';


  
  // الفلاتر
  String _searchQuery = '';
  String? _selectedSchoolId;
  String? _selectedClassId;
  String? _selectedSubjectId;
  ExamStatus? _selectedStatus;
  ExamType? _selectedType;
  
  // Getters
  List<Exam> get exams => _filteredExams;
  Exam? get currentExam => _currentExam;
  List<Question> get currentQuestions => _currentQuestions;
  bool get isNewExam => _isNewExam;
  bool get isSaving => _isSaving;
  String get saveStatus => _saveStatus;
  String get searchQuery => _searchQuery;
  String? get lastAddedQuestionId => _lastAddedQuestionId;
  String? get selectedSchoolId => _selectedSchoolId;
  String? get selectedClassId => _selectedClassId;
  String? get selectedSubjectId => _selectedSubjectId;
  ExamStatus? get selectedStatus => _selectedStatus;
  ExamType? get selectedType => _selectedType;
  bool get hasActiveFilters => 
      _searchQuery.isNotEmpty || 
      _selectedSchoolId != null || 
      _selectedClassId != null || 
      _selectedSubjectId != null ||
      _selectedStatus != null ||
      _selectedType != null;
  
  ExamProvider({
    required GetExamsUseCase getExamsUseCase,
    required GetExamByIdUseCase getExamByIdUseCase,
    required GetQuestionsForExamUseCase getQuestionsForExamUseCase,
    required SaveExamUseCase saveExamUseCase,
    required ValidateExamUseCase validateExamUseCase,
    required DeleteExamUseCase deleteExamUseCase,
    required DuplicateExamUseCase duplicateExamUseCase,
    required SaveQuestionUseCase saveQuestionUseCase,
    required GetQuestionByIdUseCase getQuestionByIdUseCase,
    required DeleteQuestionUseCase deleteQuestionUseCase,
  }) : 
    _getExamsUseCase = getExamsUseCase,
    _getExamByIdUseCase = getExamByIdUseCase,
    _getQuestionByIdUseCase = getQuestionByIdUseCase,
    _deleteQuestionUseCase = deleteQuestionUseCase,
    _getQuestionsForExamUseCase = getQuestionsForExamUseCase,
    _saveExamUseCase = saveExamUseCase,
    _validateExamUseCase = validateExamUseCase,
    _deleteExamUseCase = deleteExamUseCase,
    _duplicateExamUseCase = duplicateExamUseCase,
    _saveQuestionUseCase = saveQuestionUseCase;
  
  // ============================
  // تحميل البيانات
  // ============================
  
  Future<void> loadExams() async {
    setLoading(true);
    clearError();
    
    try {
      _exams = await _getExamsUseCase(
        schoolId: _selectedSchoolId,
        classId: _selectedClassId,
        subjectId: _selectedSubjectId,
        status: _selectedStatus,
      );
      _applyFilters();
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في تحميل الاختبارات');
      _filteredExams = [];
    } finally {
      setLoading(false);
    }
  }
  
  // ============================
  // تحميل اختبار محدد مع أسئلته
  // ============================
  
  Future<void> loadExam(String examId) async {
    setLoading(true);
    clearError();
    
    try {
      // تحميل الاختبار باستخدام Use Case مخصص
      final exam = await _getExamByIdUseCase(examId);
      if (exam == null) {
        setError('الاختبار غير موجود');
        _currentExam = null;
        _currentQuestions = [];
        return;
      }
      
      // تحميل الأسئلة باستخدام Use Case مخصص
      final questions = await _getQuestionsForExamUseCase(examId);
      
      _currentExam = exam;
      _currentQuestions = questions;
      _isNewExam = false;
      _saveStatus = '';
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في تحميل الاختبار');
      _currentExam = null;
      _currentQuestions = [];
      _isNewExam = false;
    } finally {
      setLoading(false);
    }
  }
  
  // ============================
  // الفلاتر
  // ============================
  
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }
  
  void setSchoolFilter(String? schoolId) {
    _selectedSchoolId = schoolId;
    loadExams();
  }
  
  void setClassFilter(String? classId) {
    _selectedClassId = classId;
    loadExams();
  }
  
  void setSubjectFilter(String? subjectId) {
    _selectedSubjectId = subjectId;
    loadExams();
  }
  
  void setStatusFilter(ExamStatus? status) {
    _selectedStatus = status;
    // توحيد السلوك مع setTypeFilter
    _applyFilters();
  }
  
  void setTypeFilter(ExamType? type) {
    _selectedType = type;
    _applyFilters();
  }
  
  void clearAllFilters() {
    _searchQuery = '';
    _selectedSchoolId = null;
    _selectedClassId = null;
    _selectedSubjectId = null;
    _selectedStatus = null;
    _selectedType = null;
    loadExams();
  }
  
  // ============================
  // إدارة الاختبار الحالي
  // ============================
  
  /// يُمرِّر السياق الحالي من ContextProvider.
  /// يُستدعى قبل createNewExam عند إنشاء اختبار جديد.
  void setContext({
    required String schoolId,
    required String classId,
    String? sectionId,
    required String subjectId,
    String subjectName = '',
  }) {
    _contextSchoolId = schoolId;
    _contextClassId = classId;
    _contextSectionId = sectionId;
    _contextSubjectId = subjectId;
    _contextSubjectName = subjectName;
  }

  void createNewExam() {
    // ✅ عنوان افتراضي ذكي
    final smartTitle = _contextSubjectName.isNotEmpty
        ? '$_contextSubjectName - اختبار جديد'
        : '';

    _currentExam = Exam(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: smartTitle,
      schoolId: _contextSchoolId,
      classId: _contextClassId,
      sectionId: _contextSectionId,
      subjectId: _contextSubjectId,
      type: ExamType.custom,
      academicYear: '2024-2025',
      semester: Semester.first,
      examDate: DateTime.now(),
      duration: 45,
      totalMarks: 20,
      status: ExamStatus.draft,
      createdAt: DateTime.now(),
    );
    _currentQuestions = [];
    _isNewExam = true;
    _saveStatus = '';
    notifyListeners();
  }
  
  void updateExamInfo(Exam exam) {
    _currentExam = exam;
    _saveStatus = 'مسودة غير محفوظة';
    notifyListeners();
  }
  
  // ============================
  // حفظ وحذف ونسخ
  // ============================
  
  Future<bool> saveExam() async {
    if (_currentExam == null) return false;
    
    _isSaving = true;
    _saveStatus = 'جارٍ الحفظ...';
    notifyListeners();
    
    try {
      final basicErrors = <String>[];
      if (_currentExam!.title.trim().isEmpty) {
        basicErrors.add('عنوان الاختبار مطلوب');
      }
      
      // ✅ التحقق من السياق قبل محاولة الحفظ
      if (_currentExam!.schoolId.isEmpty) {
        basicErrors.add('المدرسة غير محددة. يرجى اختيار السياق أولاً.');
      }
      if (_currentExam!.classId.isEmpty) {
        basicErrors.add('الصف غير محدد. يرجى اختيار السياق أولاً.');
      }
      if (_currentExam!.subjectId.isEmpty) {
        basicErrors.add('المادة غير محددة. يرجى اختيار السياق أولاً.');
      }
      
      if (basicErrors.isNotEmpty) {
        setError(basicErrors.join('\n'));
        _saveStatus = 'فشل في الحفظ';
        return false;
      }
      
      // ✅ احفظ الاختبار الأساسي أولاً لتفادي مشاكل الـ Foreign Key
      await _saveExamUseCase(_currentExam!);
      _isNewExam = false;
      
      // ✅ الآن احفظ الأسئلة
      for (final q in _currentQuestions) {
        await _saveQuestionUseCase(q);
      }
      
      _saveStatus = 'تم الحفظ ✓';
      clearError();
      return true;
    } catch (e, st) {
      debugPrint('Error saving exam: $e\n$st');
      handleError(e, fallbackMessage: 'فشل في حفظ الاختبار');
      _saveStatus = 'فشل في الحفظ';
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
  
  Future<void> deleteExam(String examId) async {
    try {
      await _deleteExamUseCase(examId);
      _exams.removeWhere((e) => e.id == examId);
      _applyFilters();
      clearError();
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في حذف الاختبار');
    }
  }
  
  Future<void> duplicateExam(String examId) async {
    try {
      final newExam = await _duplicateExamUseCase(examId);
      _exams.add(newExam);
      _applyFilters();
      clearError();
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في نسخ الاختبار');
    }
  }
  
  // ============================
  // إدارة الأسئلة
  // ============================
  
  Future<void> reloadQuestions() async {
    if (_currentExam == null) return;
    try {
      final questions = await _getQuestionsForExamUseCase(_currentExam!.id);
      _currentQuestions = questions;
      _updateTotalMarks();
      notifyListeners();
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في تحديث الأسئلة');
    }
  }
  
  Future<Question?> getQuestionById(String id) async {
    return await _getQuestionByIdUseCase(id);
  }
  
  Future<Question?> addQuestion(Question question) async {
    try {
      var updated = false;
      final existingIndex = _currentQuestions.indexWhere((q) => q.id == question.id);
      if (existingIndex >= 0) {
        _currentQuestions[existingIndex] = question;
        updated = true;
      } else {
        var insertionIndex = _currentQuestions.length;
        if (question.parentId != null) {
          final parentIndex = _currentQuestions.indexWhere((q) => q.id == question.parentId);
          if (parentIndex >= 0) {
            insertionIndex = parentIndex + 1;
            while (insertionIndex < _currentQuestions.length && _currentQuestions[insertionIndex].parentId == question.parentId) {
              insertionIndex++;
            }
          }
        }
        _currentQuestions.insert(insertionIndex, question.copyWith(
          examId: _currentExam?.id ?? question.examId,
          order: insertionIndex,
        ));
      }

      _reorderQuestions();
      await _persistQuestionOrder();
      _saveStatus = updated ? 'مسودة غير محفوظة' : 'مسودة غير محفوظة';
      _updateTotalMarks();
      clearError();
      notifyListeners();
      return _currentQuestions.firstWhere((q) => q.id == question.id);
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في إضافة السؤال');
      return null;
    }
  }

  Future<Question?> addSection({required String title, String? instructions}) async {
    if (_currentExam == null || title.trim().isEmpty) return null;
    final section = Question(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      examId: _currentExam!.id,
      type: QuestionType.groupHeader,
      content: title.trim(),
      instructions: instructions?.trim().isEmpty == true ? null : instructions?.trim(),
      marks: 0,
      order: _currentQuestions.length,
      createdAt: DateTime.now(),
    );
    return addQuestion(section);
  }

  Future<void> _persistQuestionOrder() async {
    if (_currentExam == null || _currentQuestions.isEmpty) return;
    try {
      await _saveQuestionOrderUseCaseFallback();
    } catch (_) {
      // Order will be picked up by the next normal exam save.
    }
  }

  Future<void> _saveQuestionOrderUseCaseFallback() async {
    // SaveQuestionUseCase writes the complete question including its order.
    for (final question in _currentQuestions) {
      await _saveQuestionUseCase(question);
    }
  }

  Future<void> deleteQuestion(String questionId) async {
    try {
      final targetIndex = _currentQuestions.indexWhere((q) => q.id == questionId);
      final target = targetIndex >= 0 ? _currentQuestions[targetIndex] : null;
      if (target == null) return;

      final idsToDelete = <String>[questionId];
      if (target.type == QuestionType.groupHeader) {
        idsToDelete.addAll(_currentQuestions.where((q) => q.parentId == questionId).map((q) => q.id));
      }

      for (final id in idsToDelete) {
        await _deleteQuestionUseCase(id);
      }
      _currentQuestions.removeWhere((q) => idsToDelete.contains(q.id));
      _reorderQuestions();
      _updateTotalMarks();
      _saveStatus = 'مسودة غير محفوظة';
      clearError();
      await _persistQuestionOrder();
      notifyListeners();
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في حذف السؤال');
    }
  }

  Future<void> reorderQuestions(int oldIndex, int newIndex) async {
    if (oldIndex < 0 || oldIndex >= _currentQuestions.length) return;
    if (newIndex < 0 || newIndex >= _currentQuestions.length) return;
    if (newIndex > oldIndex) newIndex -= 1;
    if (oldIndex == newIndex) return;

    final item = _currentQuestions.removeAt(oldIndex);
    _currentQuestions.insert(newIndex, item);
    _reorderQuestions();
    _saveStatus = 'مسودة غير محفوظة';
    notifyListeners();
    await _persistQuestionOrder();
  }

  Future<void> reorderQuestionsByIds(List<String> questionIds) async {
    final byId = {for (final q in _currentQuestions) q.id: q};
    final reordered = <Question>[];
    for (final id in questionIds) {
      final question = byId[id];
      if (question != null) reordered.add(question);
    }
    for (final question in _currentQuestions) {
      if (!questionIds.contains(question.id)) reordered.add(question);
    }
    _currentQuestions = reordered;
    _reorderQuestions();
    _saveStatus = 'مسودة غير محفوظة';
    notifyListeners();
    await _persistQuestionOrder();
  }

  Future<Question?> duplicateQuestion(String questionId) async {
    final index = _currentQuestions.indexWhere((q) => q.id == questionId);
    if (index < 0) return null;
    final question = _currentQuestions[index];
    final newId = DateTime.now().microsecondsSinceEpoch.toString();
    final newQuestion = question.copyWith(
      id: newId,
      order: index + 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      options: question.options.map((o) => QuestionOption(
        id: '${newId}_opt_${o.order}',
        questionId: newId,
        content: o.content,
        order: o.order,
        isCorrect: o.isCorrect,
      )).toList(),
      blocks: question.blocks.map((b) => QuestionBlock(
        id: '${newId}_block_${b.order}',
        questionId: newId,
        type: b.type,
        content: b.content,
        order: b.order,
        metadata: b.metadata,
      )).toList(),
    );

    try {
      final saved = await _saveQuestionUseCase(newQuestion);
      _currentQuestions.insert(index + 1, saved);
      _reorderQuestions();
      _saveStatus = 'مسودة غير محفوظة';
      _updateTotalMarks();
      clearError();
      await _persistQuestionOrder();
      return saved;
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في نسخ السؤال');
      return null;
    }
  }

  double getTotalQuestionsMarks() {
    return _currentQuestions.fold(0.0, (sum, q) => sum + q.marks);
  }
  
  Future<List<String>> validateExam() async {
    if (_currentExam == null) return ['الاختبار غير موجود'];
    final result = await _validateExamUseCase(_currentExam!.id);
    return result.errors;
  }
  
  // ============================
  // دوال مساعدة خاصة
  // ============================
  
  void _applyFilters() {
    _filteredExams = _exams.where((exam) {
      // فلتر النوع
      if (_selectedType != null && exam.type != _selectedType) return false;
      
      // فلتر الحالة
      if (_selectedStatus != null && exam.status != _selectedStatus) return false;
      
      // فلتر البحث
      if (_searchQuery.isNotEmpty && !exam.title.contains(_searchQuery)) return false;
      
      return true;
    }).toList();
    notifyListeners();
  }
  
  void _reorderQuestions() {
    for (var i = 0; i < _currentQuestions.length; i++) {
      _currentQuestions[i] = _currentQuestions[i].copyWith(order: i);
    }
  }
  
  void _swapQuestions(int index1, int index2) {
    final temp = _currentQuestions[index1];
    _currentQuestions[index1] = _currentQuestions[index2];
    _currentQuestions[index2] = temp;
    _reorderQuestions();
  }
  
  void _updateTotalMarks() {
    if (_currentExam != null) {
      final total = getTotalQuestionsMarks();
      _currentExam = _currentExam!.copyWith(totalMarks: total);
      _saveStatus = 'مسودة غير محفوظة';
    }
  }

  void reset() {
    _highlightTimer?.cancel();
    _lastAddedQuestionId = null;
    _currentExam = null;
    _currentQuestions = [];
    _isNewExam = false;
    _saveStatus = '';
    _isSaving = false;
    clearError();
    notifyListeners();
  }
}