import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/exam.dart';
import '../../providers/exam_provider.dart';
import '../widgets/question_card.dart';
import '../widgets/question_editor_sheet.dart';
import '../widgets/question_type_dialog.dart';

class ExamCanvasPage extends StatelessWidget {
  const ExamCanvasPage({super.key});

  int _nextOrder(List<Question> questions, {String? parentId}) {
    if (parentId == null) return questions.length;
    final siblings = questions.where((q) => q.parentId == parentId).toList();
    if (siblings.isEmpty) {
      final parentIndex = questions.indexWhere((q) => q.id == parentId);
      return parentIndex < 0 ? questions.length : parentIndex + 1;
    }
    return siblings.map((q) => q.order).reduce((a, b) => a > b ? a : b) + 1;
  }

  Future<void> _addQuestion(BuildContext context, {String? parentId}) async {
    final provider = context.read<ExamProvider>();
    final exam = provider.currentExam;
    if (exam == null) return;
    final initialOrder = _nextOrder(provider.currentQuestions, parentId: parentId);

    final type = await showModalBottomSheet<QuestionType>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => QuestionTypeDialog(examId: exam.id, parentId: parentId),
    );
    if (type == null || !context.mounted) return;

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => QuestionEditorSheet(type: type, examId: exam.id, parentId: parentId, initialOrder: initialOrder),
    );
    if (saved == true && context.mounted) await provider.reloadQuestions();
  }

  Future<void> _editQuestion(BuildContext context, Question question) async {
    final provider = context.read<ExamProvider>();
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => QuestionEditorSheet(
        type: question.type,
        questionId: question.id,
        examId: question.examId ?? provider.currentExam!.id,
        parentId: question.parentId,
        initialOrder: question.order,
      ),
    );
    if (saved == true && context.mounted) await provider.reloadQuestions();
  }

  Future<void> _duplicateQuestion(BuildContext context, Question question) async {
    final provider = context.read<ExamProvider>();
    final copy = await provider.duplicateQuestion(question.id);
    if (copy == null || !context.mounted) return;

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => QuestionEditorSheet(
        type: copy.type,
        questionId: copy.id,
        examId: copy.examId ?? provider.currentExam!.id,
        parentId: copy.parentId,
        initialOrder: copy.order,
      ),
    );
    if (saved == true && context.mounted) await provider.reloadQuestions();
  }

  Future<void> _editSection(BuildContext context, Question section) async {
    final titleController = TextEditingController(text: section.content);
    final instructionsController = TextEditingController(text: section.instructions ?? '');
    final result = await showDialog<(String, String?)>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('تعديل القسم'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: titleController, autofocus: true, decoration: const InputDecoration(labelText: 'اسم القسم')),
          const SizedBox(height: 12),
          TextField(controller: instructionsController, maxLines: 2, decoration: const InputDecoration(labelText: 'تعليمات القسم (اختياري)')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('إلغاء')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, (titleController.text.trim(), instructionsController.text.trim().isEmpty ? null : instructionsController.text.trim())), child: const Text('حفظ')),
        ],
      ),
    );
    titleController.dispose();
    instructionsController.dispose();
    if (result == null || result.$1.isEmpty || !context.mounted) return;
    final provider = context.read<ExamProvider>();
    await provider.addQuestion(section.copyWith(content: result.$1, instructions: result.$2, updatedAt: DateTime.now()));
  }

  Future<void> _deleteQuestion(BuildContext context, Question question) async {
    final provider = context.read<ExamProvider>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف السؤال؟'),
        content: question.type == QuestionType.groupHeader
            ? const Text('سيتم حذف القسم وجميع الأسئلة المرتبطة به.')
            : const Text('سيتم حذف السؤال من الاختبار.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('إلغاء')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('حذف')),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await provider.deleteQuestion(question.id);
  }

  Future<void> _addSection(BuildContext context) async {
    final titleController = TextEditingController();
    final instructionsController = TextEditingController();
    final result = await showDialog<(String, String?)>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('إضافة قسم'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: titleController, autofocus: true, decoration: const InputDecoration(labelText: 'اسم القسم', hintText: 'مثال: اختر الإجابة الصحيحة')),
          const SizedBox(height: 12),
          TextField(controller: instructionsController, maxLines: 2, decoration: const InputDecoration(labelText: 'تعليمات القسم (اختياري)')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('إلغاء')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, (titleController.text.trim(), instructionsController.text.trim().isEmpty ? null : instructionsController.text.trim())), child: const Text('إضافة القسم')),
        ],
      ),
    );
    titleController.dispose();
    instructionsController.dispose();
    if (result == null || result.$1.isEmpty || !context.mounted) return;
    await context.read<ExamProvider>().addSection(title: result.$1, instructions: result.$2);
  }

  List<_CanvasGroup> _groupQuestions(List<Question> questions) {
    final groups = <_CanvasGroup>[];
    final consumed = <String>{};
    var questionNumber = 0;

    for (final question in questions) {
      if (consumed.contains(question.id)) continue;
      if (question.type == QuestionType.groupHeader) {
        final children = questions.where((q) => q.parentId == question.id && q.type != QuestionType.groupHeader).toList();
        consumed..add(question.id)..addAll(children.map((q) => q.id));
        groups.add(_CanvasGroup(section: question, questions: children, baseNumber: questionNumber + 1));
        questionNumber += children.length;
      } else if (question.parentId == null) {
        consumed.add(question.id);
        questionNumber += 1;
        groups.add(_CanvasGroup(standalone: question, baseNumber: questionNumber));
      }
    }

    for (final question in questions) {
      if (!consumed.contains(question.id)) {
        consumed.add(question.id);
        questionNumber += 1;
        groups.add(_CanvasGroup(standalone: question, baseNumber: questionNumber));
      }
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExamProvider>();
    final exam = provider.currentExam;
    if (exam == null) return const SizedBox.shrink();

    final questions = provider.currentQuestions;
    final groups = _groupQuestions(questions);
    final totalMarks = questions.fold<double>(0, (sum, q) => sum + q.marks);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 110),
      children: [
        AppCard(
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(exam.title.isEmpty ? 'اختبار جديد' : exam.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('${questions.where((q) => q.type != QuestionType.groupHeader).length} سؤال  •  ${totalMarks.toStringAsFixed(totalMarks % 1 == 0 ? 0 : 1)} درجة  •  ${exam.duration} دقيقة'),
            ])),
            FilledButton.icon(onPressed: () => _addQuestion(context), icon: const Icon(Icons.add), label: const Text('إضافة سؤال')),
          ]),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (groups.isEmpty)
          AppCard(child: Padding(padding: const EdgeInsets.all(AppSpacing.xl), child: Column(children: [
            Icon(Icons.note_add_outlined, size: 52, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: AppSpacing.md),
            Text('ابدأ بأول سؤال', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('اكتب السؤال وحدد الإجابة والدرجة، ثم انتقل مباشرة للسؤال التالي.'),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(onPressed: () => _addQuestion(context), icon: const Icon(Icons.add), label: const Text('إضافة أول سؤال')),
          ])))
        else
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            itemCount: groups.length,
            onReorder: (oldIndex, newIndex) async {
              if (newIndex > oldIndex) newIndex -= 1;
              final reordered = List<_CanvasGroup>.from(groups);
              final moved = reordered.removeAt(oldIndex);
              reordered.insert(newIndex, moved);
              final ids = <String>[];
              for (final group in reordered) {
                if (group.section != null) ids.add(group.section!.id);
                ids.addAll(group.questions.map((q) => q.id));
                if (group.standalone != null) ids.add(group.standalone!.id);
              }
              await provider.reorderQuestionsByIds(ids);
            },
            itemBuilder: (context, index) {
              final group = groups[index];
              return Container(
                key: ValueKey(group.key),
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _CanvasGroupView(
                  group: group,
                  itemIndex: index,
                  onEdit: _editQuestion,
                  onEditSection: _editSection,
                  onDuplicate: _duplicateQuestion,
                  onDelete: _deleteQuestion,
                  onAddInSection: group.section == null ? null : () => _addQuestion(context, parentId: group.section!.id),
                ),
              );
            },
          ),
        const SizedBox(height: AppSpacing.md),
        Row(children: [
          Expanded(child: OutlinedButton.icon(onPressed: () => _addSection(context), icon: const Icon(Icons.segment), label: const Text('إضافة قسم'))),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: FilledButton.icon(onPressed: () => _addQuestion(context), icon: const Icon(Icons.add), label: const Text('إضافة سؤال'))),
        ]),
      ],
    );
  }
}

class _CanvasGroup {
  final Question? section;
  final List<Question> questions;
  final Question? standalone;
  final int baseNumber;
  _CanvasGroup({this.section, this.questions = const [], this.standalone, required this.baseNumber});
  String get key => section?.id ?? standalone!.id;
}

class _CanvasGroupView extends StatelessWidget {
  final _CanvasGroup group;
  final int itemIndex;
  final Future<void> Function(BuildContext, Question) onEdit;
  final Future<void> Function(BuildContext, Question) onEditSection;
  final Future<void> Function(BuildContext, Question) onDuplicate;
  final Future<void> Function(BuildContext, Question) onDelete;
  final VoidCallback? onAddInSection;

  const _CanvasGroupView({required this.group, required this.itemIndex, required this.onEdit, required this.onEditSection, required this.onDuplicate, required this.onDelete, this.onAddInSection});

  @override
  Widget build(BuildContext context) {
    if (group.section != null) {
      return Card(child: Padding(padding: const EdgeInsets.all(AppSpacing.md), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          ReorderableDragStartListener(index: itemIndex, child: const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.drag_indicator))),
          const SizedBox(width: 6),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('قسم', style: Theme.of(context).textTheme.labelMedium),
            Text(group.section!.content, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            if (group.section!.instructions != null) Text(group.section!.instructions!, style: Theme.of(context).textTheme.bodySmall),
          ])),
          IconButton(onPressed: () => onEditSection(context, group.section!), icon: const Icon(Icons.edit_outlined), tooltip: 'تعديل القسم'),
          IconButton(onPressed: () => onDelete(context, group.section!), icon: const Icon(Icons.delete_outline), tooltip: 'حذف القسم'),
        ]),
        if (group.questions.isNotEmpty) const Divider(),
        for (var i = 0; i < group.questions.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: QuestionCard(
              question: group.questions[i],
              index: group.baseNumber + i - 1,
              onEdit: () => onEdit(context, group.questions[i]),
              onDuplicate: () => onDuplicate(context, group.questions[i]),
              onDelete: () => onDelete(context, group.questions[i]),
              onAddNext: onAddInSection,
            ),
          ),
        Align(alignment: AlignmentDirectional.centerStart, child: TextButton.icon(onPressed: onAddInSection, icon: const Icon(Icons.add), label: const Text('إضافة سؤال في هذا القسم'))),
      ])));
    }

    return QuestionCard(
      question: group.standalone!,
      index: group.baseNumber - 1,
      dragIndex: itemIndex,
      showDragHandle: true,
      onEdit: () => onEdit(context, group.standalone!),
      onDuplicate: () => onDuplicate(context, group.standalone!),
      onDelete: () => onDelete(context, group.standalone!),
    );
  }
}
