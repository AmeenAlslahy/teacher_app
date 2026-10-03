// lib/features/exams/presentation/widgets/exam_filter_sheet.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../providers/exam_provider.dart';
import '../../domain/entities/exam.dart';

class ExamFilterSheet extends StatelessWidget {
  const ExamFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamProvider>(
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
                'تصفية الاختبارات',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              DropdownButtonFormField<ExamType>(
                initialValue: provider.selectedType,
                decoration: InputDecoration(
                  labelText: 'نوع الاختبار',
                  prefixIcon: const Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('جميع الأنواع'),
                  ),
                  ...ExamType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.label),
                    );
                  }),
                ],
                onChanged: (value) {
                  provider.setTypeFilter(value);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<ExamStatus>(
                initialValue: provider.selectedStatus,
                decoration: InputDecoration(
                  labelText: 'الحالة',
                  prefixIcon: const Icon(Icons.flag),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('جميع الحالات'),
                  ),
                  ...ExamStatus.values.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status.label),
                    );
                  }),
                ],
                onChanged: (value) {
                  provider.setStatusFilter(value);
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'مسح الفلاتر',
                      type: AppButtonType.outline,
                      onPressed: () {
                        provider.clearAllFilters();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: AppButton(
                      text: 'تطبيق',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
