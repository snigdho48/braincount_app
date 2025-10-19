import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/dashboard_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/stats_card.dart';
import '../../../widgets/brain_loader.dart';
import '../../../routes/app_routes.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.stats.value == null) {
            return const BrainLoader(message: 'Loading dashboard...');
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                _buildHeader(),
                const SizedBox(height: 20),
                
                // 3D Task Map Section
                _build3DTaskMap(),
                const SizedBox(height: 30),
                
                // Summary Section
                _buildSummarySection(),
                const SizedBox(height: 20),
                
                // Task Tabs Section
                _buildTaskTabs(),
                const SizedBox(height: 20),
                
                // Task List Section
                _buildTaskList(),
                const SizedBox(height: 20),
                
                // See More Button
                _buildSeeMoreButton(),
                const SizedBox(height: 100), // Space for bottom nav
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Top row with user info and settings
          Row(
            children: [
              // User Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '👨‍💼',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'NAFSIN RAHMAN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textWhite,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'User ID: 34874',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textWhite.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Settings Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.gear,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Dashboard Title
          const Text(
            'DASHBOARD',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _build3DTaskMap() {
    return Container(
      height: 280,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primaryLight.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // 3D City Background
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.2),
                    AppColors.primaryLight.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.city,
                  size: 80,
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ),
          
          // Task Bubble 1
          Positioned(
            top: 60,
            left: 40,
            child: _buildTaskBubble('Task 2', () {}),
          ),
          
          // Task Bubble 2
          Positioned(
            top: 120,
            right: 40,
            child: _buildTaskBubble('Task 4', () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskBubble(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'View',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Header with Withdraw Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Summary',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.withdraw),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Withdraw',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Stats Grid
          Obx(() {
            final stats = controller.stats.value;
            return GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.0,
              children: [
                StatsCard(
                  icon: FontAwesomeIcons.circleCheck,
                  label: 'Task\nCompleted',
                  value: '${stats?.taskCompleted ?? 22}',
                  color: AppColors.success,
                ),
                StatsCard(
                  icon: FontAwesomeIcons.clock,
                  label: 'Task\nPending',
                  value: '${stats?.taskPending ?? 1}',
                  color: AppColors.warning,
                ),
                StatsCard(
                  icon: FontAwesomeIcons.circleXmark,
                  label: 'Task\nRejected',
                  value: '${stats?.taskRejected ?? 3}',
                  color: AppColors.error,
                ),
                StatsCard(
                  icon: FontAwesomeIcons.wallet,
                  label: 'Balance',
                  value: '${NumberFormat('#,##0', 'en_US').format(stats?.balance ?? 12000)}tk',
                  color: AppColors.info,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTaskTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(() => Row(
        children: [
          _buildTab(0, 'Task List', FontAwesomeIcons.list),
          const SizedBox(width: 8),
          _buildTab(1, 'Pending', FontAwesomeIcons.folder),
          const SizedBox(width: 8),
          _buildTab(2, 'Submitted', FontAwesomeIcons.folder),
        ],
      )),
    );
  }

  Widget _buildTab(int index, String label, IconData icon) {
    final isSelected = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected ? AppColors.primaryGradient : null,
            color: isSelected ? null : AppColors.cardDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.cardDark,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                icon,
                color: isSelected ? Colors.white : AppColors.textGrey,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textGrey,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Task List Title
          const Text(
            'Recent Tasks',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Task Cards
          Obx(() {
            final tasks = controller.recentTasks.take(3).toList();
            return Column(
              children: tasks.isEmpty ? _buildMockTasks() : tasks.map((task) => _buildTaskCard(task)).toList(),
            );
          }),
        ],
      ),
    );
  }

  List<Widget> _buildMockTasks() {
    return [
      _buildMockTaskCard(
        '01: TASK: Gulshan 2 Billboard',
        'Submission Status: Accepted\nSubmitted Status: Good\nView: 2',
        'Exp: 25/09/25',
        'assets/designs/billboard1.png',
      ),
      const SizedBox(height: 12),
      _buildMockTaskCard(
        '01: TASK: Shitolpur School. Ctg',
        'Submission Status: Accepted\nSubmitted Status: Good\nView: 2',
        'Exp: 25/09/25',
        'assets/designs/billboard2.png',
      ),
      const SizedBox(height: 12),
      _buildMockTaskCard(
        '01: TASK: Gulshan 2 Billboard',
        'Submission Status: Accepted\nSubmitted Status: Good\nView: 2',
        'Exp: 25/09/25',
        'assets/designs/billboard3.png',
      ),
    ];
  }

  Widget _buildMockTaskCard(String title, String details, String expiry, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.success.withOpacity(0.1),
            AppColors.success.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.success.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Task Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.image,
                color: AppColors.textGrey,
                size: 24,
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Task Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Expiry and Arrow
          Column(
            children: [
              Text(
                expiry,
                style: const TextStyle(
                  color: AppColors.error,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const FaIcon(
                FontAwesomeIcons.chevronRight,
                color: AppColors.textGrey,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(dynamic task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.success.withOpacity(0.1),
            AppColors.success.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.success.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Task Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.image,
                color: AppColors.textGrey,
                size: 24,
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Task Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title ?? 'Task Title',
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Status: ${task.status ?? 'Pending'}',
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Arrow
          const FaIcon(
            FontAwesomeIcons.chevronRight,
            color: AppColors.textGrey,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildSeeMoreButton() {
    return Center(
      child: GestureDetector(
        onTap: () {}, // Tasks list is in bottom nav
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'See More',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}