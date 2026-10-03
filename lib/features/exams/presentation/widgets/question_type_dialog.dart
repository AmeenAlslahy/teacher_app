import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/exam.dart';

/// Types exposed by the first UX release. Other enum values remain in the
/// domain model until their dedicated editors are ready.
const supportedQuestionTypes = <QuestionType>[
  QuestionType.multipleChoice,
  QuestionType.trueFalse,
  QuestionType.shortAnswer,
  QuestionType.essay,
];

class QuestionTypeDialog extends StatelessWidget {
  final String examId;
  final String? parentId;

  const QuestionTypeDialog({super.key, required this.examId, this.parentId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('أضف سؤالًا', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('اختر نوع السؤال الذي تريد كتابته.', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: AppSpacing.lg),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 240,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: 2.7,
                ),
                itemCount: supportedQuestionTypes.length,
                itemBuilder: (context, index) {
                  final type = supportedQuestionTypes[index];
                  return _QuestionTypeButton(type: type, onTap: () => Navigator.pop(context, type));
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('أنواع إضافية ستتوفر مع محررات متخصصة لاحقًا.', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionTypeButton extends StatelessWidget {
  final QuestionType type;
  final VoidCallback onTap;

  const _QuestionTypeButton({required this.type, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
            Icon(_icon(type), color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(type.label, style: Theme.of(context).textTheme.titleSmall)),
            const Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
      ),
    );
  }

  IconData _icon(QuestionType type) {
    switch (type) {
      case QuestionType.multipleChoice: return Icons.radio_button_checked;
      case QuestionType.trueFalse: return Icons.check_circle_outline;
      case QuestionType.shortAnswer: return Icons.short_text;
      case QuestionType.essay: return Icons.article_outlined;
      default: return Icons.help_outline;
    }
  }
}
