import 'package:flutter/material.dart';

class QuickActionGrid extends StatelessWidget {
  final VoidCallback onExamCreate;
  final VoidCallback onStudents;
  final VoidCallback onGrades;
  final VoidCallback onAssignments;
  
  const QuickActionGrid({
    super.key,
    required this.onExamCreate,
    required this.onStudents,
    required this.onGrades,
    required this.onAssignments,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 4;
        if (constraints.maxWidth < 360) {
          crossAxisCount = 2; // Small phones
        } else if (constraints.maxWidth < 600) {
          crossAxisCount = 4; // Regular phones can handle 4 if text is small, but let's make it more responsive. Actually 2x2 is better for regular phones if padding is tight.
        }
        
        // Let's refine crossAxisCount based on optimal width: ~80-100px per item
        crossAxisCount = (constraints.maxWidth / 90).floor().clamp(2, 4);

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.95,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _QuickActionItem(
              icon: Icons.add_circle_outline,
              label: 'اختبار جديد',
              color: colorScheme.primary,
              onTap: onExamCreate,
            ),
            _QuickActionItem(
              icon: Icons.people_outline,
              label: 'الطلاب',
              color: colorScheme.secondary,
              onTap: onStudents,
            ),
            _QuickActionItem(
              icon: Icons.grade_outlined,
              label: 'الدرجات',
              color: colorScheme.tertiary,
              onTap: onGrades,
            ),
            _QuickActionItem(
              icon: Icons.assignment_outlined,
              label: 'الواجبات',
              color: colorScheme.error, // Just as a distinct color, or primary container
              onTap: onAssignments,
            ),
          ],
        );
      }
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  
  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
