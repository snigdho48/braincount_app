import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_list_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/brain_loader.dart';
import '../widgets/task_filter_modal.dart';
import '../widgets/submitted_task_card.dart';
import '../../../widgets/user_header.dart';

class TaskListView extends GetView<TaskListController> {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF232323), // As per Figma
        ),
        child: SafeArea(
          child: Column(
            children: [
              // User Header
              UserHeader(scale: Responsive.scaleWidth(393.0)),
              
              // Title with back button
              _buildTitleBar(),
              
              // Search and Filter
              _buildSearchFilter(),
              
              // Tab Filters
              _buildTabFilters(),
              
              // Task List Container
              Expanded(
                child: _buildTaskListContainer(),
              ),
            ],
          ),
        ),
      ),
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
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(Responsive.sp(2)),
                child: Image.asset(
                  'assets/figma_exports/ba6ed2fd049b915b810f85dd2105488af57baf59.svg',
                  width: Responsive.sp(18),
                  height: Responsive.sp(14),
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.textWhite,
                    size: Responsive.sp(18),
                  ),
                ),
              ),
            ),
          ),
          
          // Title
          Text(
            'Task Details',
            style: TextStyle(
              fontSize: Responsive.fontSize(20),
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
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
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(Responsive.sp(8)),
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
                    color: AppColors.textWhite,
                    size: Responsive.sp(18),
                  ),
                ),
                SizedBox(width: Responsive.sp(15)),
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(12),
                      color: AppColors.textWhite,
                      letterSpacing: 0.24,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: Responsive.fontSize(12),
                        color: AppColors.textWhite.withValues(alpha: 0.5),
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
                    color: AppColors.textWhite,
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
    return Container(
      margin: EdgeInsets.only(
      // Container margin + padding + left offset from Figma
        top: Responsive.smVertical,
        bottom: Responsive.smVertical,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTabItem(
            'Task List',
            'assets/figma_exports/8aa6fba88f740008d70c33a46ba833ba49188fb8.svg',
            controller.selectedFilter.value == 'all',
            () => controller.filterTasks('all'),
          ),
          SizedBox(width: Responsive.sp(6)),
          _buildTabItem(
            'Pending',
            'assets/figma_exports/d62224f98de08e0db9c557c2ceb68c638014c840.svg',
            controller.selectedFilter.value == 'pending',
            () => controller.filterTasks('pending'),
          ),
          SizedBox(width: Responsive.sp(6)),
          _buildTabItem(
            'Submitted',
            'assets/figma_exports/cfead7e94754971181d0ed1a699867244aa04b4c.svg',
            controller.selectedFilter.value == 'submitted',
            () => controller.filterTasks('submitted'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, String iconPath, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Responsive.sp(109), // Fixed width as per Figma
        height: Responsive.sp(30),
        padding: EdgeInsets.symmetric(
          vertical: Responsive.sp(7),
        ),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF646397) : Colors.transparent,
          borderRadius: BorderRadius.circular(Responsive.sp(6)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              width: Responsive.sp(title == 'Task List' ? 11.27 : 13),
              height: Responsive.sp(title == 'Task List' ? 13.338 : 12),
              color: isActive ? AppColors.textWhite : const Color(0xFF6B7C97),
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.list,
                size: Responsive.sp(12),
                color: isActive ? AppColors.textWhite : const Color(0xFF6B7C97),
              ),
            ),
            SizedBox(width: Responsive.sp(11)),
            Text(
              title,
              style: TextStyle(
                fontSize: Responsive.fontSize(12),
                color: isActive ? AppColors.textWhite : const Color(0xFF6B7C97),
                letterSpacing: 0.24,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskListContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.sp(7)),
      padding: EdgeInsets.all(Responsive.sp(11)),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(Responsive.sp(10)),
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
                color: AppColors.textGrey,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.filteredTasks.length,
          itemBuilder: (context, index) {
            final task = controller.filteredTasks[index];
            return SubmittedTaskCard(
              task: task,
              index: index,
              onTap: () => controller.goToTaskDetails(task),
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
