import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/exam.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;
  final VoidCallback? onAddNext;
  final bool showDragHandle;
  final int? dragIndex;

  const QuestionCard({
    super.key,
    required this.question,
    required this.index,
    required this.onEdit,
    required this.onDuplicate,
    required this.onDelete,
    this.onAddNext,
    this.showDragHandle = false,
    this.dragIndex,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (showDragHandle)
                    ReorderableDragStartListener(
                      index: dragIndex ?? index,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                        child: Icon(Icons.drag_indicator, color: scheme.onSurfaceVariant),
                      ),
                    ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: scheme.primaryContainer,
                    child: Text('${index + 1}', style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(question.type.label, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: scheme.onSurfaceVariant)),
                  ),
                  Text('${_formatMarks(question.marks)} درجة', style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                  PopupMenuButton<String>(
                    tooltip: 'خيارات السؤال',
                    onSelected: (value) {
                      switch (value) {
                        case 'edit': onEdit(); break;
                        case 'duplicate': onDuplicate(); break;
                        case 'delete': onDelete(); break;
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'edit', child: Text('تعديل')),
                      PopupMenuItem(value: 'duplicate', child: Text('نسخ')),
                      PopupMenuItem(value: 'delete', child: Text('حذف')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                question.content.isEmpty ? 'سؤال غير مكتمل' : question.content.replaceAll(RegExp(r'\[\[.*?\]\]'), '').trim(),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (question.options.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                ...question.options.map((option) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(
                        option.isCorrect ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        size: 18,
                        color: option.isCorrect ? scheme.primary : scheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(option.content, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                )),
              ],
              if (question.correctAnswer != null && question.options.isEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text('الإجابة: ${question.correctAnswer == 'true' ? 'صح' : question.correctAnswer == 'false' ? 'خطأ' : question.correctAnswer}', style: Theme.of(context).textTheme.bodyMedium),
              ],
              if (onAddNext != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton.icon(onPressed: onAddNext, icon: const Icon(Icons.add, size: 18), label: const Text('إضافة سؤال بعده')),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatMarks(double marks) => marks % 1 == 0 ? marks.toInt().toString() : marks.toStringAsFixed(1);
}
