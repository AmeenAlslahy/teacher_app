import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/exam.dart';
import '../../providers/exam_provider.dart';

class ExamSetupPage extends StatefulWidget {
  final VoidCallback onContinue;

  const ExamSetupPage({super.key, required this.onContinue});

  @override
  State<ExamSetupPage> createState() => _ExamSetupPageState();
}

class _ExamSetupPageState extends State<ExamSetupPage> {
  late final TextEditingController _title;
  late final TextEditingController _duration;
  late final TextEditingController _instructions;

  @override
  void initState() {
    super.initState();
    final exam = context.read<ExamProvider>().currentExam;
    _title = TextEditingController(text: exam?.title ?? '');
    _duration = TextEditingController(text: '${exam?.duration ?? 45}');
    _instructions = TextEditingController(text: exam?.instructions ?? '');
  }

  void _sync(Exam exam) {
    context.read<ExamProvider>().updateExamInfo(exam);
  }

  @override
  void dispose() {
    _title.dispose();
    _duration.dispose();
    _instructions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExamProvider>();
    final exam = provider.currentExam;
    if (exam == null) return const SizedBox.shrink();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ابدأ بمعلومات بسيطة، ويمكنك تعديلها لاحقًا.', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  label: 'عنوان الاختبار',
                  controller: _title,
                  isRequired: true,
                  hint: 'مثال: اختبار العلوم الشهري',
                  onChanged: (value) => _sync(exam.copyWith(title: value)),
                ),
                const SizedBox(height: AppSpacing.md),
                Text('نوع الاختبار', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: ExamType.values.map((type) {
                    return ChoiceChip(
                      label: Text(type.label),
                      selected: exam.type == type,
                      onSelected: (_) => _sync(exam.copyWith(type: type)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final selected = await showDatePicker(
                            context: context,
                            initialDate: exam.examDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (selected != null && mounted) {
                            _sync(exam.copyWith(examDate: selected));
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'التاريخ',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(DateFormat('dd/MM/yyyy').format(exam.examDate)),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppTextField(
                        label: 'المدة (دقيقة)',
                        controller: _duration,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final duration = int.tryParse(value);
                          if (duration != null && duration > 0) {
                            _sync(exam.copyWith(duration: duration));
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  label: 'تعليمات الاختبار (اختياري)',
                  controller: _instructions,
                  isMultiline: true,
                  maxLines: 3,
                  onChanged: (value) => _sync(exam.copyWith(instructions: value.trim().isEmpty ? null : value)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: 'ابدأ إضافة الأسئلة',
              icon: Icons.arrow_forward,
              type: AppButtonType.primary,
              isLoading: provider.isSaving,
              onPressed: provider.isSaving ? null : widget.onContinue,
            ),
          ),
        ],
      ),
    );
  }
}
