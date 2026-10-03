import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/di/injection.dart';
import '../../data/repositories/student_repository.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../providers/student_form_provider.dart';
import '../../providers/student_provider.dart';
import 'dart:io';

class StudentFormPage extends StatelessWidget {
  final String? studentId;
  
  const StudentFormPage({super.key, this.studentId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentFormProvider(getIt<StudentRepository>())
        ..initialize(studentId: studentId),
      child: const _StudentFormView(),
    );
  }
}

class _StudentFormView extends StatefulWidget {
  const _StudentFormView();

  @override
  State<_StudentFormView> createState() => _StudentFormViewState();
}

class _StudentFormViewState extends State<_StudentFormView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final formProvider = context.watch<StudentFormProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(formProvider.isEditMode ? 'تعديل طالب' : 'إضافة طالب'),
        actions: [
          if (formProvider.isEditMode)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDelete(context),
            ),
        ],
      ),
      body: formProvider.isLoading
          ? const AppLoading(message: 'جاري تحميل البيانات...')
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  _buildProfileImageSection(context),
                  const SizedBox(height: AppSpacing.lg),
                  _buildBasicInfoSection(context),
                  const SizedBox(height: AppSpacing.lg),
                  _buildClassificationSection(context),
                  const SizedBox(height: AppSpacing.lg),
                  _buildAdditionalInfoSection(context),
                  const SizedBox(height: AppSpacing.xl),
                  _buildSubmitButton(context),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileImageSection(BuildContext context) {
    final formProvider = context.watch<StudentFormProvider>();
    
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _pickImage(context),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primaryContainer,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: formProvider.profileImage != null
                  ? ClipOval(
                      child: Image.file(
                        formProvider.profileImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.add_a_photo,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            onPressed: () => _pickImage(context),
            icon: const Icon(Icons.photo_camera),
            label: Text(formProvider.profileImage != null ? 'تغيير الصورة' : 'إضافة صورة'),
          ),
          if (formProvider.profileImage != null)
            TextButton(
              onPressed: () => formProvider.removeProfileImage(),
              child: const Text('إزالة الصورة'),
            ),
        ],
      ),
    );
  }
  
  Widget _buildBasicInfoSection(BuildContext context) {
    final formProvider = context.watch<StudentFormProvider>();
    
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المعلومات الأساسية',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            label: 'اسم الطالب',
            controller: formProvider.nameController,
            prefixIcon: Icons.person,
            isRequired: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الاسم مطلوب';
              }
              if (value.trim().length < 3) {
                return 'الاسم يجب أن يكون 3 أحرف على الأقل';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'الرقم المدرسي',
            controller: formProvider.numberController,
            prefixIcon: Icons.numbers,
            isRequired: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرقم المدرسي مطلوب';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppDropdown<String>(
            label: 'الجنس',
            value: formProvider.selectedGender,
            prefixIcon: Icons.wc,
            items: const [
              DropdownMenuItem(value: 'male', child: Text('ذكر')),
              DropdownMenuItem(value: 'female', child: Text('أنثى')),
            ],
            onChanged: (value) => context.read<StudentFormProvider>().setGender(value),
          ),
        ],
      ),
    );
  }
  
  Widget _buildClassificationSection(BuildContext context) {
    final formProvider = context.watch<StudentFormProvider>();
    final studentProvider = context.watch<StudentProvider>();
    
    final sections = studentProvider.sections
        .where((s) => s.classId == formProvider.selectedClassId)
        .toList();
    
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'التصنيف',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppDropdown<String>(
            label: 'الصف',
            value: formProvider.selectedClassId,
            prefixIcon: Icons.class_,
            isRequired: true,
            items: studentProvider.classes.map((c) {
              return DropdownMenuItem(
                value: c.id,
                child: Text(c.name),
              );
            }).toList(),
            onChanged: (value) => context.read<StudentFormProvider>().setClass(value),
            validator: (value) {
              if (value == null) {
                return 'الصف مطلوب';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppDropdown<String>(
            label: 'الشعبة',
            value: formProvider.selectedSectionId,
            prefixIcon: Icons.group,
            items: sections.map((s) {
              return DropdownMenuItem(
                value: s.id,
                child: Text(s.name),
              );
            }).toList(),
            onChanged: formProvider.selectedClassId != null
                ? (value) => context.read<StudentFormProvider>().setSection(value)
                : null,
          ),
        ],
      ),
    );
  }
  
  Widget _buildAdditionalInfoSection(BuildContext context) {
    final formProvider = context.watch<StudentFormProvider>();
    
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات إضافية',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            label: 'رقم ولي الأمر',
            controller: formProvider.phoneController,
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'البريد الإلكتروني',
            controller: formProvider.emailController,
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'العنوان',
            controller: formProvider.addressController,
            prefixIcon: Icons.location_on,
            isMultiline: true,
            maxLines: 2,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'ملاحظات',
            controller: formProvider.notesController,
            prefixIcon: Icons.notes,
            isMultiline: true,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
  
  Widget _buildSubmitButton(BuildContext context) {
    final formProvider = context.watch<StudentFormProvider>();
    
    return AppButton(
      text: formProvider.isEditMode ? 'حفظ التعديلات' : 'إضافة الطالب',
      icon: formProvider.isEditMode ? Icons.save : Icons.add,
      isLoading: formProvider.isSubmitting,
      isFullWidth: true,
      size: AppButtonSize.large,
      onPressed: () => _submitForm(context),
    );
  }
  
  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final formProvider = context.read<StudentFormProvider>();
    
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('التقاط صورة'),
              onTap: () async {
                Navigator.pop(bottomSheetContext);
                final image = await picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  formProvider.setProfileImage(File(image.path));
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('اختيار من المعرض'),
              onTap: () async {
                Navigator.pop(bottomSheetContext);
                final image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  formProvider.setProfileImage(File(image.path));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      AppSnackbar.show(
        context,
        message: 'يرجى تصحيح الأخطاء في النموذج',
        type: SnackbarType.warning,
      );
      return;
    }
    
    final formProvider = context.read<StudentFormProvider>();
    final success = await formProvider.saveStudent();
    
    if (success) {
      if (context.mounted) {
        context.read<StudentProvider>().loadInitialData();
        
        AppSnackbar.show(
          context,
          message: formProvider.isEditMode 
              ? 'تم تحديث بيانات الطالب'
              : 'تم إضافة الطالب بنجاح',
          type: SnackbarType.success,
        );
        Navigator.pop(context);
      }
    } else {
      if (context.mounted) {
        AppSnackbar.show(
          context,
          message: formProvider.error ?? 'حدث خطأ',
          type: SnackbarType.error,
        );
      }
    }
  }
  
  void _confirmDelete(BuildContext context) {
    final formProvider = context.read<StudentFormProvider>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف الطالب'),
        content: const Text('هل أنت متأكد من حذف هذا الطالب؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(dialogContext); // Close dialog
              final success = await formProvider.deleteStudent();
              
              if (success && context.mounted) {
                AppSnackbar.show(
                  context,
                  message: 'تم حذف الطالب',
                  type: SnackbarType.success,
                );
                Navigator.pop(context); // Go back
              }
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
