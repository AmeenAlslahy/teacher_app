import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../providers/exam_provider.dart';
import '../../domain/entities/exam.dart';

class ExamReviewSheet extends StatefulWidget {
  const ExamReviewSheet({super.key});

  @override
  State<ExamReviewSheet> createState() => _ExamReviewSheetState();
}

class _ExamReviewSheetState extends State<ExamReviewSheet> {
  List<String>? _errors;
  bool _checking = false;

  Future<void> _validate() async {
    setState(() => _checking = true);
    final errors = await context.read<ExamProvider>().validateExam();
    if (mounted) setState(() { _errors = errors; _checking = false; });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _validate());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExamProvider>();
    final exam = provider.currentExam;
    if (exam == null) return const SizedBox.shrink();

    final questions = provider.currentQuestions;
    final total = questions.fold<double>(0, (sum, q) => sum + q.marks);
    final errors = _errors ?? const <String>[];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('مراجعة الاختبار', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: AppSpacing.lg),
              _CheckRow(label: 'عنوان الاختبار', ok: exam.title.trim().isNotEmpty),
              _CheckRow(label: 'المادة والسياق الدراسي', ok: exam.schoolId.isNotEmpty && exam.classId.isNotEmpty && exam.subjectId.isNotEmpty),
              _CheckRow(label: 'الأسئلة', ok: questions.isNotEmpty, trailing: '${questions.length}'),
              _CheckRow(label: 'الدرجات', ok: total > 0, trailing: '${total % 1 == 0 ? total.toInt() : total}'),
              const SizedBox(height: AppSpacing.md),
              if (_checking)
                const LinearProgressIndicator()
              else if (errors.isEmpty)
                const _StatusBox(text: 'الاختبار جاهز للمراجعة النهائية.', icon: Icons.check_circle_outline)
              else
                _ErrorBox(errors: errors),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  OutlinedButton.icon(onPressed: _validate, icon: const Icon(Icons.refresh), label: const Text('فحص مرة أخرى')),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: Text('${questions.length} سؤال • ${total.toStringAsFixed(total % 1 == 0 ? 0 : 1)} درجة', textAlign: TextAlign.end)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckRow extends StatelessWidget {
  final String label;
  final bool ok;
  final String? trailing;
  const _CheckRow({required this.label, required this.ok, this.trailing});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(ok ? Icons.check_circle : Icons.warning_amber_rounded, color: ok ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error),
      title: Text(label),
      trailing: trailing == null ? null : Text(trailing!),
    );
  }
}

class _StatusBox extends StatelessWidget {
  final String text;
  final IconData icon;
  const _StatusBox({required this.text, required this.icon});
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(AppSpacing.md), child: Row(children: [Icon(icon), const SizedBox(width: 8), Expanded(child: Text(text))])));
}

class _ErrorBox extends StatelessWidget {
  final List<String> errors;
  const _ErrorBox({required this.errors});
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(AppSpacing.md), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [for (final error in errors) Padding(padding: const EdgeInsets.only(bottom: 6), child: Text('• $error'))])));
}
