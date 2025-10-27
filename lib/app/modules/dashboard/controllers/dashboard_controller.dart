import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/dashboard_stats_model.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/services/api_service.dart';
import '../../../routes/app_routes.dart';

class DashboardController extends GetxController {
  final currentUser = Rxn<UserModel>();
  final stats = Rxn<DashboardStatsModel>();
  final recentTasks = <TaskModel>[].obs;
  final latest3DTasks = <TaskModel>[].obs; // Latest 2 tasks for 3D view
  final isLoading = false.obs;
  final selectedTab = 0.obs;
  final selectedFilter = 'submitted'.obs; // For task filtering
  
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
    }
  }

  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;
      
      final [statsData, submittedTasksData, allTasksData] = await Future.wait([
        ApiService.getDashboardStats(),
        ApiService.getTasks(status: 'submitted'),
        ApiService.getTasks(status: 'all'),  // Get all tasks for 3D view
      ]);

      stats.value = statsData as DashboardStatsModel;
      recentTasks.value = (submittedTasksData as List<TaskModel>).take(3).toList();
      
      // Get latest 2 pending tasks for 3D view
      final pendingTasks = (allTasksData as List<TaskModel>)
          .where((task) => task.isPending)
          .toList();
      latest3DTasks.value = pendingTasks.take(2).toList();
    } catch (e) {
      print('Error loading dashboard: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    loadDashboardData(); // Reload tasks with new filter
  }
  
  List<TaskModel> get filteredRecentTasks {
    if (selectedFilter.value == 'all') {
      return recentTasks.toList();
    } else if (selectedFilter.value == 'pending') {
      return recentTasks.where((task) => task.isPending).toList();
    } else if (selectedFilter.value == 'accepted') {
      return recentTasks.where((task) => task.isAccepted).toList();
    } else if (selectedFilter.value == 'submitted') {
      return recentTasks.where((task) => task.isSubmitted || task.isCompleted).toList();
    }
    return recentTasks.toList();
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
      // TODO: Call API to accept task
      // await ApiService.acceptTask(task.id);
      
      closeZoomedTask();
      
      // Refresh dashboard data (API will return updated status)
      await loadDashboardData();
      
      Get.snackbar(
        'Task Accepted',
        'You can now submit "${task.title}"',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error accepting task: $e');
      Get.snackbar(
        'Error',
        'Failed to accept task',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> rejectTask(TaskModel task) async {
    try {
      // TODO: Call API to reject task
      // await ApiService.rejectTask(task.id);
      
      closeZoomedTask();
      
      // Refresh dashboard data
      await loadDashboardData();
      
      Get.snackbar(
        'Task Rejected',
        'You have rejected "${task.title}"',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error rejecting task: $e');
      Get.snackbar(
        'Error',
        'Failed to reject task',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}


