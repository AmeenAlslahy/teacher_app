import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GreetingHeader extends StatelessWidget {
  final String teacherName;
  final DateTime date;
  
  const GreetingHeader({
    super.key,
    required this.teacherName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    String greeting;
    
    if (hour < 12) {
      greeting = 'صباح الخير';
    } else if (hour < 17) {
      greeting = 'مساء الخير';
    } else {
      greeting = 'مساء النور';
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting،',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 4),
        Text(
          teacherName,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          DateFormat.yMMMMEEEEd('ar').format(date),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
