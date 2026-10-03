import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../context/providers/context_provider.dart';
import '../../providers/exam_provider.dart';
import '../widgets/exam_review_sheet.dart';
import 'exam_canvas_page.dart';
import 'exam_setup_page.dart';

class ExamEditorPage extends StatefulWidget {
  final String? examId;

  const ExamEditorPage({super.key, this.examId});

  @override
  State<ExamEditorPage> createState() => _ExamEditorPageState();
}

class _ExamEditorPageState extends State<ExamEditorPage> {
  late final ExamProvider _provider;
  bool _initialized = false;
  bool _showSetup = false;
  Timer? _autoSaveTimer;

  @override
  void initState() {
    super.initState();
    _provider = getIt<ExamProvider>();
    _initialize();
  }

  Future<void> _initialize() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _provider.reset();
      final contextProvider = context.read<ContextProvider>();

      if (widget.examId != null) {
        await _provider.loadExam(widget.examId!);
        _showSetup = false;
      } else {
        _provider.setContext(
          schoolId: contextProvider.schoolId ?? '',
          classId: contextProvider.classId ?? '',
          sectionId: contextProvider.sectionId,
          subjectId: contextProvider.subjectId ?? '',
          subjectName: contextProvider.subjectName,
        );
        _provider.createNewExam();
        _showSetup = true;
      }

      if (!mounted) return;
      setState(() => _initialized = true);
      _startAutoSave();
    });
  }

  void _startAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      if (!mounted || _provider.isSaving) return;
      if (_provider.saveStatus == 'مسودة غير محفوظة') {
        await _provider.saveExam();
      }
    });
  }

  Future<void> _finishSetup() async {
    final exam = _provider.currentExam;
    if (exam == null) return;

    if (exam.title.trim().isEmpty) {
      AppSnackbar.show(context, message: 'أدخل عنوان الاختبار أولًا', type: SnackbarType.warning);
      return;
    }
    if (exam.schoolId.isEmpty || exam.classId.isEmpty || exam.subjectId.isEmpty) {
      AppSnackbar.show(
        context,
        message: 'السياق الدراسي غير مكتمل. اختر المدرسة والصف والمادة أولًا.',
        type: SnackbarType.error,
      );
      return;
    }

    final success = await _provider.saveExam();
    if (!mounted) return;
    if (!success) {
      AppSnackbar.show(
        context,
        message: _provider.error ?? 'تعذر حفظ الاختبار',
        type: SnackbarType.error,
      );
      return;
    }

    setState(() => _showSetup = false);
  }

  Future<void> _openReview() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ChangeNotifierProvider.value(
        value: _provider,
        child: const ExamReviewSheet(),
      ),
    );
  }

  Future<void> _saveAndExit() async {
    final errors = await _provider.validateExam();
    if (!mounted) return;
    if (errors.isNotEmpty) {
      AppSnackbar.show(context, message: errors.first, type: SnackbarType.error);
      return;
    }

    final success = await _provider.saveExam();
    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop();
    } else {
      AppSnackbar.show(
        context,
        message: _provider.error ?? 'فشل حفظ الاختبار',
        type: SnackbarType.error,
      );
    }
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(body: AppLoading(message: 'جاري تجهيز محرر الاختبار...'));
    }

    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer<ExamProvider>(
        builder: (context, provider, _) {
          final exam = provider.currentExam;
          if (provider.isLoading && exam == null) {
            return const Scaffold(body: AppLoading(message: 'جاري تحميل الاختبار...'));
          }
          if (exam == null) {
            return const Scaffold(body: Center(child: Text('الاختبار غير موجود')));
          }

          if (_showSetup) {
            return Scaffold(
              appBar: AppBar(title: const Text('إعداد الاختبار')),
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: ExamSetupPage(onContinue: _finishSetup),
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam.title.isEmpty ? 'اختبار جديد' : exam.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    provider.isSaving
                        ? 'جارٍ الحفظ...'
                        : provider.saveStatus.contains('✓')
                            ? 'محفوظ'
                            : provider.saveStatus.isNotEmpty
                                ? 'تغييرات غير محفوظة'
                                : 'محفوظ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              actions: [
                IconButton(
                  tooltip: 'إعدادات الاختبار',
                  icon: const Icon(Icons.tune_outlined),
                  onPressed: provider.isSaving
                      ? null
                      : () => showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            showDragHandle: true,
                            builder: (sheetContext) => ChangeNotifierProvider.value(
                              value: _provider,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(sheetContext).bottom),
                                child: ExamSetupPage(onContinue: () => Navigator.of(sheetContext).pop()),
                              ),
                            ),
                          ),
                ),
                IconButton(
                  tooltip: 'مراجعة الاختبار',
                  icon: const Icon(Icons.fact_check_outlined),
                  onPressed: _openReview,
                ),
              ],
            ),
            body: const ExamCanvasPage(),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: provider.isSaving ? null : _saveAndExit,
              icon: const Icon(Icons.check),
              label: const Text('حفظ وإنهاء'),
            ),
          );
        },
      ),
    );
  }
}
