import 'package:flutter/material.dart';

class StatisticsRow extends StatelessWidget {
  final int totalStudents;
  final int totalExams;
  final int totalAssignments;
  final double averageGrade;
  
  const StatisticsRow({
    super.key,
    required this.totalStudents,
    required this.totalExams,
    required this.totalAssignments,
    required this.averageGrade,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate dynamic width for Wrap children
        final double itemWidth = constraints.maxWidth < 400 
            ? (constraints.maxWidth / 2) - 6 // 2 items per row on very small screens
            : (constraints.maxWidth / 4) - 9; // 4 items per row on larger screens

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: itemWidth,
              child: _StatisticCard(
                label: 'الطلاب',
                value: totalStudents.toString(),
                icon: Icons.people,
                color: colorScheme.primary,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _StatisticCard(
                label: 'الاختبارات',
                value: totalExams.toString(),
                icon: Icons.assignment,
                color: colorScheme.secondary,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _StatisticCard(
                label: 'الواجبات',
                value: totalAssignments.toString(),
                icon: Icons.book,
                color: colorScheme.tertiary,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _StatisticCard(
                label: 'المتوسط',
                value: averageGrade.toStringAsFixed(1),
                icon: Icons.trending_up,
                color: colorScheme.error,
              ),
            ),
          ],
        );
      }
    );
  }
}

class _StatisticCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  
  const _StatisticCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
