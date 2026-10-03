import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/services/backup_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_snackbar.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({super.key});

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('النسخ الاحتياطي')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _buildInfoCard(context),
          const SizedBox(height: AppSpacing.lg),
          _buildExportCard(context),
          const SizedBox(height: AppSpacing.md),
          _buildImportCard(context),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: AppSpacing.md),
          const Expanded(
            child: Text(
              'احفظ نسخة من بياناتك أو استعدها من ملف سابق. البيانات تُخزَّن محليًا.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.upload_file, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'تصدير نسخة احتياطية',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text('ينشئ ملف JSON يحتوي كل بياناتك ويمكنك مشاركته.'),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            text: 'إنشاء ومشاركة النسخة',
            icon: Icons.share,
            isFullWidth: true,
            isLoading: _busy,
            onPressed: _busy ? null : _exportBackup,
          ),
        ],
      ),
    );
  }

  Widget _buildImportCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.download, color: Theme.of(context).colorScheme.error),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'استعادة نسخة احتياطية',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'سيتم استبدال البيانات الحالية ببيانات النسخة. تأكد قبل المتابعة.',
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            text: 'اختيار ملف الاستعادة',
            icon: Icons.folder_open,
            type: AppButtonType.outline,
            isFullWidth: true,
            isLoading: _busy,
            onPressed: _busy ? null : _importBackup,
          ),
        ],
      ),
    );
  }

  Future<void> _exportBackup() async {
    setState(() => _busy = true);
    try {
      final service = BackupService(getIt());
      final file = await service.createBackup();
      await service.shareBackup(file);

      if (!mounted) return;
      AppSnackbar.show(context, message: 'تم إنشاء النسخة', type: SnackbarType.success);
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.show(
        context,
        message: 'فشل التصدير: $e',
        type: SnackbarType.error,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _importBackup() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تأكيد الاستعادة'),
        content: const Text('سيتم استبدال كل البيانات الحالية. هل أنت متأكد؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('استعادة'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _busy = true);
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.isEmpty) {
        if (mounted) setState(() => _busy = false);
        return;
      }

      final path = result.files.first.path;
      if (path == null) throw Exception('لم يتم العثور على الملف');

      final service = BackupService(getIt());
      final file = File(path);

      final isValid = await service.validateBackup(file);
      if (!isValid) throw Exception('الملف غير صالح');

      final success = await service.restoreBackup(file);
      if (!success) throw Exception('فشل الاستعادة');

      if (!mounted) return;
      AppSnackbar.show(
        context,
        message: 'تمت الاستعادة بنجاح',
        type: SnackbarType.success,
      );
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.show(
        context,
        message: 'فشل الاستعادة: $e',
        type: SnackbarType.error,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}
