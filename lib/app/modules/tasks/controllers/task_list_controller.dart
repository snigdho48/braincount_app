import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/api_service.dart';
import '../../../routes/app_routes.dart';

class TaskListController extends GetxController {
  final tasks = <TaskModel>[].obs;
  final filteredTasks = <TaskModel>[].obs;
  final isLoading = false.obs;
  final selectedFilter = 'all'.obs;
  final searchController = TextEditingController();
  final searchQuery = ''.obs;
  final advancedFilters = Rx<Map<String, dynamic>>({});
  
  // User data (reactive for API)
  final userName = 'NAFSIN RAHMAN'.obs;
  final userId = '34874'.obs;
  final userAvatar = 'assets/figma_exports/52ec367639c91dd0186e7c21dba64d8ed1375a47.png'.obs;
  
  RxString get currentFilter => selectedFilter; // Alias for selectedFilter

  @override
  void onInit() {
    super.onInit();
    final status = Get.arguments?['status'] ?? 'all';
    selectedFilter.value = status;
    loadUserData();
    loadTasks();
  }

  /// Load user data from API
  Future<void> loadUserData() async {
    try {
      // TODO: Replace with actual API call when ready
      // final user = await ApiService.getCurrentUser();
      // userName.value = user.name;
      // userId.value = user.id.toString();
      // userAvatar.value = user.avatarUrl ?? userAvatar.value;
      
      // For now, using default values
      // This will automatically update the UI when API is connected
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> loadTasks() async {
    try {
      isLoading.value = true;
      final taskList = await ApiService.getTasks(status: selectedFilter.value);
      tasks.value = taskList;
      applyFilter();
    } catch (e) {
      print('Error loading tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterTasks(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    loadTasks();
  }

  void applyFilter() {
    var tempTasks = tasks.toList();

    // Apply status filter
    if (selectedFilter.value == 'pending') {
      tempTasks = tempTasks.where((task) => task.status == 'pending').toList();
    } else if (selectedFilter.value == 'submitted') {
      tempTasks = tempTasks.where((task) => task.status == 'submitted' || task.status == 'completed').toList();
    }
    // 'all' shows everything, no filter needed

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      tempTasks = tempTasks.where((task) {
        final query = searchQuery.value.toLowerCase();
        return task.title.toLowerCase().contains(query) ||
               task.id.toString().contains(query) ||
               task.description.toLowerCase().contains(query);
      }).toList();
    }

    // Apply advanced filters
    if (advancedFilters.value.isNotEmpty) {
      // Task name filter
      if (advancedFilters.value['taskNames'] != null) {
        final taskNames = advancedFilters.value['taskNames'] as List<String>;
        if (taskNames.isNotEmpty) {
          tempTasks = tempTasks.where((task) {
            return taskNames.any((name) => task.title.toLowerCase().contains(name.toLowerCase()));
          }).toList();
        }
      }

      // Location filter
      if (advancedFilters.value['locations'] != null) {
        final locations = advancedFilters.value['locations'] as List<String>;
        if (locations.isNotEmpty) {
          tempTasks = tempTasks.where((task) {
            return locations.any((location) => 
              task.location.toLowerCase().contains(location.toLowerCase())
            );
          }).toList();
        }
      }

      // Date range filter
      if (advancedFilters.value['startDate'] != null && advancedFilters.value['endDate'] != null) {
        final startDate = advancedFilters.value['startDate'] as DateTime;
        final endDate = advancedFilters.value['endDate'] as DateTime;
        tempTasks = tempTasks.where((task) {
          if (task.deadline == null) return false;
          return task.deadline!.isAfter(startDate.subtract(const Duration(days: 1))) &&
                 task.deadline!.isBefore(endDate.add(const Duration(days: 1)));
        }).toList();
      }
    }

    filteredTasks.value = tempTasks;
  }

  void applyAdvancedFilters(Map<String, dynamic> filters) {
    advancedFilters.value = filters;
    applyFilter();
  }

  void clearAdvancedFilters() {
    advancedFilters.value = {};
    applyFilter();
  }

  void searchTasks(String query) {
    searchQuery.value = query;
    applyFilter();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    applyFilter();
  }

  void goToTaskDetails(TaskModel task) {
    Get.toNamed(AppRoutes.taskDetails, arguments: {'task': task});
  }
}


