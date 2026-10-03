import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/di/injection.dart';
import '../../data/repositories/student_repository.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../providers/student_import_provider.dart';

class StudentImportPage extends StatelessWidget {
  const StudentImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentImportProvider(getIt<StudentRepository>()),
      child: const _StudentImportView(),
    );
  }
}

class _StudentImportView extends StatelessWidget {
  const _StudentImportView();

  @override
  Widget build(BuildContext context) {
    final importProvider = context.watch<StudentImportProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('استيراد الطلاب'),
      ),
      body: importProvider.isLoading
          ? const AppLoading(message: 'جاري قراءة الملف...')
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                if (!importProvider.hasValidatedStudents)
                  _buildUploadSection(context)
                else
                  _buildPreviewSection(context),
              ],
            ),
    );
  }
  
  Widget _buildUploadSection(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.xl),
        Icon(
          Icons.upload_file,
          size: 80,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'استيراد الطلاب من ملف',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'يمكنك استيراد الطلاب من ملف Excel أو CSV',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),
        AppCard(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('ملف Excel'),
                subtitle: const Text('ملفات .xlsx أو .xls'),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => _pickFile(context, isCsv: false),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.table_chart),
                title: const Text('ملف CSV'),
                subtitle: const Text('ملفات .csv'),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => _pickFile(context, isCsv: true),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildPreviewSection(BuildContext context) {
    final importProvider = context.watch<StudentImportProvider>();
    final students = importProvider.importedStudents!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.file_present, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      importProvider.fileName ?? 'ملف الاستيراد',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => context.read<StudentImportProvider>().cancelImport(),
                  ),
                ],
              ),
              const Divider(),
              _buildSummaryRow(context, 'إجمالي الطلاب', students.length.toString()),
              _buildSummaryRow(
                context,
                'طلاب صحيحون',
                (students.length - importProvider.validationErrors.length).toString(),
              ),
              _buildSummaryRow(
                context,
                'طلاب بهم أخطاء',
                importProvider.validationErrors.length.toString(),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (importProvider.validationErrors.isNotEmpty) ...[
          AppCard(
            color: Colors.red.withValues(alpha: 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الأخطاء المكتشفة',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                ...importProvider.validationErrors.map((error) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red.shade400, size: 20),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          error,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        AppButton(
          text: 'استيراد ${students.length} طالب',
          icon: Icons.upload,
          isFullWidth: true,
          size: AppButtonSize.large,
          isLoading: importProvider.isImporting,
          onPressed: importProvider.canImport 
              ? () => _importStudents(context)
              : null,
        ),
      ],
    );
  }
  
  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Text(label),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
  
  Future<void> _pickFile(BuildContext context, {required bool isCsv}) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: isCsv ? ['csv'] : ['xlsx', 'xls'],
        allowMultiple: false,
      );
      
      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.path != null && context.mounted) {
          final importProvider = context.read<StudentImportProvider>();
          await importProvider.readFile(file.path!, isCsv: isCsv);
        }
      }
    } catch (e) {
      if (context.mounted) {
        AppSnackbar.show(
          context,
          message: 'فشل في اختيار الملف: $e',
          type: SnackbarType.error,
        );
      }
    }
  }
  
  Future<void> _importStudents(BuildContext context) async {
    final importProvider = context.read<StudentImportProvider>();
    final success = await importProvider.importStudents();
    
    if (success && context.mounted) {
      final result = importProvider.importResult!;
      AppSnackbar.show(
        context,
        message: 'تم استيراد ${result.successCount} طالب بنجاح',
        type: SnackbarType.success,
      );
      
      if (result.failedCount > 0) {
        AppSnackbar.show(
          context,
          message: 'فشل استيراد ${result.failedCount} طالب',
          type: SnackbarType.warning,
        );
      }
      
      Navigator.pop(context);
    } else if (context.mounted) {
      AppSnackbar.show(
        context,
        message: importProvider.error ?? 'فشل في الاستيراد',
        type: SnackbarType.error,
      );
    }
  }
}
