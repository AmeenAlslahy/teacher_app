import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_router.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المزيد'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuSection(
            context,
            title: 'الإدارة',
            items: [
              _MenuItem(
                icon: Icons.swap_horiz,
                title: 'تغيير السياق',
                onTap: () => context.push('/context-selector/edit'),
              ),
              _MenuItem(
                icon: Icons.school,
                title: 'المدارس',
                onTap: () => context.push(AppRoutes.schools),
              ),
              _MenuItem(
                icon: Icons.class_,
                title: 'الصفوف',
                onTap: () => context.push(AppRoutes.classes),
              ),
              _MenuItem(
                icon: Icons.book,
                title: 'المواد',
                onTap: () => context.push(AppRoutes.subjects),
              ),
              _MenuItem(
                icon: Icons.question_answer,
                title: 'بنك الأسئلة',
                onTap: () => context.push(AppRoutes.questionBank),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildMenuSection(
            context,
            title: 'التقييم',
            items: [
              _MenuItem(
                icon: Icons.assignment,
                title: 'الواجبات',
                onTap: () => context.push(AppRoutes.assignments),
              ),
              _MenuItem(
                icon: Icons.event_available,
                title: 'الحضور',
                onTap: () => context.push(AppRoutes.attendance),
              ),
              _MenuItem(
                icon: Icons.assessment,
                title: 'التقارير',
                onTap: () => context.push(AppRoutes.reports),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildMenuSection(
            context,
            title: 'النظام',
            items: [
              _MenuItem(
                icon: Icons.settings,
                title: 'الإعدادات',
                onTap: () => context.push(AppRoutes.settings),
              ),
              _MenuItem(
                icon: Icons.backup,
                title: 'النسخ الاحتياطي',
                onTap: () => context.push(AppRoutes.backup),
              ),
              _MenuItem(
                icon: Icons.info,
                title: 'حول التطبيق',
                onTap: () => context.push(AppRoutes.about),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildMenuSection(
    BuildContext context, {
    required String title,
    required List<_MenuItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: items.map((item) {
              return ListTile(
                leading: Icon(item.icon),
                title: Text(item.title),
                trailing: const Icon(Icons.chevron_left),
                onTap: item.onTap,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  
  _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
