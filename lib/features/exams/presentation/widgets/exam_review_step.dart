import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../context/providers/context_provider.dart';
import '../../domain/entities/exam_pdf_metadata.dart';
import '../../providers/exam_provider.dart';
import '../../domain/services/exam_pdf_service.dart';
import '../../../../core/utils/error_handler.dart';

class ExamReviewStep extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSave;

  const ExamReviewStep({
    super.key,
    required this.onBack,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExamProvider>();
    final exam = provider.currentExam;
    final questions = provider.currentQuestions;
    final totalMarks = provider.getTotalQuestionsMarks();
    
    final contextProvider = context.watch<ContextProvider>();

    final pdfMetadata = ExamPdfMetadata(
      schoolName: contextProvider.schoolName,
      educationAuthority: contextProvider.selectedSchool?.educationAuthority,
      schoolLogoPath: contextProvider.selectedSchool?.logo,
      academicYear: contextProvider.selectedSchool?.academicYear ?? '2024-2025',
      examTypeName: exam?.type.label ?? '',
      subjectName: contextProvider.subjectName,
      className: contextProvider.className,
      sectionName: contextProvider.sectionName.isEmpty
          ? null
          : contextProvider.sectionName,
    );

    if (exam == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary Card
        Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ملخص الاختبار',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                _buildSummaryRow(context, 'العنوان:', exam.title),
                _buildSummaryRow(context, 'النوع:', exam.type.label),
                _buildSummaryRow(context, 'الأسئلة:', '${questions.length} سؤال'),
                _buildSummaryRow(context, 'الدرجة الكلية:', '$totalMarks درجة'),
                _buildSummaryRow(context, 'المدة:', '${exam.duration} دقيقة'),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        
        // Export Actions
        Text(
          'خيارات التصدير والطباعة',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'تصدير PDF',
                icon: Icons.picture_as_pdf,
                type: AppButtonType.primary,
                onPressed: () async {
                  if (questions.isEmpty) {
                    AppSnackbar.show(context, message: 'لا يمكن تصدير اختبار بدون أسئلة', type: SnackbarType.warning);
                    return;
                  }
                  try {
                    await ExamPdfService.shareExamPdf(exam, questions, pdfMetadata);
                  } catch (e) {
                    if (context.mounted) {
                      AppSnackbar.show(context, message: ErrorHandler.format(e, 'فشل تصدير الملف'), type: SnackbarType.error);
                    }
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                text: 'طباعة مباشرة',
                icon: Icons.print,
                type: AppButtonType.outline,
                onPressed: () async {
                  if (questions.isEmpty) {
                    AppSnackbar.show(context, message: 'لا يمكن طباعة اختبار بدون أسئلة', type: SnackbarType.warning);
                    return;
                  }
                  try {
                    await ExamPdfService.printExam(exam, questions, pdfMetadata);
                  } catch (e) {
                    if (context.mounted) {
                      AppSnackbar.show(context, message: ErrorHandler.format(e, 'فشل الطباعة'), type: SnackbarType.error);
                    }
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        
        // Navigation
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'السابق',
                type: AppButtonType.outline,
                onPressed: onBack,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: AppButton(
                text: 'حفظ وإنهاء',
                icon: Icons.check_circle,
                type: AppButtonType.success,
                isLoading: provider.isSaving,
                onPressed: provider.isSaving ? null : onSave,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
