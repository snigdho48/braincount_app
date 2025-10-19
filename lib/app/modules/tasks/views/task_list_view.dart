import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_list_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/task_card.dart';
import '../../../widgets/brain_loader.dart';

class TaskListView extends GetView<TaskListController> {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              // Filters
              _buildFilters(),
              // Task List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const BrainLoader(message: 'Loading tasks...');
                  }

                  if (controller.filteredTasks.isEmpty) {
                    return const Center(
                      child: Text(
                        'No tasks found',
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: controller.loadTasks,
                    color: AppColors.primary,
                    backgroundColor: AppColors.cardBackground,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: controller.filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = controller.filteredTasks[index];
                        return TaskCard(
                          task: task,
                          onTap: () => controller.goToTaskDetails(task),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.textWhite,
            ),
          ),
          const Expanded(
            child: Text(
              'Task Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              const Text(
                'Filter',
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter_list,
                  color: AppColors.textWhite,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(() => Row(
            children: [
              _buildFilterTab('Task List', 'all'),
              const SizedBox(width: 8),
              _buildFilterTab('Pending', 'pending'),
              const SizedBox(width: 8),
              _buildFilterTab('Submitted', 'submitted'),
            ],
          )),
    );
  }

  Widget _buildFilterTab(String label, String value) {
    final isSelected = controller.selectedFilter.value == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeFilter(value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.cardDark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                value == 'all'
                    ? Icons.list
                    : value == 'pending'
                        ? Icons.pending_actions
                        : Icons.task_alt,
                color: AppColors.textWhite,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


