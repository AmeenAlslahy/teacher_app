import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../app/app_router.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../providers/student_provider.dart';
import '../widgets/student_card.dart';
import '../widgets/student_filter_sheet.dart';
import '../widgets/student_sort_sheet.dart';
import '../../domain/entities/student.dart';
import '../../data/services/student_export_service.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(() {
      if (mounted) {
        context.read<StudentProvider>().loadInitialData();
      }
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<StudentProvider>().loadMoreStudents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلاب'),
        actions: [
          // زر الترتيب
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'ترتيب',
            onPressed: () => _showSortSheet(),
          ),
          // زر الفلترة
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'تصفية',
            onPressed: () => _showFilterSheet(),
          ),
          // زر التصدير
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'تصدير',
            onPressed: () => _showExportDialog(),
          ),
          // زر الاستيراد
          IconButton(
            icon: const Icon(Icons.file_upload),
            tooltip: 'استيراد',
            onPressed: () => context.push(AppRoutes.studentImport),
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: AppSearchBar(
              controller: _searchController,
              hintText: 'البحث عن طالب بالاسم أو الرقم...',
              onChanged: (value) {
                context.read<StudentProvider>().setSearchQuery(value);
              },
              onClear: () {
                _searchController.clear();
                context.read<StudentProvider>().setSearchQuery('');
              },
            ),
          ),
          
          // مؤشر الفلاتر النشطة
          Consumer<StudentProvider>(
            builder: (context, provider, _) {
              if (!provider.hasActiveFilters) {
                return const SizedBox.shrink();
              }
              
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  children: [
                    if (provider.selectedClassId != null)
                      _buildFilterChip(
                        label: provider.selectedClassName ?? 'الصف',
                        onRemove: () => provider.setClassFilter(null),
                      ),
                    if (provider.selectedSectionId != null)
                      _buildFilterChip(
                        label: provider.selectedSectionName ?? 'الشعبة',
                        onRemove: () => provider.setSectionFilter(null),
                      ),
                    if (provider.searchQuery.isNotEmpty)
                      _buildFilterChip(
                        label: 'بحث: ${provider.searchQuery}',
                        onRemove: () {
                          _searchController.clear();
                          provider.setSearchQuery('');
                        },
                      ),
                  ],
                ),
              );
            },
          ),
          
          const SizedBox(height: AppSpacing.sm),
          
          // قائمة الطلاب
          Expanded(
            child: Consumer<StudentProvider>(
              builder: (context, provider, _) {
                return RefreshIndicator(
                  onRefresh: () => provider.loadInitialData(),
                  child: _buildStudentsList(context, provider),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.studentCreate),
        icon: const Icon(Icons.add),
        label: const Text('إضافة طالب'),
      ),
    );
  }
  
  Widget _buildFilterChip({required String label, required VoidCallback onRemove}) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: Chip(
        label: Text(label),
        onDeleted: onRemove,
        deleteIcon: const Icon(Icons.close, size: 16),
      ),
    );
  }
  
  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const StudentFilterSheet(),
    );
  }
  
  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const StudentSortSheet(),
    );
  }
  
  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تصدير الطلاب'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Excel'),
              subtitle: const Text('ملف Excel يمكن فتحه في برامج الجداول'),
              onTap: () {
                Navigator.pop(context);
                _exportStudents('excel');
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('CSV'),
              subtitle: const Text('ملف نصي بسيط'),
              onTap: () {
                Navigator.pop(context);
                _exportStudents('csv');
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _exportStudents(String format) async {
    final provider = context.read<StudentProvider>();
    
    try {
      final students = await provider.exportStudents();
      
      if (format == 'excel') {
        final file = await StudentExportService.exportToExcel(students);
        await StudentExportService.shareFile(file);
      } else {
        final file = await StudentExportService.exportToCsv(students);
        await StudentExportService.shareFile(file);
      }
      
      if (mounted) {
        AppSnackbar.show(
          context,
          message: 'تم تصدير الطلاب بنجاح',
          type: SnackbarType.success,
        );
      }
    } catch (e) {
      if (mounted) {
        AppSnackbar.show(
          context,
          message: 'فشل في تصدير الطلاب: $e',
          type: SnackbarType.error,
        );
      }
    }
  }
  
  Widget _buildStudentsList(BuildContext context, StudentProvider provider) {
    if (provider.isLoading && provider.students.isEmpty) {
      return const AppLoading(message: 'جاري تحميل الطلاب...');
    }

    if (provider.students.isEmpty) {
      return AppEmptyState(
        icon: Icons.people_outline,
        title: 'لا يوجد طلاب',
        message: provider.hasActiveFilters
            ? 'لا يوجد طلاب مطابقين للفلاتر الحالية'
            : 'ابدأ بإضافة أول طالب',
        action: provider.hasActiveFilters
            ? AppButton(
                text: 'مسح الفلاتر',
                icon: Icons.clear,
                type: AppButtonType.outline,
                onPressed: () {
                  _searchController.clear();
                  provider.clearAllFilters();
                },
              )
            : AppButton(
                text: 'إضافة طالب',
                icon: Icons.add,
                onPressed: () => context.push(AppRoutes.studentCreate),
              ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: provider.students.length + (provider.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == provider.students.length) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final student = provider.students[index];
        return StudentCard(
          student: student,
          onTap: () => context.push(AppRoutes.studentDetailsWithId(student.student.id)),
          onEdit: () => context.push(AppRoutes.studentEditWithId(student.student.id)),
          onDelete: () => _confirmDelete(student.student),
        );
      },
    );
  }

  void _confirmDelete(Student student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الطالب'),
        content: Text('هل أنت متأكد من حذف الطالب ${student.name}؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<StudentProvider>().deleteStudent(student.id);
              AppSnackbar.show(
                context,
                message: 'تم حذف الطالب بنجاح',
                type: SnackbarType.success,
              );
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