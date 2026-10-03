import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/student.dart';
import '../../providers/student_provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_router.dart';

class StudentDetailsPage extends StatefulWidget {
  final String studentId;
  
  const StudentDetailsPage({super.key, required this.studentId});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  StudentWithDetails? _student;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadStudent();
  }
  
  Future<void> _loadStudent() async {
    setState(() => _isLoading = true);
    
    final provider = context.read<StudentProvider>();
    _student = await provider.getStudentWithDetails(widget.studentId);
    
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_student?.student.name ?? 'تفاصيل الطالب'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push(AppRoutes.studentEditWithId(widget.studentId)),
          ),
        ],
      ),
      body: _isLoading
          ? const AppLoading(message: 'جاري تحميل البيانات...')
          : _student == null 
              ? const Center(child: Text('الطالب غير موجود'))
              : _buildContent(),
    );
  }
  
  Widget _buildContent() {
    return Column(
      children: [
        _buildHeader(),
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'نظرة عامة'),
            Tab(text: 'الاختبارات'),
            Tab(text: 'الواجبات'),
            Tab(text: 'الحضور'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(),
              _buildExamsTab(),
              _buildAssignmentsTab(),
              _buildAttendanceTab(),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildHeader() {
    final student = _student!;
    
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              student.student.name.substring(0, 1),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.student.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${student.className}${student.sectionName != null ? ' - ${student.sectionName}' : ''}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Icon(
                student.student.gender == 'male' ? Icons.male : Icons.female,
                color: student.student.gender == 'male' ? Colors.blue : Colors.pink,
              ),
              const SizedBox(height: 4),
              Text(
                student.student.studentNumber,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildOverviewTab() {
    final student = _student!;
    
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('الرقم المدرسي', student.student.studentNumber),
              const Divider(),
              _buildInfoRow('الصف', student.className),
              if (student.sectionName != null) ...[
                const Divider(),
                _buildInfoRow('الشعبة', student.sectionName!),
              ],
              if (student.student.parentPhone != null) ...[
                const Divider(),
                _buildInfoRow('هاتف ولي الأمر', student.student.parentPhone!),
              ],
              if (student.student.email != null) ...[
                const Divider(),
                _buildInfoRow('البريد الإلكتروني', student.student.email!),
              ],
              if (student.student.address != null) ...[
                const Divider(),
                _buildInfoRow('العنوان', student.student.address!),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ملاحظات',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                student.student.notes ?? 'لا توجد ملاحظات',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          text: 'تعديل البيانات',
          icon: Icons.edit,
          isFullWidth: true,
          onPressed: () => context.push(AppRoutes.studentEditWithId(widget.studentId)),
        ),
      ],
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  Widget _buildExamsTab() {
    // سيتم تنفيذها لاحقاً
    return const Center(
      child: Text('لا توجد اختبارات'),
    );
  }
  
  Widget _buildAssignmentsTab() {
    // سيتم تنفيذها لاحقاً
    return const Center(
      child: Text('لا توجد واجبات'),
    );
  }
  
  Widget _buildAttendanceTab() {
    // سيتم تنفيذها لاحقاً
    return const Center(
      child: Text('لا يوجد سجل حضور'),
    );
  }
}
