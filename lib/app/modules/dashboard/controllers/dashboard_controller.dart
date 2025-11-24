import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/dashboard_stats_model.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/services/api_service.dart';
import '../../../routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';

class DashboardController extends GetxController {
  final currentUser = Rxn<UserModel>();
  final stats = Rxn<DashboardStatsModel>();
  final recentTasks = <TaskModel>[].obs;
  final latest3DTasks = <TaskModel>[].obs; // Latest 2 tasks for 3D view
  final isLoading = false.obs;
  final selectedTab = 0.obs;
  final selectedFilter = 'all'.obs; // For task filtering - default to 'all' to show all tasks
  
  // 3D card zoom state
  final isTaskZoomed = false.obs;
  final zoomedTask = Rxn<TaskModel>();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    loadDashboardData();
  }

  Future<void> loadUserData() async {
    final user = await StorageService.getUser();
    if (user != null) {
      currentUser.value = user;
      
      // Update balance from dashboard stats
      try {
        final stats = await ApiService.getDashboardStats();
        if (stats.balance != user.balance) {
          final updatedUser = user.copyWith(balance: stats.balance);
          await StorageService.saveUser(updatedUser);
          currentUser.value = updatedUser;
        }
      } catch (e) {
        // If API fails, keep existing user data
      }
    }
  }

  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;
      
      // Load all tasks so filters work properly
      final [statsData, allTasksResponse] = await Future.wait([
        ApiService.getDashboardStats(),
        ApiService.getTasks(status: 'all', page: 1, pageSize: 100),  // Get first 100 tasks for filtering
      ]);

      stats.value = statsData as DashboardStatsModel;
      
      // Extract tasks from paginated response
      final responseMap = allTasksResponse as Map<String, dynamic>;
      final tasksList = ((responseMap['results'] ?? responseMap['tasks'] ?? []) as List)
          .map((task) => TaskModel.fromJson(task as Map<String, dynamic>))
          .toList();
      
      // Always use all tasks from API for better filtering
      // The stats recentTasks might be limited, so we use all tasks
      recentTasks.value = tasksList;
      
      // If no tasks from API, try to use recent tasks from stats as fallback
      if (recentTasks.isEmpty && statsData.recentTasks != null && statsData.recentTasks!.isNotEmpty) {
        recentTasks.value = statsData.recentTasks!;
      }
      
      // Get latest 2 pending tasks for 3D view
      final pendingTasks = tasksList
          .where((task) => task.isPending)
          .toList();
      latest3DTasks.value = pendingTasks.take(2).toList();
    } catch (e) {
      // Show error to user
      Get.snackbar(
        'Error',
        'Failed to load dashboard data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    // No need to reload - filtering is done by the getter
    // The filteredRecentTasks getter will automatically update when selectedFilter changes
  }
  
  List<TaskModel> get filteredRecentTasks {
    List<TaskModel> filtered;
    
    if (selectedFilter.value == 'all') {
      // Show all tasks except rejected ones
      filtered = recentTasks.where((task) => !task.isRejected).toList();
    } else if (selectedFilter.value == 'pending') {
      filtered = recentTasks.where((task) => task.isPending).toList();
    } else if (selectedFilter.value == 'accepted') {
      // Accepted but not yet submitted
      filtered = recentTasks.where((task) => task.status == 'accepted' && !task.isSubmitted).toList();
    } else if (selectedFilter.value == 'submitted') {
      // Submitted tasks (status='submitted' or isSubmitted flag is true)
      filtered = recentTasks.where((task) => task.isSubmittedTask).toList();
    } else {
      // Default: show all except rejected
      filtered = recentTasks.where((task) => !task.isRejected).toList();
    }
    
    // Sort by creation date (most recent first) and return
    filtered.sort((a, b) {
      // Sort pending tasks first, then by date
      if (a.isPending && !b.isPending) return -1;
      if (!a.isPending && b.isPending) return 1;
      if (a.deadline != null && b.deadline != null) {
        return b.deadline!.compareTo(a.deadline!);
      }
      return 0;
    });
    
    return filtered;
  }

  void goToTaskDetails(TaskModel task) {
    Get.toNamed(
      AppRoutes.taskDetails,
      arguments: {'task': task},
    );
  }

  void goToWithdraw() {
    Get.toNamed(AppRoutes.balanceHistory);
  }

  void goToSettings() {
    // Navigate to settings
  }

  Future<void> logout() async {
    await StorageService.clearAll();
    Get.offAllNamed(AppRoutes.login);
  }

  // 3D Card zoom methods
  void zoomToTask(TaskModel task) {
    zoomedTask.value = task;
    isTaskZoomed.value = true;
  }

  void closeZoomedTask() {
    isTaskZoomed.value = false;
    Future.delayed(const Duration(milliseconds: 300), () {
      zoomedTask.value = null;
    });
  }

  // Accept/Reject task methods
  Future<void> acceptTask(TaskModel task) async {
    try {
      final response = await ApiService.acceptTask(task.id);
      
      if (response['success'] == true) {
        closeZoomedTask();
        
        // Change filter to 'accepted' to show the accepted task
        selectedFilter.value = 'accepted';
        
        // Refresh dashboard data (API will return updated status)
        await loadDashboardData();
        
        Get.snackbar(
          'Task Accepted',
          response['message'] ?? 'You can now submit "${task.title}"',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.success,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to accept task',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      String errorMsg = 'Failed to accept task';
      if (e.toString().isNotEmpty && !e.toString().contains('Exception: ')) {
        errorMsg = e.toString().replaceFirst('Exception: ', '');
      }
      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    }
  }

  Future<void> rejectTask(TaskModel task) async {
    try {
      final response = await ApiService.rejectTask(task.id);
      
      if (response['success'] == true) {
        closeZoomedTask();
        
        // Change filter to 'all' to show remaining tasks (rejected tasks are filtered out)
        selectedFilter.value = 'all';
        
        // Refresh dashboard data
        await loadDashboardData();
        
        Get.snackbar(
          'Task Rejected',
          response['message'] ?? 'You have rejected "${task.title}"',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.warning,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to reject task',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      String errorMsg = 'Failed to reject task';
      if (e.toString().isNotEmpty && !e.toString().contains('Exception: ')) {
        errorMsg = e.toString().replaceFirst('Exception: ', '');
      }
      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    }
  }
}


