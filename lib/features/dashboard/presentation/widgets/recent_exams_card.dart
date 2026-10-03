import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/dashboard_data.dart';

class RecentExamsCard extends StatelessWidget {
  final List<RecentExam> exams;
  
  const RecentExamsCard({super.key, required this.exams});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'آخر الاختبارات',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: exams.map((exam) {
              return ListTile(
                leading: Icon(
                  Icons.check_circle,
                  color: exam.averageScore >= 70 ? Colors.green : Colors.orange,
                ),
                title: Text(exam.title),
                subtitle: Text(
                  exam.subject,
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${exam.averageScore.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: exam.averageScore >= 70 ? Colors.green : Colors.orange,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(exam.date),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                onTap: () {
                  // Navigate to exam results
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
