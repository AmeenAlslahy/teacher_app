import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entities/student.dart';

class StudentCard extends StatelessWidget {
  final StudentWithDetails student;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const StudentCard({
    super.key,
    required this.student,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: colorScheme.primary.withValues(alpha: 0.08),
          highlightColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                  spreadRadius: -2,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                  spreadRadius: -1,
                ),
              ],
            ),
            child: Stack(
              children: [
                // خلفية زخرفية
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primary.withValues(alpha: 0.04),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -30,
                  left: -30,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.secondary.withValues(alpha: 0.03),
                    ),
                  ),
                ),

                // المحتوى الرئيسي
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      // صورة الطالب مع إطار أنيميشن
                      _buildAvatar(context),

                      const SizedBox(width: 14),

                      // معلومات الطالب
                      Expanded(
                        child: _buildStudentInfo(context),
                      ),

                      // أزرار الإجراءات
                      _buildActionButtons(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // الصورة الرمزية مع إطار متحرك
  // ============================================================

  Widget _buildAvatar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      children: [
        // إطار خارجي متوهج
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.primary,
                colorScheme.primary.withValues(alpha: 0.6),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
              radius: 26,
              backgroundColor: colorScheme.surface,
              child: ClipOval(
                child: _buildAvatarContent(context),
              ),
            ),
          ),
        ),

        // علامة النشاط
        if (student.student.isActive)
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
                border: Border.all(
                  color: colorScheme.surface,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.4),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAvatarContent(BuildContext context) {
    final profileImage = student.student.profileImage;

    if (profileImage != null && profileImage.isNotEmpty) {
      return Image(
        image: profileImage.startsWith('http')
            ? NetworkImage(profileImage)
            : FileImage(File(profileImage)) as ImageProvider,
        fit: BoxFit.cover,
        width: 52,
        height: 52,
        errorBuilder: (_, __, ___) => _buildPlaceholderWidget(context),
      );
    }

    return _buildPlaceholderWidget(context);
  }

  Widget _buildPlaceholderWidget(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withValues(alpha: 0.15),
            colorScheme.primary.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Center(
        child: Text(
          student.student.name.isNotEmpty
              ? student.student.name.substring(0, 1).toUpperCase()
              : '?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: colorScheme.primary,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
  // ============================================================
  // معلومات الطالب
  // ============================================================

  Widget _buildStudentInfo(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // الاسم
        Row(
          children: [
            Expanded(
              child: Text(
                student.student.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: colorScheme.onSurface,
                  letterSpacing: 0.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // حالة الطالب (نشط/غير نشط)
            if (!student.student.isActive) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'غير نشط',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: 6),

        // الرقم المدرسي مع أيقونة
        Row(
          children: [
            Icon(
              Icons.numbers,
              size: 14,
              color: Colors.grey.shade400,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                student.student.studentNumber,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // الصف والشعبة مع أيقونة
        Row(
          children: [
            Icon(
              Icons.school,
              size: 14,
              color: Colors.grey.shade400,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                '${student.className}${student.sectionName != null && student.sectionName!.isNotEmpty ? ' • ${student.sectionName}' : ''}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        // شريط تقدم بسيط للدرجات (اختياري)
        if (student.averageGrade != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (student.averageGrade! / 100).clamp(0.0, 1.0),
                    backgroundColor: Colors.grey.shade200,
                    color: _getGradeColor(student.averageGrade!),
                    minHeight: 4,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${student.averageGrade!.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _getGradeColor(student.averageGrade!),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  // ============================================================
  // أزرار الإجراءات (المُصححة)
  // ============================================================

  Widget _buildActionButtons(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // زر تعديل (مع خلفية أنيقة)
        // _buildActionButton(
        //   context,
        //   icon: Icons.edit_outlined,
        //   onTap: onEdit,
        //   color: colorScheme.primary,
        //   tooltip: 'تعديل',
        // ),

        const SizedBox(width: 4),

        // زر حذف (مع خلفية أنيقة)
        // _buildActionButton(
        //   context,
        //   icon: Icons.delete_outline,
        //   onTap: onDelete,
        //   color: colorScheme.error,
        //   tooltip: 'حذف',
        // ),

        const SizedBox(width: 4),

        // زر النقاط الثلاث للقائمة
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
          ),
          child: PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey.shade600,
              size: 20,
            ),
            padding: EdgeInsets.zero,
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'details',
                child: Row(
                  children: [
                    Icon(Icons.visibility_outlined, size: 18),
                    SizedBox(width: 12),
                    Text('تفاصيل', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, size: 18, color: Colors.blue),
                    SizedBox(width: 12),
                    Text('تعديل',
                        style: TextStyle(fontSize: 14, color: Colors.blue)),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 18, color: Colors.red),
                    SizedBox(width: 12),
                    Text('حذف',
                        style: TextStyle(fontSize: 14, color: Colors.red)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'details') {
                onTap();
              } else if (value == 'edit') {
                onEdit();
              } else if (value == 'delete') {
                onDelete();
              }
            },
          ),
        ),
      ],
    );
  }



  // ============================================================
  // دوال مساعدة
  // ============================================================

  Color _getGradeColor(double grade) {
    if (grade >= 85) return Colors.green;
    if (grade >= 70) return Colors.orange;
    if (grade >= 50) return Colors.amber;
    return Colors.red;
  }
}
