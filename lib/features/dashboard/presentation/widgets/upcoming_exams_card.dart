import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/dashboard_data.dart';

class UpcomingExamsCard extends StatelessWidget {
  final List<UpcomingExam> exams;
  
  const UpcomingExamsCard({super.key, required this.exams});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الاختبارات القادمة',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all exams
              },
              child: const Text('عرض الكل'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: exams.map((exam) {
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.assignment,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  exam.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: Text(
                  '${exam.subject} • ${exam.type}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('dd/MM').format(exam.date),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      '${exam.duration} دقيقة',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Navigate to exam details
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
