import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/exam.dart';
import '../../providers/exam_provider.dart';
import 'question_card.dart';
import 'question_type_dialog.dart';

class ExamQuestionsStep extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const ExamQuestionsStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExamProvider>();
    final questions = provider.currentQuestions;
    final totalMarks = provider.getTotalQuestionsMarks();
    final exam = provider.currentExam;

    // Grouping Questions
    final mainQuestions = questions.where((q) => q.type == QuestionType.groupHeader).toList();
    final subQuestions = questions.where((q) => q.type != QuestionType.groupHeader && q.parentId != null).toList();
    final standaloneQuestions = questions.where((q) => q.type != QuestionType.groupHeader && q.parentId == null).toList();

    return Column(
      children: [
        // Progress Info
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الأسئلة والفقرات: ${questions.length}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'المجموع: $totalMarks درجة',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        // Questions List
        if (questions.isEmpty)
          _buildEmptyState(context, exam?.id)
        else
          Column(
            children: [
              // 1. Standalone Questions (Old format support)
              if (standaloneQuestions.isNotEmpty) ...[
                const Text('أسئلة عامة (غير مجمعة)', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: AppSpacing.sm),
                ...standaloneQuestions.map((q) => _buildStandaloneQuestion(context, q, exam, provider)),
                const Divider(height: 32),
              ],
              
              // 2. Main Question Groups
              ...mainQuestions.map((mainQ) {
                final groupItems = subQuestions.where((sq) => sq.parentId == mainQ.id).toList();
                return _buildQuestionGroup(context, mainQ, groupItems, exam, provider);
              }),
            ],
          ),
          
        const SizedBox(height: AppSpacing.lg),
        
        // Add Main Question Button
        SizedBox(
          width: double.infinity,
          child: AppButton(
            text: provider.isSaving
                ? 'جاري حفظ الاختبار...'
                : 'إضافة سؤال رئيسي جديد (مثال: السؤال الأول)',
            icon: Icons.post_add,
            type: AppButtonType.primary,
            isLoading: provider.isSaving,
            onPressed: provider.isSaving
                ? null
                : () => _addMainQuestion(context, exam, provider),
          ),
        ),
        
        if (mainQuestions.isEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: 'إضافة سؤال مباشر (بدون تجميع)',
              icon: Icons.add,
              type: AppButtonType.outline,
              isLoading: provider.isSaving,
              onPressed: provider.isSaving
                  ? null
                  : () => _openQuestionEditor(context, exam, null),
            ),
          ),
        ],
        
        const SizedBox(height: 24),
        
        // Navigation
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'السابق',
                type: AppButtonType.outline,
                onPressed: onBack,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: AppButton(
                text: 'التالي: المراجعة',
                icon: Icons.arrow_forward,
                onPressed: onNext,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStandaloneQuestion(BuildContext context, Question q, Exam? exam, ExamProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: QuestionCard(
        question: q,
        index: provider.currentQuestions.indexOf(q),
        onEdit: () async {
          await context.pushNamed(
            'questionEdit',
            pathParameters: {'id': q.id},
            queryParameters: {
              'examId': exam?.id ?? '',
              'type': q.type.name,
              'parentId': q.parentId ?? '',
            },
          );
          if (context.mounted) context.read<ExamProvider>().reloadQuestions();
        },
        onDelete: () => _confirmDeleteQuestion(context, q, provider),
        onDuplicate: () async => await provider.duplicateQuestion(q.id),
      ),
    );
  }

  Widget _buildQuestionGroup(
    BuildContext context, 
    Question mainQ, 
    List<Question> items, 
    Exam? exam, 
    ExamProvider provider
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    mainQ.content,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _editMainQuestion(context, mainQ, provider),
                  tooltip: 'تعديل عنوان السؤال',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                  onPressed: () => _confirmDeleteQuestion(context, mainQ, provider),
                  tooltip: 'حذف السؤال وكل فقراته', 
                ),
              ],
            ),
            const Divider(),
            
            // Items
            if (items.isEmpty)
              const Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Center(child: Text('لا توجد فقرات، أضف فقرة جديدة', style: TextStyle(color: Colors.grey))),
              )
            else
              ...items.map((q) => _buildStandaloneQuestion(context, q, exam, provider)),
              
            const SizedBox(height: AppSpacing.sm),
            
            // Add Item Button
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => _openQuestionEditor(context, exam, mainQ.id),
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('إضافة فقرة'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteQuestion(BuildContext context, Question q, ExamProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف السؤال'),
        content: const Text('هل أنت متأكد من حذف هذا السؤال؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              provider.deleteQuestion(q.id);
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

  Future<void> _addMainQuestion(BuildContext context, Exam? exam, ExamProvider provider) async {
    if (exam == null) return;
    
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة سؤال رئيسي'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'مثال: السؤال الأول: اختر الإجابة الصحيحة',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
    
    if (result != null && result.isNotEmpty && context.mounted) {
      final newMainQuestion = Question(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        examId: exam.id,
        type: QuestionType.groupHeader,
        content: result,
        marks: 0, // Main question has no marks directly
        order: provider.currentQuestions.length,
        createdAt: DateTime.now(),
      );
      await provider.addQuestion(newMainQuestion);
    }
  }

  Future<void> _editMainQuestion(BuildContext context, Question mainQ, ExamProvider provider) async {
    final controller = TextEditingController(text: mainQ.content);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل السؤال الرئيسي'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
    
    if (result != null && result.isNotEmpty && context.mounted) {
      final updatedMainQ = mainQ.copyWith(content: result, updatedAt: DateTime.now());
      await provider.addQuestion(updatedMainQ); // addQuestion does insertOnConflictUpdate
    }
  }

  Future<void> _openQuestionEditor(BuildContext context, Exam? exam, String? parentId) async {
    if (exam == null) return;
    
    final type = await showDialog<QuestionType>(
      context: context,
      builder: (context) => QuestionTypeDialog(examId: exam.id),
    );
    
    if (type != null && context.mounted) {
      final queryParams = {
        'type': type.name,
        'examId': exam.id,
      };
      if (parentId != null) {
        queryParams['parentId'] = parentId;
      }
      
      await context.pushNamed(
        'questionCreate',
        queryParameters: queryParams,
      );
      
      if (context.mounted) {
        context.read<ExamProvider>().reloadQuestions();
      }
    }
  }

  Widget _buildEmptyState(BuildContext context, String? examId) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            Icon(
              Icons.format_list_bulleted,
              size: 48,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text('ابدأ ببناء هيكل الاختبار عبر إضافة أسئلة رئيسية'),
          ],
        ),
      ),
    );
  }
}
