import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/exam.dart';
import '../../../../core/theme/app_spacing.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback onTap;
  final VoidCallback onPreview;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;
  
  const ExamCard({
    super.key,
    required this.exam,
    required this.onTap,
    required this.onPreview,
    required this.onDuplicate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getStatusColor(exam.status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getStatusIcon(exam.status),
                      color: _getStatusColor(exam.status),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exam.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${exam.type.label} • ${exam.duration} دقيقة',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'preview',
                        child: Row(
                          children: [
                            Icon(Icons.visibility, size: 20),
                            SizedBox(width: 8),
                            Text('معاينة'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'duplicate',
                        child: Row(
                          children: [
                            Icon(Icons.copy, size: 20),
                            SizedBox(width: 8),
                            Text('نسخ'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Theme.of(context).colorScheme.error),
                            const SizedBox(width: 8),
                            Text('حذف', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'preview') onPreview();
                      if (value == 'duplicate') onDuplicate();
                      if (value == 'delete') onDelete();
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('dd/MM/yyyy').format(exam.examDate),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Icon(Icons.grade, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    '${exam.totalMarks} درجة',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Color _getStatusColor(ExamStatus status) {
    switch (status) {
      case ExamStatus.draft:
        return Colors.grey;
      case ExamStatus.ready:
        return Colors.blue;
      case ExamStatus.published:
        return Colors.green;
      case ExamStatus.archived:
        return Colors.orange;
    }
  }
  
  IconData _getStatusIcon(ExamStatus status) {
    switch (status) {
      case ExamStatus.draft:
        return Icons.edit;
      case ExamStatus.ready:
        return Icons.check_circle;
      case ExamStatus.published:
        return Icons.publish;
      case ExamStatus.archived:
        return Icons.archive;
    }
  }
}
