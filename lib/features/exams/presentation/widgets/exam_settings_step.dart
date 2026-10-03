import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/exam.dart';
import '../../providers/exam_provider.dart';

class ExamSettingsStep extends StatelessWidget {
  final VoidCallback onNext;
  
  const ExamSettingsStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExamProvider>();
    final exam = provider.currentExam;
    
    if (exam == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ExamTitleField(
          initialValue: exam.title,
          onChanged: (value) {
            provider.updateExamInfo(exam.copyWith(title: value));
          },
        ),
        const SizedBox(height: 16),
        
        Text('نوع الاختبار', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ExamType.values.map((type) {
            return ChoiceChip(
              label: Text(type.label),
              selected: exam.type == type,
              onSelected: (selected) {
                if (selected) {
                  provider.updateExamInfo(exam.copyWith(type: type));
                }
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: exam.examDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    provider.updateExamInfo(exam.copyWith(examDate: date));
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'التاريخ',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('dd/MM/yyyy').format(exam.examDate)),
                      const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppTextField(
                label: 'المدة (دقيقة)',
                initialValue: exam.duration.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  provider.updateExamInfo(
                    exam.copyWith(duration: int.tryParse(value) ?? exam.duration),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppTextField(
          label: 'تعليمات الاختبار',
          initialValue: exam.instructions ?? '',
          isMultiline: true,
          maxLines: 3,
          onChanged: (value) {
            provider.updateExamInfo(
              exam.copyWith(instructions: value.isEmpty ? null : value),
            );
          },
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: AppButton(
            text: 'التالي: إضافة الأسئلة',
            icon: Icons.arrow_forward,
            onPressed: onNext,
          ),
        ),
      ],
    );
  }
}

class _ExamTitleField extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _ExamTitleField({required this.initialValue, required this.onChanged});

  @override
  State<_ExamTitleField> createState() => _ExamTitleFieldState();
}

class _ExamTitleFieldState extends State<_ExamTitleField> {
  late String _selectedOption;
  
  static const List<String> _predefinedOptions = [
    'اختبار الشهر الأول',
    'اختبار الشهر الثاني',
    'اختبار منتصف الفصل',
    'اختبار نهاية الفصل',
    'اختبار قصير',
    'اختبار تجريبي',
  ];

  @override
  void initState() {
    super.initState();
    if (_predefinedOptions.contains(widget.initialValue)) {
      _selectedOption = widget.initialValue;
    } else {
      _selectedOption = 'مخصص';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('عنوان الاختبار', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedOption,
              isExpanded: true,
              items: [
                ..._predefinedOptions.map((opt) => DropdownMenuItem(value: opt, child: Text(opt))),
                const DropdownMenuItem(value: 'مخصص', child: Text('مخصص (كتابة يدوية)')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedOption = value;
                    if (value != 'مخصص') {
                      widget.onChanged(value);
                    } else {
                      // If switched to custom, preserve whatever they had or empty
                      widget.onChanged(widget.initialValue.isNotEmpty && !_predefinedOptions.contains(widget.initialValue) ? widget.initialValue : '');
                    }
                  });
                }
              },
            ),
          ),
        ),
        if (_selectedOption == 'مخصص') ...[
          const SizedBox(height: 12),
          AppTextField(
            label: 'عنوان مخصص',
            initialValue: !_predefinedOptions.contains(widget.initialValue) ? widget.initialValue : '',
            hint: 'مثال: الوحدة الأولى، اختبار تقييمي...',
            isRequired: true,
            onChanged: widget.onChanged,
          ),
        ]
      ],
    );
  }
}
