import 'package:braincount/app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/user_header.dart';
import '../../../widgets/brain_loader.dart';
import '../../../routes/app_routes.dart';
import '../../tasks/widgets/submitted_task_card.dart';
import '../../tasks/widgets/pending_task_card.dart';
import '../../tasks/widgets/accepted_task_card.dart';
import '../../../data/services/theme_service.dart';
import '../../main_navigation/controllers/main_navigation_controller.dart';
import '../../tasks/controllers/task_list_controller.dart';
import '../../../data/models/task_model.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Scale factor for responsive design
    final scale = Responsive.scaleWidth(393.0);
    
    return Scaffold(
      body: Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
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
                  UserHeader(scale: scale),
                  
                  
                  // Dashboard Title
                  _buildTitle(scale),
                  
                  SizedBox(height: 20 * scale),
                  
                  // 3D Task Map with Zoom Effect
                 _build3DTaskMap(scale),
                  
                  SizedBox(height: 35 * scale),

                  // Zoomed Task Card (positioned before summary)
                  Obx(() {
                    if (controller.isTaskZoomed.value && controller.zoomedTask.value != null) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: Responsive.sp(7),
                          vertical: Responsive.sp(16),
                        ),
                        child: AnimatedScale(
                          scale: controller.isTaskZoomed.value ? 1.0 : 0.8,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          child: Stack(
                            children: [
                              // Use the same PendingTaskCard with expanded state
                              PendingTaskCard(
                                task: controller.zoomedTask.value!,
                                index: 0, // Index doesn't matter here
                                isExpanded: true, // Always expanded
                                onTap: () {}, // No toggle needed
                                onAccept: () {
                                  controller.acceptTask(controller.zoomedTask.value!);
                                  controller.closeZoomedTask();
                                },
                                onReject: () {
                                  controller.rejectTask(controller.zoomedTask.value!);
                                  controller.closeZoomedTask();
                                },
                                onDetails: () {
                                  Get.find<TaskListController>().goToTaskDetails(controller.zoomedTask.value!);
                                  controller.closeZoomedTask();
                                },
                              ),
                              // Close button overlay
                              Positioned(
                                top: Responsive.sp(8),
                                right: Responsive.sp(8),
                                child: GestureDetector(
                                  onTap: controller.closeZoomedTask,
                                  child: Container(
                                    padding: EdgeInsets.all(Responsive.sp(6)),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      size: Responsive.sp(18),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  
                  // Summary Title
                  _buildSummaryTitle(scale),
                  
                  SizedBox(height: 24 * scale),
                  
                  // Summary Cards
                  _buildSummarySection(scale),
                  
                  SizedBox(height: 28 * scale),
                  
                  // Task List with Tabs
                  _buildTaskSection(scale),
                  
                  // Space for bottom nav + device navigation
                  SizedBox(height: 100 * scale + MediaQuery.of(context).padding.bottom),
                ],
              ),
            );
          }),
        ),
      )),
    );
  }

  

  Widget _buildTitle(double scale) {
    return Text(
      'DASHBOARD',
      style: TextStyle(
        fontSize: 24 * scale,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryText,
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
                        AppColors.primary.withValues(alpha: 0.3),
                        AppColors.background.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.location_city,
                      size: 80 * scale,
                      color: AppColors.secondaryText.withValues(alpha: 0.3),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Task Card 1 (Top-left on buildings)
          Obx(() {
            if (controller.latest3DTasks.isNotEmpty) {
              return Positioned(
                top: 0,
                left: 65 * scale,
                child: _build3DTaskCard(controller.latest3DTasks[0], scale),
              );
            }
            return const SizedBox.shrink();
          }),
          
          // Task Card 2 (Center-right on buildings)
          Obx(() {
            if (controller.latest3DTasks.length > 1) {
              return Positioned(
                top: 110 * scale,
                left: 125 * scale,
                child: _build3DTaskCard(controller.latest3DTasks[1], scale),
              );
            }
            return const SizedBox.shrink();
          }),
          
          // Withdraw Button (bottom-right)
          Positioned(
            bottom: -20 * scale,
            right:10 * scale,
            child: _buildWithdrawButton(scale),
          ),
        ],
      ),
    );
  }

  Widget _build3DTaskCard(TaskModel task, double scale) {
    final isDark = Get.find<ThemeService>().isDarkMode.value;
    
    return GestureDetector(
      onTap: () {
        controller.zoomToTask(task);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 49 * scale,
        width: 161 * scale,
        decoration: BoxDecoration(
          // Dark mode: White cards, Light mode: Light cards with border
          color: isDark 
              ? Colors.white  // Solid white in dark mode
              : const Color(0xFFF5F5F5),  // Light gray in light mode
          borderRadius: BorderRadius.circular(7 * scale),
          border: Border.all(
            color: isDark 
                ? Colors.white.withOpacity(0.3)  // Subtle border in dark
                : AppColors.border.withOpacity(0.6),  // More visible border in light
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
              blurRadius: 10 * scale,
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
              child: SizedBox(
                width: 100 * scale,
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.bold,
                    color: isDark 
                        ? Colors.black  // Black text on white card in dark mode
                        : const Color(0xFF212121),  // Dark text on light card in light mode
                    letterSpacing: -0.15,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                  color: AppColors.primary,  // Solid purple button
                  borderRadius: BorderRadius.circular(15 * scale),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
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
                color: isDark 
                    ? Colors.black  // Black arrow on white card in dark mode
                    : const Color(0xFF212121),  // Dark arrow on light card in light mode
                size: 14 * scale,
              ),
            ),
          ],
        ),
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
        color: AppColors.primaryText,
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
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(6 * scale),
        border: Border.all(
          color: AppColors.border.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
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
            top: 15 * scale,
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
            bottom: 30 * scale,
            left: 0,
            right: 0,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10 * scale,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
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
                color: AppColors.primaryText,
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
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(6 * scale),
        border: Border.all(
          color: AppColors.border.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
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
            top: 18 * scale,
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
            bottom: 30 * scale,
            left: 0,
            right: 0,
            child: Text(
              'Balance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10 * scale,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
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
                  color: AppColors.primaryText,
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
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10 * scale),
        border: Border.all(
          color: AppColors.border.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
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
    final isDark = Get.find<ThemeService>().isDarkMode.value;
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 11 * scale),
      child: Container(
        padding: EdgeInsets.all(4 * scale),
        decoration: BoxDecoration(
          color: isDark ? Colors.transparent : const Color(0xFFFFFFFF).withOpacity(0.4),
          borderRadius: BorderRadius.circular(8 * scale),
        ),
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
            'Accepted',
            Icons.task_alt,
            controller.selectedFilter.value == 'accepted',
            () => controller.changeFilter('accepted'),
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
      ),
    );
  }

  Widget _buildTabItem(String title, IconData icon, bool isActive, VoidCallback onTap, double scale) {
    final isDark = Get.find<ThemeService>().isDarkMode.value;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30 * scale,
        padding: EdgeInsets.symmetric(
          horizontal: 17 * scale,
          vertical: 7 * scale,
        ),
        decoration: BoxDecoration(
          color: isActive 
              ? (isDark ? const Color(0xFF646397) : Color.fromARGB(255, 155, 104, 159))
              : (isDark ? AppColors.cardBackground.withOpacity(0.5) : const Color(0xFFFAFAFA)),
          borderRadius: BorderRadius.circular(6 * scale),
           border: !isActive ? Border.all(
             color: isDark ? AppColors.border.withOpacity(0.3) : AppColors.border.withOpacity(0.25),
             width: 1,
           ) : null,
           boxShadow: !isActive && !isDark ? [
             BoxShadow(
               color: Colors.black.withOpacity(0.06),
               blurRadius: 3,
               offset: const Offset(0, 1),
             ),
           ] : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13 * scale,
              color: isActive
                  ? isDark
                      ? AppColors.primaryText
                      : AppColors.textWhite
                  : AppColors.secondaryText,
            ),
            SizedBox(width: 6 * scale),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12 * scale,
                 color: isActive ?isDark? AppColors.primaryText : AppColors.textWhite: AppColors.secondaryText,
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
      // Show loading state if data is being loaded
      if (controller.isLoading.value && controller.recentTasks.isEmpty) {
        return Padding(
          padding: EdgeInsets.all(40 * scale),
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.info,
            ),
          ),
        );
      }
      
      final tasks = controller.filteredRecentTasks.take(3).toList();
      
      if (tasks.isEmpty) {
        return Padding(
          padding: EdgeInsets.all(40 * scale),
          child: Column(
            children: [
              Icon(
                Icons.task_alt,
                size: 48 * scale,
                color: AppColors.secondaryText.withOpacity(0.5),
              ),
              SizedBox(height: 12 * scale),
              Text(
                'No tasks available',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14 * scale,
                ),
              ),
              SizedBox(height: 4 * scale),
              Text(
                'Try changing the filter or check back later',
                style: TextStyle(
                  color: AppColors.secondaryText.withOpacity(0.7),
                  fontSize: 12 * scale,
                ),
              ),
            ],
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
                child: _buildTaskCard(task, index + 1),
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

  Widget _buildTaskCard(TaskModel task, int index) {
    // Show appropriate card based on task status
    if (task.isPending) {
      return Obx(() {
        final taskListController = Get.find<TaskListController>();
        final isExpanded = taskListController.isCardExpanded(task.id);
        
        return PendingTaskCard(
          task: task,
          index: index,
          isExpanded: isExpanded,
          onTap: () => taskListController.toggleCardExpansion(task.id),
          onAccept: () {
            taskListController.expandedTaskId.value = null;
            taskListController.acceptTask(task);
          },
          onReject: () {
            taskListController.expandedTaskId.value = null;
            taskListController.rejectTask(task);
          },
          onDetails: () => controller.goToTaskDetails(task),
        );
      });
    }
    
    if (task.isAccepted) {
      return AcceptedTaskCard(
        task: task,
        index: index,
        onDetails: () => controller.goToTaskDetails(task),
      );
    }
    
    // For submitted/completed tasks
    return SubmittedTaskCard(
      isExpanded: false,
      task: task,
      index: index,
      onTap: () => controller.goToTaskDetails(task),
    );
  }

  Widget _buildSeeMoreButton(double scale) {
    return GestureDetector(
      onTap: () {
        // Switch to tasks tab (index 1) in bottom navigation
        try {
          final navController = Get.find<MainNavigationController>();
          navController.changePage(1);
          
          // Set task list filter to match the current dashboard filter
          final taskController = Get.find<TaskListController>();
          taskController.filterTasks(controller.selectedFilter.value);
        } catch (e) {
          // Fallback to navigation if controllers not found
          Get.toNamed(AppRoutes.taskList);
        }
      },
      child: Container(
        width: 80 * scale,
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
