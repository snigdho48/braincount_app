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
  final isLoading = false.obs;
  final selectedTab = 0.obs;
  final selectedFilter = 'submitted'.obs; // For task filtering

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
      
      final [statsData, tasksData] = await Future.wait([
        ApiService.getDashboardStats(),
        ApiService.getTasks(status: 'submitted'),
      ]);

      stats.value = statsData as DashboardStatsModel;
      recentTasks.value = (tasksData as List<TaskModel>).take(3).toList();
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
    // Optionally reload tasks based on filter
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
}


