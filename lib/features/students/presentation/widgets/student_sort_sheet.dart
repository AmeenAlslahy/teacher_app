import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../providers/student_provider.dart';

class StudentSortSheet extends StatelessWidget {
  const StudentSortSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, provider, _) {
        return Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ترتيب الطلاب',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildSortOption(
                context,
                title: 'الاسم',
                icon: Icons.sort_by_alpha,
                isSelected: provider.sortBy == StudentSortBy.name,
                onTap: () {
                  provider.setSortBy(StudentSortBy.name);
                  Navigator.pop(context);
                },
              ),
              _buildSortOption(
                context,
                title: 'الرقم المدرسي',
                icon: Icons.numbers,
                isSelected: provider.sortBy == StudentSortBy.number,
                onTap: () {
                  provider.setSortBy(StudentSortBy.number);
                  Navigator.pop(context);
                },
              ),
              _buildSortOption(
                context,
                title: 'الصف',
                icon: Icons.class_,
                isSelected: provider.sortBy == StudentSortBy.className,
                onTap: () {
                  provider.setSortBy(StudentSortBy.className);
                  Navigator.pop(context);
                },
              ),
              _buildSortOption(
                context,
                title: 'تاريخ الإضافة',
                icon: Icons.calendar_today,
                isSelected: provider.sortBy == StudentSortBy.dateAdded,
                onTap: () {
                  provider.setSortBy(StudentSortBy.dateAdded);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Icon(
                    provider.sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    provider.sortAscending ? 'ترتيب تصاعدي' : 'ترتيب تنازلي',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildSortOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : null,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}
