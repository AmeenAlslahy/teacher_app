import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/exam.dart';
import '../../domain/entities/question_content.dart';
import '../../providers/question_editor_provider.dart';
import 'chemistry_editor.dart';
import 'math_equation_editor.dart';

class QuestionEditorSheet extends StatelessWidget {
  final QuestionType type;
  final String examId;
  final String? questionId;
  final String? parentId;
  final int initialOrder;

  const QuestionEditorSheet({
    super.key,
    required this.type,
    required this.examId,
    this.questionId,
    this.parentId,
    this.initialOrder = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuestionEditorProvider(
        type: type,
        questionId: questionId,
        examId: examId,
        parentId: parentId,
        initialOrder: initialOrder,
        saveQuestionUseCase: getIt(),
        getQuestionByIdUseCase: getIt(),
      ),
      child: _QuestionEditorSheetView(isNew: questionId == null),
    );
  }
}

class _QuestionEditorSheetView extends StatelessWidget {
  final bool isNew;
  const _QuestionEditorSheetView({required this.isNew});

  Future<void> _save(BuildContext context, {required bool addNext}) async {
    final provider = context.read<QuestionEditorProvider>();
    final success = await provider.saveQuestion();
    if (!context.mounted) return;
    if (!success) return;

    if (addNext) {
      provider.resetForNextQuestion(nextOrder: provider.order + 1);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حفظ السؤال. اكتب السؤال التالي.')));
    } else {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionEditorProvider>();
    if (provider.isLoading) {
      return const SizedBox(
          height: 420, child: Center(child: CircularProgressIndicator()));
    }

    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.96,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                      child: Text(isNew ? 'إضافة سؤال' : 'تعديل السؤال',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold))),
                  Chip(label: Text(provider.type.label)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                children: [
                  _buildQuestionField(context, provider),
                  const SizedBox(height: AppSpacing.md),
                  if (provider.type == QuestionType.multipleChoice)
                    _McqEditor(provider: provider),
                  if (provider.type == QuestionType.trueFalse)
                    _TrueFalseEditor(provider: provider),
                  if (provider.type == QuestionType.shortAnswer)
                    _ShortAnswerEditor(provider: provider),
                  if (provider.type == QuestionType.essay)
                    _EssayEditor(provider: provider),
                  const SizedBox(height: AppSpacing.md),
                  _MarksRow(provider: provider),
                  const SizedBox(height: AppSpacing.sm),
                  _AdditionalOptions(provider: provider),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            _BottomActions(
                isNew: isNew,
                onSave: () => _save(context, addNext: false),
                onSaveAndNew: () => _save(context, addNext: true)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionField(
      BuildContext context, QuestionEditorProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'نص السؤال',
          controller: provider.contentController,
          isRequired: true,
          isMultiline: true,
          maxLines: 6,
          hint: 'اكتب السؤال هنا...',
        ),
        const SizedBox(height: 8),
        _ContentTools(provider: provider),
        if (provider.error != null) ...[
          const SizedBox(height: 8),
          Text(provider.error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error)),
        ],
      ],
    );
  }
}

class _McqEditor extends StatelessWidget {
  final QuestionEditorProvider provider;
  const _McqEditor({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('الإجابات',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('حدد الإجابة الصحيحة من الدائرة بجانب الخيار.'),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < provider.optionControllers.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => provider.toggleOptionCorrect(i),
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        provider.optionCorrectness[i]
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: provider.optionCorrectness[i]
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                      child: AppTextField(
                          label: 'الخيار ${i + 1}',
                          controller: provider.optionControllers[i])),
                  IconButton(
                      onPressed: provider.optionControllers.length > 2
                          ? () => provider.removeOption(i)
                          : null,
                      icon: const Icon(Icons.close),
                      tooltip: 'حذف الخيار'),
                ],
              ),
            ),
          OutlinedButton.icon(
              onPressed: provider.addOption,
              icon: const Icon(Icons.add),
              label: const Text('إضافة خيار')),
        ]),
      ),
    );
  }
}

class _TrueFalseEditor extends StatelessWidget {
  final QuestionEditorProvider provider;
  const _TrueFalseEditor({required this.provider});

  @override
  Widget build(BuildContext context) {
    final value = provider.correctAnswer;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('الإجابة الصحيحة',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.sm),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                  value: 'true', label: Text('صح'), icon: Icon(Icons.check)),
              ButtonSegment(
                  value: 'false', label: Text('خطأ'), icon: Icon(Icons.close)),
            ],
            selected: value == null ? <String>{} : <String>{value},
            onSelectionChanged: (selected) =>
                provider.setCorrectAnswer(selected.first),
          ),
        ]),
      ),
    );
  }
}

class _ShortAnswerEditor extends StatelessWidget {
  final QuestionEditorProvider provider;
  const _ShortAnswerEditor({required this.provider});
  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: AppTextField(
              label: 'الإجابة المقبولة',
              isRequired: true,
              isMultiline: true,
              maxLines: 2,
              onChanged: provider.setCorrectAnswer)));
}

class _EssayEditor extends StatelessWidget {
  final QuestionEditorProvider provider;
  const _EssayEditor({required this.provider});
  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
              'هذا سؤال مقالي؛ لا تتطلب منه إجابة نموذجية أثناء إنشاء الاختبار.',
              style: Theme.of(context).textTheme.bodyMedium)));
}

class _MarksRow extends StatelessWidget {
  final QuestionEditorProvider provider;
  const _MarksRow({required this.provider});
  @override
  Widget build(BuildContext context) => Row(children: [
        Expanded(
            child: AppTextField(
                label: 'الدرجة',
                controller: provider.marksController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true))),
        const SizedBox(width: AppSpacing.md),
        Expanded(
            child: AppDropdown<Difficulty>(
                label: 'الصعوبة',
                value: provider.difficulty,
                items: Difficulty.values
                    .map(
                        (d) => DropdownMenuItem(value: d, child: Text(d.label)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) provider.setDifficulty(value);
                }))
      ]);
}

class _AdditionalOptions extends StatelessWidget {
  final QuestionEditorProvider provider;
  const _AdditionalOptions({required this.provider});
  @override
  Widget build(BuildContext context) =>
      ExpansionTile(title: const Text('خيارات إضافية'), children: [
        Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: AppTextField(
                label: 'شرح الإجابة (اختياري)',
                controller: provider.explanationController,
                isMultiline: true,
                maxLines: 3)),
        Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: AppTextField(
                label: 'تعليمات خاصة بالسؤال (اختياري)',
                controller: provider.instructionsController,
                isMultiline: true,
                maxLines: 2))
      ]);
}

class _ContentTools extends StatelessWidget {
  final QuestionEditorProvider provider;
  const _ContentTools({required this.provider});
  @override
  Widget build(BuildContext context) => Wrap(spacing: 8, children: [
        TextButton.icon(
            onPressed: () => _math(context),
            icon: const Icon(Icons.functions),
            label: const Text('معادلة')),
        TextButton.icon(
            onPressed: () => _chemistry(context),
            icon: const Icon(Icons.science_outlined),
            label: const Text('كيمياء')),
      ]);
  void _math(BuildContext context) => showDialog<void>(
      context: context,
      builder: (_) => MathEquationEditor(onSave: (value) {
            provider.insertInlineBlock(ContentBlockType.math, value);
          }));
  void _chemistry(BuildContext context) => showDialog<void>(
      context: context,
      builder: (_) => ChemistryEditor(onSave: (value) {
            provider.insertInlineBlock(ContentBlockType.chemistry, value);
          }));
}

class _BottomActions extends StatelessWidget {
  final bool isNew;
  final VoidCallback onSave;
  final VoidCallback onSaveAndNew;
  const _BottomActions(
      {required this.isNew, required this.onSave, required this.onSaveAndNew});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionEditorProvider>();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .shadow
                    .withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, -2))
          ]),
      child: SafeArea(
        child: Row(children: [
          Expanded(
              child: OutlinedButton(
                  onPressed:
                      provider.isSaving ? null : () => Navigator.pop(context),
                  child: const Text('إلغاء'))),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
              child: AppButton(
                  text: 'حفظ',
                  type: AppButtonType.outline,
                  isLoading: provider.isSaving,
                  onPressed: provider.isSaving ? null : onSave)),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
              flex: 2,
              child: AppButton(
                  text: 'حفظ وإضافة سؤال جديد',
                  icon: Icons.add_task,
                  type: AppButtonType.primary,
                  isLoading: provider.isSaving,
                  onPressed:
                      provider.isSaving || !isNew ? null : onSaveAndNew)),
        ]),
      ),
    );
  }
}
