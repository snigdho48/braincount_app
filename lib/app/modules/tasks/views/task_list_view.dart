import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_list_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/brain_loader.dart';
import '../widgets/task_filter_modal.dart';
import '../widgets/submitted_task_card.dart';
import '../widgets/pending_task_card.dart';
import '../widgets/accepted_task_card.dart';
import '../../../data/services/theme_service.dart';

class TaskListView extends GetView<TaskListController> {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          bottom: false,  // Don't apply SafeArea to bottom, we'll handle it manually
          child: Column(
            children: [
              // User Header
              // UserHeader(scale: Responsive.scaleWidth(393.0)),
              
              // Title with back button
              _buildTitleBar(),
              
              // Search and Filter
              _buildSearchFilter(),
              
              // Tab Filters
              _buildTabFilters(),
              
              // Selected Filter Chips (from Figma design)
              Obx(() {
                // Watch advancedFilters to trigger rebuild when filters change
                controller.advancedFilters.value;
                final chips = controller.getActiveFilterChips();
                if (chips.isEmpty) return const SizedBox.shrink();
                return _buildSelectedFilterChips(chips);
              }),
              
              // Task List Container (no Expanded, auto-sizes)
             _buildTaskListContainer(),
            ],
          ),
        ),
      )),
    );
  }


  Widget _buildTitleBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.md,
        vertical: Responsive.smVertical,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back button
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: GestureDetector(
          //     onTap: () => Get.back(),
          //     child: Container(
          //       padding: EdgeInsets.all(Responsive.sp(2)),
          //       child: Image.asset(
          //         'assets/figma_exports/ba6ed2fd049b915b810f85dd2105488af57baf59.svg',
          //         width: Responsive.sp(18),
          //         height: Responsive.sp(14),
          //         errorBuilder: (context, error, stackTrace) => Icon(
          //           Icons.arrow_back_ios,
          //           color: AppColors.textWhite,
          //           size: Responsive.sp(18),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          
          // Title
          Text(
            'Task Details',
            style: TextStyle(
              fontSize: Responsive.fontSize(20),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFilter() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.sp(7),
        vertical: Responsive.smVertical,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.sp(15),
        vertical: Responsive.sp(5),
      ),
      height: Responsive.sp(43),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(Responsive.sp(8)),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search icon and input field
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  'assets/figma_exports/146223f13eae8b4dd341985b6ba9249c05aaf196.svg',
                  width: Responsive.sp(18),
                  height: Responsive.sp(18),
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.search,
                    color: AppColors.primaryText,
                    size: Responsive.sp(18),
                  ),
                ),
                SizedBox(width: Responsive.sp(15)),
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(12),
                      color: AppColors.primaryText,
                      letterSpacing: 0.24,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: Responsive.fontSize(12),
                        color: AppColors.secondaryText,
                        letterSpacing: 0.24,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) => controller.searchTasks(value),
                  ),
                ),
              ],
            ),
          ),
          
          // Filter
          Row(
            children: [
              Obx(() => Text(
                    controller.currentFilter.value == 'all'
                        ? 'All'
                        : controller.currentFilter.value == 'pending'
                            ? 'Pending'
                            : 'Submitted',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(12),
                      color: const Color(0xFF838383),
                      letterSpacing: 0.24,
                    ),
                  )),
              SizedBox(width: Responsive.sp(11)),
              GestureDetector(
                onTap: () => _showFilterModal(),
                child: Image.asset(
                  'assets/figma_exports/67a6248f2096d2b2d0548a4eea19bd790cdc22b3.svg',
                  width: Responsive.sp(15),
                  height: Responsive.sp(15),
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.filter_alt,
                    color: AppColors.primaryText,
                    size: Responsive.sp(15),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabFilters() {
    final isDark = Get.find<ThemeService>().isDarkMode.value;
    final scale = Responsive.scaleWidth(393.0);

    return Container(
      margin: EdgeInsets.only(
      // Container margin + padding + left offset from Figma
        top: Responsive.smVertical,
        bottom: Responsive.smVertical,
      ),
      height: 38 * scale,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Responsive.sp(10)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Responsive.sp(10), vertical: Responsive.sp(4)),
          decoration: BoxDecoration(
            color: isDark ? Colors.transparent : const Color(0xFFFFFFFF).withOpacity(0.4),
            borderRadius: BorderRadius.circular(Responsive.sp(8)),
          ),
          child: Row(
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
          ),
        ),
      ),
    );
  }

  // Selected Filter Chips - Matches Figma Design exactly
  Widget _buildSelectedFilterChips(List<Map<String, String>> chips) {
    return Container(
      margin: EdgeInsets.only(
        left: Responsive.sp(12),
        right: Responsive.sp(16),
        top: Responsive.sp(12),
        bottom: Responsive.sp(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < chips.length; i++) ...[
              _buildFilterChip(chips[i]),
              if (i < chips.length - 1) SizedBox(width: Responsive.sp(12)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(Map<String, String> chip) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.sp(12),
        vertical: Responsive.sp(3),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D), // Exact color from Figma
        borderRadius: BorderRadius.circular(Responsive.sp(15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            chip['label']!,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: Responsive.fontSize(14),
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.5,
            ),
          ),
          SizedBox(width: Responsive.sp(10)),
          GestureDetector(
            onTap: () => controller.removeFilterChip(chip),
            child: Container(
              width: Responsive.sp(10),
              height: Responsive.sp(10),
              alignment: Alignment.center,
              child: Icon(
                Icons.close,
                size: Responsive.sp(10),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildTabItem(String title, IconData icon, bool isActive,
      VoidCallback onTap, double scale) {
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
              ? (isDark
                  ? const Color(0xFF646397)
                  : Color.fromARGB(255, 155, 104, 159))
              : (isDark
                  ? AppColors.cardBackground.withOpacity(0.5)
                  : const Color(0xFFFAFAFA)),
          borderRadius: BorderRadius.circular(6 * scale),
          border: !isActive
              ? Border.all(
                  color: isDark
                      ? AppColors.border.withOpacity(0.3)
                      : AppColors.border.withOpacity(0.25),
                  width: 1,
                )
              : null,
          boxShadow: !isActive && !isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
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
                  color: isActive
                      ? isDark
                          ? AppColors.primaryText
                          : AppColors.textWhite
                      : AppColors.secondaryText,
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


  Widget _buildTaskListContainer() {
    return Container(
      margin: EdgeInsets.only(
        left: Responsive.sp(7),
        right: Responsive.sp(7),
        bottom: MediaQuery.of(Get.context!).padding.bottom + Responsive.sp(80),  // Bottom nav + device nav
      ),
      constraints:  BoxConstraints(
        maxHeight: Get.height * .8,
      ),
      padding: EdgeInsets.all(Responsive.sp(11)),
      decoration: BoxDecoration(
        
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(Responsive.sp(10)),
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
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: BrainLoader(message: 'Loading tasks...'));
        }

        if (controller.filteredTasks.isEmpty) {
          return Center(
            child: Text(
              'No tasks found',
              style: TextStyle(
                fontSize: Responsive.fontSize(14),
                color: AppColors.secondaryText,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: controller.filteredTasks.length,
          itemBuilder: (context, index) {
            final task = controller.filteredTasks[index];
            // Show PendingTaskCard with Accept/Reject buttons for pending tasks
            if (task.isPending) {
              // Wrap only pending cards in Obx for expansion
              return Obx(() {
                final isExpanded = controller.isCardExpanded(task.id);
                return PendingTaskCard(
                  task: task,
                  index: index,
                  isExpanded: isExpanded,
                  onTap: () => controller.toggleCardExpansion(task.id),
                  onAccept: () {
                    controller.expandedTaskId.value = null; // Collapse card
                    controller.acceptTask(task);
                  },
                  onReject: () {
                    controller.expandedTaskId.value = null; // Collapse card
                    controller.rejectTask(task);
                  },
                  onDetails: () => controller.goToTaskDetails(task),
                );
              });
            }
            
            // Show accepted tasks with Submit button
            if (task.isAccepted) {
              return AcceptedTaskCard(
                task: task,
                index: index,
                onDetails: () => controller.goToTaskDetails(task),
              );
            }
            
            // Show SubmittedTaskCard for submitted/completed tasks (navigate directly)
            return SubmittedTaskCard(
              task: task,
              index: index,
              isExpanded: false,  // Never expand submitted tasks
              onTap: () => controller.goToTaskDetails(task),  // Navigate directly to details
              onDetails: () => controller.goToTaskDetails(task),
            );
          },
        );
      }),
    );
  }

  void _showFilterModal() {
    Get.bottomSheet(
      TaskFilterModal(
        onApply: (filters) {
          controller.applyAdvancedFilters(filters);
        },
        initialFilters: controller.advancedFilters.value,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
    );
  }
}
