import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/exam.dart';
import '../../providers/exam_provider.dart';
import '../widgets/exam_card.dart';
import '../widgets/exam_filter_sheet.dart';

class ExamsPage extends StatefulWidget {
  const ExamsPage({super.key});

  @override
  State<ExamsPage> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  late final ExamProvider _provider;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = getIt<ExamProvider>();
    _provider.loadExams();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الاختبارات'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => _showFilterSheet(context),
            ),
          ],
        ),
        body: Consumer<ExamProvider>(
          builder: (context, provider, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: AppSearchBar(
                    controller: _searchController,
                    hintText: 'البحث عن اختبار...',
                    onChanged: provider.setSearchQuery,
                  ),
                ),
                Expanded(
                  child: _buildContent(context, provider),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.pushNamed('examCreate'),
          icon: const Icon(Icons.add),
          label: const Text('اختبار جديد'),
        ),
      ),
    );
  }
  
  Widget _buildContent(BuildContext context, ExamProvider provider) {
    if (provider.isLoading && provider.exams.isEmpty) {
      return const AppLoading(message: 'جاري تحميل الاختبارات...');
    }
    
    if (provider.exams.isEmpty) {
      return AppEmptyState(
        icon: Icons.assignment_outlined,
        title: 'لا يوجد اختبارات',
        message: 'ابدأ بإنشاء أول اختبار',
        action: AppButton(
          text: 'إنشاء اختبار',
          icon: Icons.add,
          onPressed: () => context.pushNamed('examCreate'),
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: provider.exams.length,
      itemBuilder: (context, index) {
        final exam = provider.exams[index];
        return ExamCard(
          exam: exam,
          onTap: () => context.pushNamed('examEdit', pathParameters: {'id': exam.id}),
          onPreview: () => context.pushNamed('examPreview', pathParameters: {'id': exam.id}),
          onDuplicate: () {
            provider.duplicateExam(exam.id);
            AppSnackbar.show(context, message: 'تم نسخ الاختبار', type: SnackbarType.success);
          },
          onDelete: () => _confirmDelete(context, exam),
        );
      },
    );
  }
  
  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ExamFilterSheet(),
    );
  }
  
  void _confirmDelete(BuildContext context, Exam exam) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الاختبار'),
        content: Text('هل أنت متأكد من حذف الاختبار "${exam.title}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _provider.deleteExam(exam.id);
              AppSnackbar.show(context, message: 'تم حذف الاختبار', type: SnackbarType.success);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}