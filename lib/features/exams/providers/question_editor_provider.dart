// lib/features/exams/presentation/providers/question_editor_provider.dart
import 'package:flutter/material.dart';
import '../../../core/state/base_provider.dart';
import '../domain/entities/exam.dart';
import '../domain/entities/question_content.dart';
import '../domain/usecases/save_question_use_case.dart';
import '../domain/usecases/get_question_by_id_use_case.dart';
import '../presentation/widgets/rich_text_controller.dart';

class QuestionEditorProvider extends BaseProvider {
  final QuestionType type;
  final String? questionId;
  final String examId;
  final String? parentId;
  int _order;
  final SaveQuestionUseCase _saveQuestionUseCase;
  final GetQuestionByIdUseCase _getQuestionByIdUseCase;
  
  // Controllers
  late final RichTextController contentController;
  final instructionsController = TextEditingController();
  final explanationController = TextEditingController();
  final marksController = TextEditingController();
  
  // Options
  List<TextEditingController> optionControllers = [];
  List<bool> optionCorrectness = [];
  
  // Blocks
  final Map<String, ContentBlock> inlineBlocks = {};
  final List<ContentBlock> _contentBlocks = [];
  
  // State
  Difficulty _difficulty = Difficulty.medium;
  String? _unit;
  String? _lesson;
  String? _correctAnswer;
  bool _isSaving = false;
  
  // Getters
  Difficulty get difficulty => _difficulty;
  String? get unit => _unit;
  String? get lesson => _lesson;
  String? get correctAnswer => _correctAnswer;
  bool get isSaving => _isSaving;
  int get order => _order;
  bool get hasOptions => type == QuestionType.multipleChoice || 
                           type == QuestionType.multipleAnswers;
  List<ContentBlock> get contentBlocks => _contentBlocks;
  
  QuestionEditorProvider({
    required this.type,
    this.questionId,
    required this.examId,
    this.parentId,
    int initialOrder = 0,
    required SaveQuestionUseCase saveQuestionUseCase,
    required GetQuestionByIdUseCase getQuestionByIdUseCase,
  }) : 
    _order = initialOrder,
    _saveQuestionUseCase = saveQuestionUseCase,
    _getQuestionByIdUseCase = getQuestionByIdUseCase {
    contentController = RichTextController(inlineBlocks: inlineBlocks);
    _initializeOptions();
    if (questionId != null) {
      _loadQuestion();
    }
    marksController.text = '1';
  }
  
  void _initializeOptions() {
    if (!hasOptions) return;
    for (var i = 0; i < 4; i++) {
      optionControllers.add(TextEditingController());
      optionCorrectness.add(false);
    }
  }

  void addOption() {
    if (!hasOptions) return;
    optionControllers.add(TextEditingController());
    optionCorrectness.add(false);
    notifyListeners();
  }

  void removeOption(int index) {
    if (!hasOptions || optionControllers.length <= 2 || index < 0 || index >= optionControllers.length) return;
    optionControllers[index].dispose();
    optionControllers.removeAt(index);
    optionCorrectness.removeAt(index);
    notifyListeners();
  }
  
  Future<void> _loadQuestion() async {
    if (questionId == null) return;
    
    setLoading(true);
    clearError();
    
    try {
      final question = await _getQuestionByIdUseCase(questionId!);
      if (question != null) {
        contentController.text = question.content;
        instructionsController.text = question.instructions ?? '';
        explanationController.text = question.explanation ?? '';
        marksController.text = question.marks.toString();
        _order = question.order;
        _difficulty = question.difficulty;
        _unit = question.unit;
        _lesson = question.lesson;
        _correctAnswer = question.correctAnswer;
        
        // تحميل الخيارات مع الحفاظ على العدد الحقيقي عند التعديل.
        if (hasOptions) {
          while (optionControllers.length < question.options.length) {
            optionControllers.add(TextEditingController());
            optionCorrectness.add(false);
          }
          while (optionControllers.length > 2 && optionControllers.length > question.options.length && question.options.isNotEmpty) {
            final controller = optionControllers.removeLast();
            controller.dispose();
            optionCorrectness.removeLast();
          }
          for (var i = 0; i < question.options.length; i++) {
            optionControllers[i].text = question.options[i].content;
            optionCorrectness[i] = question.options[i].isCorrect;
          }
        }
        
        // تحميل الكتل
        _contentBlocks.clear();
        inlineBlocks.clear();
        for (final block in question.blocks) {
          final contentBlock = ContentBlock(
            id: block.id,
            type: _mapBlockTypeToContentBlockType(block.type),
            content: block.content,
            order: block.order,
            metadata: block.metadata,
          );
          
          if (question.content.contains('[[${block.id}]]')) {
            inlineBlocks[block.id] = contentBlock;
          } else {
            _contentBlocks.add(contentBlock);
          }
        }
      }
    } catch (e) {
      handleError(e, fallbackMessage: 'فشل في تحميل السؤال');
    } finally {
      setLoading(false);
    }
  }
  
  void setDifficulty(Difficulty difficulty) {
    _difficulty = difficulty;
    notifyListeners();
  }
  
  void setUnit(String? unit) {
    _unit = unit;
    notifyListeners();
  }
  
  void setLesson(String? lesson) {
    _lesson = lesson;
    notifyListeners();
  }
  
  void setCorrectAnswer(String? answer) {
    _correctAnswer = answer;
    notifyListeners();
  }
  
  void toggleOptionCorrect(int index) {
    if (type == QuestionType.multipleChoice) {
      // في حالة الاختيار من متعدد، يمكن اختيار إجابة واحدة فقط
      for (var i = 0; i < optionCorrectness.length; i++) {
        optionCorrectness[i] = (i == index);
      }
    } else {
      // في حالة الإجابات المتعددة، يمكن اختيار أكثر من إجابة
      optionCorrectness[index] = !optionCorrectness[index];
    }
    notifyListeners();
  }
  
  void addContentBlock(ContentBlock block) {
    _contentBlocks.add(block);
    notifyListeners();
  }
  
  void insertInlineBlock(ContentBlockType type, String content) {
    final blockId = DateTime.now().microsecondsSinceEpoch.toString();
    
    inlineBlocks[blockId] = ContentBlock(
      id: blockId,
      type: type,
      content: content,
      order: inlineBlocks.length,
    );
    
    final selection = contentController.selection;
    final cursorPos = selection.baseOffset > -1 ? selection.baseOffset : contentController.text.length;
    final placeholder = '[[$blockId]]';
    
    final newText = contentController.text.substring(0, cursorPos) +
        placeholder +
        contentController.text.substring(cursorPos);
        
    contentController.text = newText;
    contentController.selection = TextSelection.collapsed(
      offset: cursorPos + placeholder.length,
    );
    
    notifyListeners();
  }
  
  void removeContentBlock(String blockId) {
    _contentBlocks.removeWhere((b) => b.id == blockId);
    final removedInline = inlineBlocks.remove(blockId);
    if (removedInline != null) {
      final placeholder = '[[$blockId]]';
      contentController.text = contentController.text.replaceAll(placeholder, '');
    }
    notifyListeners();
  }
  
  void reorderContentBlocks(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final block = _contentBlocks.removeAt(oldIndex);
    _contentBlocks.insert(newIndex, block);
    notifyListeners();
  }
  
  Future<bool> saveQuestion() async {
    // التحقق من صحة المحتوى
    if (contentController.text.trim().isEmpty && _contentBlocks.isEmpty) {
      setError('محتوى السؤال مطلوب');
      return false;
    }
    
    // التحقق من صحة الخيارات
    if (hasOptions) {
      if (type == QuestionType.multipleChoice && optionControllers.length < 2) {
        setError('أضف خيارين على الأقل');
        return false;
      }
      final hasCorrectOption = optionCorrectness.any((isCorrect) => isCorrect);
      if (!hasCorrectOption) {
        setError('يجب تحديد إجابة صحيحة واحدة على الأقل');
        return false;
      }
      
      final hasEmptyOption = optionControllers.any((controller) => controller.text.trim().isEmpty);
      if (hasEmptyOption) {
        setError('جميع الخيارات مطلوبة');
        return false;
      }
    }
    
    _isSaving = true;
    clearError();
    notifyListeners();
    
    try {
      final marks = double.tryParse(marksController.text) ?? 1.0;
      if (marks <= 0) {
        setError('الدرجة يجب أن تكون أكبر من صفر');
        _isSaving = false;
        notifyListeners();
        return false;
      }
      
      // ✅ وَلِّد ID السؤال أولاً حتى تستخدمه الخيارات والكتل
      final actualQuestionId = questionId ??
          DateTime.now().microsecondsSinceEpoch.toString();

      // بناء الخيارات
      final options = hasOptions
          ? optionControllers.asMap().entries.map((entry) {
              final index = entry.key;
              final controller = entry.value;
              return QuestionOption(
                id: '${DateTime.now().microsecondsSinceEpoch}_opt_$index',
                questionId: actualQuestionId,
                content: controller.text.trim(),
                order: index,
                isCorrect: optionCorrectness[index],
              );
            }).where((o) => o.content.isNotEmpty).toList()
          : <QuestionOption>[];
      
      // بناء الكتل
      final activeInlineBlocks = inlineBlocks.values
          .where((b) => contentController.text.contains('[[${b.id}]]'));
          
      final allBlocks = [..._contentBlocks, ...activeInlineBlocks];
      
      final blocks = allBlocks.map((b) => QuestionBlock(
        id: b.id,
        questionId: actualQuestionId,
        type: _mapContentBlockTypeToBlockType(b.type),
        content: b.content,
        order: b.order,
        metadata: b.metadata,
      )).toList();
      
      // بناء السؤال
      final question = Question(
        id: actualQuestionId,
        examId: examId,
        parentId: parentId,
        type: type,
        content: contentController.text.trim(),
        instructions: instructionsController.text.trim().isEmpty ? null : instructionsController.text.trim(),
        marks: marks,
        order: _order,
        difficulty: _difficulty,
        unit: _unit?.trim().isEmpty == true ? null : _unit?.trim(),
        lesson: _lesson?.trim().isEmpty == true ? null : _lesson?.trim(),
        correctAnswer: _correctAnswer?.trim().isEmpty == true ? null : _correctAnswer?.trim(),
        explanation: explanationController.text.trim().isEmpty ? null : explanationController.text.trim(),
        options: options,
        blocks: blocks,
        createdAt: DateTime.now(),
      );
      
      // حفظ السؤال في قاعدة البيانات
      await _saveQuestionUseCase(question);
      
      return true;
    } catch (e, stackTrace) {
      debugPrint('Error saving question: $e');
      debugPrint('Stack trace: $stackTrace');
      handleError(e, fallbackMessage: 'حدث خطأ أثناء حفظ السؤال. يرجى حفظ بيانات الاختبار الأساسية أولاً ثم المحاولة مرة أخرى.');
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
  
  // إعادة تعيين النموذج لحالة جديدة
  /// Clears only the current question data while keeping the creation preferences
  /// (type, option count, marks and difficulty) for rapid question creation.
  void resetForNextQuestion({int? nextOrder}) {
    if (nextOrder != null) _order = nextOrder;
    contentController.clear();
    instructionsController.clear();
    explanationController.clear();
    _correctAnswer = null;
    _unit = null;
    _lesson = null;
    _contentBlocks.clear();
    inlineBlocks.clear();

    for (var i = 0; i < optionControllers.length; i++) {
      optionControllers[i].clear();
      optionCorrectness[i] = false;
    }

    clearError();
    notifyListeners();
  }

  void resetForm() => resetForNextQuestion();
  
  // التحقق من صحة السؤال بدون حفظ
  List<String> validate() {
    final errors = <String>[];

    if (contentController.text.trim().isEmpty && _contentBlocks.isEmpty) {
      errors.add('محتوى السؤال مطلوب');
    }
    
    if (hasOptions) {
      if (type == QuestionType.multipleChoice && optionControllers.length < 2) {
        errors.add('أضف خيارين على الأقل');
      }
      final hasCorrectOption = optionCorrectness.any((isCorrect) => isCorrect);
      if (!hasCorrectOption) {
        errors.add('يجب تحديد إجابة صحيحة واحدة على الأقل');
      }
      
      final hasEmptyOption = optionControllers.any((controller) => controller.text.trim().isEmpty);
      if (hasEmptyOption) {
        errors.add('جميع الخيارات مطلوبة');
      }
    }
    
    final marks = double.tryParse(marksController.text) ?? 0;
    if (marks <= 0) {
      errors.add('الدرجة يجب أن تكون أكبر من صفر');
    }
    
    return errors;
  }
  
  BlockType _mapContentBlockTypeToBlockType(ContentBlockType type) {
    switch (type) {
      case ContentBlockType.math:
        return BlockType.math;
      case ContentBlockType.physics:
        return BlockType.physics;
      case ContentBlockType.chemistry:
        return BlockType.chemistry;
      case ContentBlockType.image:
        return BlockType.image;
      case ContentBlockType.table:
        return BlockType.table;
      case ContentBlockType.text:
      default:
        return BlockType.text;
    }
  }
  
  ContentBlockType _mapBlockTypeToContentBlockType(BlockType type) {
    switch (type) {
      case BlockType.math:
        return ContentBlockType.math;
      case BlockType.physics:
        return ContentBlockType.physics;
      case BlockType.chemistry:
        return ContentBlockType.chemistry;
      case BlockType.image:
        return ContentBlockType.image;
      case BlockType.table:
        return ContentBlockType.table;
      case BlockType.text:
        return ContentBlockType.text;
    }
  }
  
  @override
  void dispose() {
    contentController.dispose();
    instructionsController.dispose();
    explanationController.dispose();
    marksController.dispose();
    for (final controller in optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}