import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_router.dart';
import '../../providers/dashboard_provider.dart';
import '../widgets/greeting_header.dart';
import '../widgets/context_selector_card.dart';
import '../widgets/quick_action_grid.dart';
import '../widgets/statistics_row.dart';
import '../widgets/upcoming_exams_card.dart';
import '../widgets/recent_exams_card.dart';
import '../widgets/alerts_banner.dart';
import '../../domain/entities/dashboard_data.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<DashboardProvider>().loadDashboard();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: context.read<DashboardProvider>().refresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: const Text('الرئيسية'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    // Show notifications
                  },
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimary),
                ),
                const SizedBox(width: 16),
              ],
            ),
            Consumer<DashboardProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                
                if (provider.error != null) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildErrorState(context, provider),
                  );
                }
                
                final data = provider.dashboardData;
                if (data == null) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildEmptyState(context),
                  );
                }
                
                return SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      GreetingHeader(
                        teacherName: data.teacherName,
                        date: DateTime.now(),
                      ),
                      const SizedBox(height: 16),
                      ContextSelectorCard(
                        schoolName: data.currentSchool,
                        className: data.currentClass,
                        subjectName: data.currentSubject,
                        onTap: () => context.push(AppRoutes.contextSelector),
                      ),
                      const SizedBox(height: 24),
                      QuickActionGrid(
                        onExamCreate: () => context.push(AppRoutes.examCreate),
                        onStudents: () => context.push(AppRoutes.students),
                        onGrades: () => context.push(AppRoutes.grades),
                        onAssignments: () => context.push(AppRoutes.assignments),
                      ),
                      const SizedBox(height: 24),
                      StatisticsRow(
                        totalStudents: data.totalStudents,
                        totalExams: data.totalExams,
                        totalAssignments: data.totalAssignments,
                        averageGrade: data.averageGrade,
                      ),
                      if (data.alerts.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        AlertsBanner(
                          alerts: data.alerts,
                          onAlertTap: (alert) => _handleAlertTap(context, alert),
                        ),
                      ],
                      const SizedBox(height: 24),
                      if (data.upcomingExams.isNotEmpty) ...[
                        UpcomingExamsCard(exams: data.upcomingExams),
                        const SizedBox(height: 24),
                      ],
                      if (data.recentExams.isNotEmpty) ...[
                        RecentExamsCard(exams: data.recentExams),
                      ],
                    ]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void _handleAlertTap(BuildContext context, DashboardAlert alert) {
    if (alert.examId == null) return;

    // الانتقال إلى معاينة الاختبار
    context.pushNamed(
      'examPreview',
      pathParameters: {'id': alert.examId!},
    );
  }

  Widget _buildErrorState(BuildContext context, DashboardProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'حدث خطأ في تحميل البيانات',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            provider.error ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: provider.loadDashboard,
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'مرحباً بك في تطبيق إدارة الاختبارات',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'ابدأ بإعداد مدرستك وفصولك',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.push(AppRoutes.onboarding),
            child: const Text('البدء'),
          ),
        ],
      ),
    );
  }
}