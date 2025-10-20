import 'package:braincount/app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/user_header.dart';
import '../../../widgets/brain_loader.dart';
import '../../../routes/app_routes.dart';
import '../../tasks/widgets/submitted_task_card.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Scale factor for responsive design
    final scale = Responsive.scaleWidth(393.0);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF160531),
        ),
        child: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value && controller.stats.value == null) {
              return const BrainLoader(message: 'Loading dashboard...');
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  // User Header
                  UserHeader(scale: scale, onSettingsTap: controller.goToSettings),
                  
                  SizedBox(height: 16 * scale),
                  
                  // Dashboard Title
                  _buildTitle(scale),
                  
                  SizedBox(height: 20 * scale),
                  
                  // 3D Task Map
                  _build3DTaskMap(scale),
                  
                  SizedBox(height: 30 * scale),
                  
                  // Summary Title
                  _buildSummaryTitle(scale),
                  
                  SizedBox(height: 24 * scale),
                  
                  // Summary Cards
                  _buildSummarySection(scale),
                  
                  SizedBox(height: 28 * scale),
                  
                  // Task List with Tabs
                  _buildTaskSection(scale),
                  
                  SizedBox(height: 120 * scale), // Space for bottom nav
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  

  Widget _buildTitle(double scale) {
    return Text(
      'DASHBOARD',
      style: TextStyle(
        fontSize: 24 * scale,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _build3DTaskMap(double scale) {
    return Container(
      height: 287 * scale,
      width: 375 * scale,
      margin: EdgeInsets.symmetric(horizontal: 9 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10 * scale),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 3D Map Image - positioned to show just the city
          Positioned(
            left: 0,
            right: 0,
            top: 30 * scale,
            child: Image.asset(
              'assets/figma_exports/ac3825b42dfe639a6e60315d2caf41718a1fad22.png',
              height: 257 * scale,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 257 * scale,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, 0),
                      radius: 1.0,
                      colors: [
                        const Color(0xFF967FCA).withValues(alpha: 0.3),
                        const Color(0xFF160531).withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.location_city,
                      size: 80 * scale,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Task Card 1 (Top-left on buildings)
          Positioned(
            top: 0,
            left: 65 * scale,
            child: _build3DTaskCard('Task 2', scale),
          ),
          
          // Task Card 2 (Center-right on buildings)
          Positioned(
            top: 119 * scale,
            left: 125 * scale,
            child: _build3DTaskCard('Task 4', scale),
          ),
          
          // Withdraw Button (bottom-right)
          Positioned(
            bottom: -10 * scale,
            right: 30 * scale,
            child: _buildWithdrawButton(scale),
          ),
        ],
      ),
    );
  }

  Widget _build3DTaskCard(String taskName, double scale) {
    return Container(
      height: 49 * scale,
      width: 161 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4 * scale,
            offset: Offset(0, 4 * scale),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Task name
          Positioned(
            left: 15 * scale,
            top: 10 * scale,
            child: Text(
              taskName,
              style: TextStyle(
                fontSize: 15 * scale,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: -0.15,
                height: 1.5,
              ),
            ),
          ),
          
          // View button
          Positioned(
            right: 11 * scale,
            top: 11 * scale,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 11 * scale,
                vertical: 4 * scale,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFA072CF),
                borderRadius: BorderRadius.circular(15 * scale),
              ),
              child: Text(
                'View',
                style: TextStyle(
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.12,
                  height: 1.5,
                ),
              ),
            ),
          ),
          
          // Arrow at bottom
          Positioned(
            bottom: -7 * scale,
            left: 36 * scale,
            child: Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
              size: 14 * scale,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawButton(double scale) {
    return GestureDetector(
      onTap: controller.goToWithdraw,
      child: Container(
        height: 45 * scale,
        width: 125 * scale,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10 * scale),
          gradient: const RadialGradient(
            center: Alignment(-0.126, -2.234),
            radius: 1.5,
            colors: [
              Color(0xEB58A3D8),
              Color(0xE78C98EC),
              Color(0xE3C08EFF),
            ],
            stops: [0.242, 0.545, 0.849],
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  'Withdraw',
                  style: TextStyle(
                    fontSize: 15 * scale,
                    color: Colors.white,
                    letterSpacing: 0.3,
                    height: 1.25,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 6 * scale),
              Icon(
                Icons.arrow_forward,
                size: 10 * scale,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryTitle(double scale) {
    return Text(
      'Summary',
      style: TextStyle(
        fontSize: 24 * scale,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSummarySection(double scale) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Obx(() {
        final stats = controller.stats.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatCard(
              'Task Completed',
              stats?.taskCompleted.toString() ?? '22',
              const Color(0xFF94CF6F),
              scale,
              'assets/figma_exports/a29cb327491524ea2c54f667bc26f5de70644a1e.png',
            ),
            _buildStatCard(
              'Task Pending',
              stats?.taskPending.toString() ?? '01',
              const Color(0xFFFFE177),
              scale,
              'assets/figma_exports/aef459389e4d924042d590b4feb4814a7e12b0dc.png',
            ),
            _buildStatCard(
              'Task Rejected',
              stats?.taskRejected.toString() ?? '03',
              const Color(0xFFEA1C81),
              scale,
              'assets/figma_exports/1675285846cd7b5e8d301751b7fad513321145d8.png',
            ),
            _buildBalanceCard(
              controller.currentUser.value?.balance.toStringAsFixed(0) ?? '12,000',
              scale,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStatCard(String label, String value, Color accentColor, double scale, String iconPath) {
    return Container(
      width: 78 * scale,
      height: 100 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFF322647),
        borderRadius: BorderRadius.circular(6 * scale),
      ),
      child: Stack(
        children: [
          // Top accent line
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4 * scale,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6 * scale),
                  topRight: Radius.circular(6 * scale),
                ),
              ),
            ),
          ),
          
          // Icon
          Positioned(
            top: 21 * scale,
            left: 24 * scale,
            child: Image.asset(
              iconPath,
              width: 30 * scale,
              height: 30 * scale,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 30 * scale,
                  height: 30 * scale,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15 * scale),
                  ),
                  child: Icon(
                    Icons.task_alt,
                    size: 20 * scale,
                    color: accentColor,
                  ),
                );
              },
            ),
          ),
          
          // Label
          Positioned(
            bottom: 21 * scale,
            left: 0,
            right: 0,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 6 * scale,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.12,
                height: 1.25,
              ),
            ),
          ),
          
          // Value
          Positioned(
            bottom: 6 * scale,
            left: 0,
            right: 0,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14 * scale,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(String balance, double scale) {
    return Container(
      width: 78 * scale,
      height: 100 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFF322647),
        borderRadius: BorderRadius.circular(6 * scale),
      ),
      child: Stack(
        children: [
          // Top accent line
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFF80B4FB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6 * scale),
                  topRight: Radius.circular(6 * scale),
                ),
              ),
            ),
          ),
          
          // Icon
          Positioned(
            top: 24 * scale,
            left: 26 * scale,
            child: Image.asset(
              'assets/figma_exports/ced8213fa5d46c747c4716e117d8a33b5e7cb0a3.png',
              width: 27 * scale,
              height: 27 * scale,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 27 * scale,
                  height: 27 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFF80B4FB).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(13 * scale),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    size: 18 * scale,
                    color: const Color(0xFF80B4FB),
                  ),
                );
              },
            ),
          ),
          
          // Label
          Positioned(
            bottom: 21 * scale,
            left: 0,
            right: 0,
            child: Text(
              'Balance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 6 * scale,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.12,
                height: 1.25,
              ),
            ),
          ),
          
          // Value
          Positioned(
            bottom: 6 * scale,
            left: 0,
            right: 0,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '${balance}tk',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskSection(double scale) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 11.5 * scale),
      padding: EdgeInsets.symmetric(vertical: 10 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFF281C3E),
        borderRadius: BorderRadius.circular(10 * scale),
      ),
      child: Column(
        children: [
          // Tab Filters
          _buildTabFilters(scale),
          
          SizedBox(height: 12 * scale),
          
          // Task List
          _buildTaskList(scale),
        ],
      ),
    );
  }

  Widget _buildTabFilters(double scale) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 11 * scale),
      child: Obx(() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTabItem(
            'Task List',
            Icons.list,
            controller.selectedFilter.value == 'all',
            () => controller.changeFilter('all'),
            scale,
          ),
          SizedBox(width: 6 * scale),
          _buildTabItem(
            'Pending',
            Icons.pending,
            controller.selectedFilter.value == 'pending',
            () => controller.changeFilter('pending'),
            scale,
          ),
          SizedBox(width: 6 * scale),
          _buildTabItem(
            'Submitted',
            Icons.check_circle_outline,
            controller.selectedFilter.value == 'submitted',
            () => controller.changeFilter('submitted'),
            scale,
          ),
        ],
      )),
    );
  }

  Widget _buildTabItem(String title, IconData icon, bool isActive, VoidCallback onTap, double scale) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 109 * scale,
        height: 30 * scale,
        padding: EdgeInsets.symmetric(
          horizontal: 17 * scale,
          vertical: 7 * scale,
        ),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF646397) : Colors.transparent,
          borderRadius: BorderRadius.circular(6 * scale),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13 * scale,
              color: isActive ? Colors.white : const Color(0xFF6B7C97),
            ),
            SizedBox(width: 6 * scale),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12 * scale,
                  color: isActive ? Colors.white : const Color(0xFF6B7C97),
                  letterSpacing: 0.24,
                  height: 1.25,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList(double scale) {
    return Obx(() {
      final tasks = controller.recentTasks.take(3).toList();
      
      if (tasks.isEmpty) {
        return Padding(
          padding: EdgeInsets.all(40 * scale),
          child: Text(
            'No tasks available',
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 14 * scale,
            ),
          ),
        );
      }
      
      return Column(
        children: [
          ...tasks.asMap().entries.map((entry) {
            final index = entry.key;
            final task = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < tasks.length - 1 ? 12 * scale : 0,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 7.5 * scale),
                child: SubmittedTaskCard(
                  task: task,
                  index: index + 1,
                  onTap: () => controller.goToTaskDetails(task),
                ),
              ),
            );
          }),
          
          SizedBox(height: 12 * scale),
          
          // See More Button
          _buildSeeMoreButton(scale),
        ],
      );
    });
  }

  Widget _buildSeeMoreButton(double scale) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.taskList),
      child: Container(
        width: 75 * scale,
        height: 18 * scale,
        padding: EdgeInsets.symmetric(
          horizontal: 14 * scale,
          vertical: 1 * scale,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF71689F),
          borderRadius: BorderRadius.circular(21 * scale),
        ),
        child: Center(
          child: Text(
            'See More',
            style: TextStyle(
              fontSize: 10 * scale,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
