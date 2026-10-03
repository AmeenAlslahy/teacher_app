import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../providers/student_provider.dart';

class StudentFilterSheet extends StatefulWidget {
  const StudentFilterSheet({super.key});

  @override
  State<StudentFilterSheet> createState() => _StudentFilterSheetState();
}

class _StudentFilterSheetState extends State<StudentFilterSheet> {
  String? _selectedClassId;
  String? _selectedSectionId;
  
  @override
  void initState() {
    super.initState();
    final provider = context.read<StudentProvider>();
    _selectedClassId = provider.selectedClassId;
    _selectedSectionId = provider.selectedSectionId;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
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
                  'تصفية الطلاب',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.lg),
                DropdownButtonFormField<String>(
                  initialValue: _selectedClassId,
                  decoration: InputDecoration(
                    labelText: 'الصف',
                    prefixIcon: const Icon(Icons.class_),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('جميع الصفوف'),
                    ),
                    ...provider.classes.map((c) {
                      return DropdownMenuItem(
                        value: c.id,
                        child: Text(c.name),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedClassId = value;
                      _selectedSectionId = null;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<String>(
                  initialValue: _selectedSectionId,
                  decoration: InputDecoration(
                    labelText: 'الشعبة',
                    prefixIcon: const Icon(Icons.group),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('جميع الشعب'),
                    ),
                    ...provider.sections
                        .where((s) => _selectedClassId == null || s.classId == _selectedClassId)
                        .map((s) {
                      return DropdownMenuItem(
                        value: s.id,
                        child: Text(s.name),
                      );
                    }),
                  ],
                  onChanged: _selectedClassId != null
                      ? (value) {
                          setState(() {
                            _selectedSectionId = value;
                          });
                        }
                      : null,
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
                        onPressed: () {
                          provider.setClassFilter(_selectedClassId);
                          provider.setSectionFilter(_selectedSectionId);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
