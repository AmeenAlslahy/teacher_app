import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_router.dart';
import '../../../../app/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../providers/context_provider.dart';
import '../../../../core/utils/error_handler.dart';

class ContextSelectorPage extends StatefulWidget {
  final bool allowBack;
  const ContextSelectorPage({super.key, this.allowBack = false});

  @override
  State<ContextSelectorPage> createState() => _ContextSelectorPageState();
}

class _ContextSelectorPageState extends State<ContextSelectorPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ContextProvider>().loadAll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختيار السياق'),
        automaticallyImplyLeading: widget.allowBack,
      ),
      body: Consumer<ContextProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const AppLoading(message: 'جاري تحميل البيانات...');
          }

          if (provider.error != null) {
            return _buildErrorState(context, provider);
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              _buildInfoCard(context),
              const SizedBox(height: AppSpacing.lg),
              _buildSchoolDropdown(context, provider),
              const SizedBox(height: AppSpacing.md),
              _buildClassDropdown(context, provider),
              const SizedBox(height: AppSpacing.md),
              _buildSectionDropdown(context, provider),
              const SizedBox(height: AppSpacing.md),
              _buildSubjectDropdown(context, provider),
              const SizedBox(height: AppSpacing.xl),
              _buildSaveButton(context, provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.md),
          const Expanded(
            child: Text(
              'اختر المدرسة والصف والمادة لتبدأ بإنشاء اختباراتك.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolDropdown(BuildContext context, ContextProvider provider) {
    return _dropdown<School>(
      context: context,
      label: 'المدرسة',
      icon: Icons.school,
      value: provider.selectedSchool,
      items: provider.schools,
      itemLabel: (s) => s.name,
      onChanged: provider.selectSchool,
      isRequired: true,
    );
  }

  Widget _buildClassDropdown(BuildContext context, ContextProvider provider) {
    return _dropdown<ClassesData>(
      context: context,
      label: 'الصف',
      icon: Icons.class_,
      value: provider.selectedClass,
      items: provider.classes,
      itemLabel: (c) => c.name,
      onChanged: provider.selectClass,
      isRequired: true,
      isDisabled: provider.selectedSchool == null,
    );
  }

  Widget _buildSectionDropdown(BuildContext context, ContextProvider provider) {
    return _dropdown<Section>(
      context: context,
      label: 'الشعبة',
      icon: Icons.group,
      value: provider.selectedSection,
      items: provider.sections,
      itemLabel: (s) => s.name,
      onChanged: provider.selectSection,
      isRequired: false,
      isDisabled: provider.selectedClass == null || provider.sections.isEmpty,
    );
  }

  Widget _buildSubjectDropdown(BuildContext context, ContextProvider provider) {
    return _dropdown<Subject>(
      context: context,
      label: 'المادة',
      icon: Icons.book,
      value: provider.selectedSubject,
      items: provider.subjects,
      itemLabel: (s) => s.name,
      onChanged: provider.selectSubject,
      isRequired: true,
    );
  }

  Widget _dropdown<T>({
    required BuildContext context,
    required String label,
    required IconData icon,
    required T? value,
    required List<T> items,
    required String Function(T) itemLabel,
    required void Function(T?) onChanged,
    bool isRequired = false,
    bool isDisabled = false,
  }) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: isRequired ? '$label *' : label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            itemLabel(item),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: isDisabled ? null : onChanged,
    );
  }

  Widget _buildSaveButton(BuildContext context, ContextProvider provider) {
    return AppButton(
      text: 'حفظ السياق',
      icon: Icons.check,
      isFullWidth: true,
      size: AppButtonSize.large,
      onPressed: provider.isComplete
          ? () => _saveContext(context, provider)
          : null,
    );
  }

  Future<void> _saveContext(
    BuildContext context,
    ContextProvider provider,
  ) async {
    try {
      await provider.persist();
      if (!context.mounted) return;

      AppSnackbar.show(
        context,
        message: 'تم حفظ السياق بنجاح',
        type: SnackbarType.success,
      );

      // انتقل إلى Dashboard
      if (context.canPop() && widget.allowBack) {
        context.pop();
      } else {
        context.go(AppRoutes.dashboard);
      }
    } catch (e) {
      if (!context.mounted) return;
      AppSnackbar.show(
        context,
        message: ErrorHandler.format(e, 'فشل حفظ السياق'),
        type: SnackbarType.error,
      );
    }
  }

  Widget _buildErrorState(BuildContext context, ContextProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              provider.error ?? 'حدث خطأ',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              text: 'إعادة المحاولة',
              onPressed: () => provider.loadAll(),
            ),
          ],
        ),
      ),
    );
  }
}
