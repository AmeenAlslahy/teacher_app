// lib/features/exams/presentation/pages/exam_preview_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/app_loading.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../context/providers/context_provider.dart';
import '../../domain/entities/exam_pdf_metadata.dart';
import '../../domain/services/exam_pdf_service.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/exam.dart';
import '../../domain/usecases/get_exam_with_questions_use_case.dart';
import '../../../../core/utils/error_handler.dart';

class ExamPreviewPage extends StatelessWidget {
  final String examId;
  
  const ExamPreviewPage({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معاينة الاختبار'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'تصدير PDF',
            onPressed: () => _exportPdf(context),
          ),
          IconButton(
            icon: const Icon(Icons.print),
            tooltip: 'طباعة',
            onPressed: () => _print(context),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'مشاركة',
            onPressed: () => _share(context),
          ),
        ],
      ),
      body: FutureBuilder<ExamWithQuestions>(
        future: getIt<GetExamWithQuestionsUseCase>()(examId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading(message: 'جاري تحميل المعاينة...');
          }
          
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'فشل في تحميل الاختبار',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error?.toString() ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('العودة'),
                  ),
                ],
              ),
            );
          }
          
          if (!snapshot.hasData) {
            return const Center(child: Text('الاختبار غير موجود'));
          }
          
          final data = snapshot.data!;
          return _buildContent(context, data);
        },
      ),
    );
  }
  
  Widget _buildContent(BuildContext context, ExamWithQuestions data) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _buildExamHeader(context, data.exam),
        const SizedBox(height: AppSpacing.xl),
        ...data.questions.map((question) {
          return _buildQuestion(context, question);
        }),
      ],
    );
  }
  
  Widget _buildExamHeader(BuildContext context, Exam exam) {
    return Column(
      children: [
        Text(
          'بسم الله الرحمن الرحيم',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          exam.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          '${exam.type.label} • ${DateFormat('dd/MM/yyyy').format(exam.examDate)}',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'المدة: ${exam.duration} دقيقة • الدرجة: ${exam.totalMarks}',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        if (exam.instructions != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            'تعليمات: ${exam.instructions}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        const Divider(),
      ],
    );
  }
  
  Widget _buildQuestion(BuildContext context, Question question) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${question.order + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.content,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (question.instructions != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        question.instructions!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.md),
                    if (question.options.isNotEmpty)
                      ...question.options.map((option) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(option.content),
                          ],
                        ),
                      )),
                    if (question.type == QuestionType.trueFalse)
                      const Row(
                        children: [
                          Text('(   ) صح'),
                          SizedBox(width: AppSpacing.xl),
                          Text('(   ) خطأ'),
                        ],
                      ),
                    if (question.type == QuestionType.essay)
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '(${question.marks} درجة)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Future<void> _exportPdf(BuildContext context) async {
    final contextProvider = context.read<ContextProvider>();
    try {
      final data = await getIt<GetExamWithQuestionsUseCase>()(examId);

      final metadata = ExamPdfMetadata(
        schoolName: contextProvider.schoolName,
        educationAuthority: contextProvider.selectedSchool?.educationAuthority,
        schoolLogoPath: contextProvider.selectedSchool?.logo,
        academicYear:
            contextProvider.selectedSchool?.academicYear ?? '2024-2025',
        examTypeName: data.exam.type.label,
        subjectName: contextProvider.subjectName,
        className: contextProvider.className,
        sectionName: contextProvider.sectionName.isEmpty
            ? null
            : contextProvider.sectionName,
      );

      await ExamPdfService.shareExamPdf(data.exam, data.questions, metadata);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorHandler.format(e, 'فشل تصدير الملف'))),
      );
    }
  }
  
  Future<void> _print(BuildContext context) async {
    final contextProvider = context.read<ContextProvider>();
    try {
      final data = await getIt<GetExamWithQuestionsUseCase>()(examId);

      final metadata = ExamPdfMetadata(
        schoolName: contextProvider.schoolName,
        educationAuthority: contextProvider.selectedSchool?.educationAuthority,
        schoolLogoPath: contextProvider.selectedSchool?.logo,
        academicYear:
            contextProvider.selectedSchool?.academicYear ?? '2024-2025',
        examTypeName: data.exam.type.label,
        subjectName: contextProvider.subjectName,
        className: contextProvider.className,
        sectionName: contextProvider.sectionName.isEmpty
            ? null
            : contextProvider.sectionName,
      );

      await ExamPdfService.printExam(data.exam, data.questions, metadata);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorHandler.format(e, 'فشل الطباعة'))),
      );
    }
  }
  
  Future<void> _share(BuildContext context) async {
    _exportPdf(context); // المشاركة والتصدير متشابهان حالياً
  }
}