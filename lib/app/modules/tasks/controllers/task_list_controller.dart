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
  
  // Expanded card tracking
  final expandedTaskId = Rxn<String>(); // Track which card is expanded
  
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
    } else if (selectedFilter.value == 'accepted') {
      tempTasks = tempTasks.where((task) => task.status == 'accepted').toList();
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

      // Status filter
      if (advancedFilters.value['statuses'] != null) {
        final statuses = advancedFilters.value['statuses'] as List<String>;
        if (statuses.isNotEmpty) {
          tempTasks = tempTasks.where((task) {
            return statuses.any((status) => 
              task.status.toLowerCase() == status.toLowerCase()
            );
          }).toList();
        }
      }
    }

    filteredTasks.value = tempTasks;
  }

  void applyAdvancedFilters(Map<String, dynamic> filters) {
    print('🔍 Applying filters: $filters');
    advancedFilters.value = filters;
    print('🔍 Active filter chips: ${getActiveFilterChips()}');
    applyFilter();
  }

  void clearAdvancedFilters() {
    advancedFilters.value = {};
    applyFilter();
  }

  // Get active filter chips
  List<Map<String, String>> getActiveFilterChips() {
    final chips = <Map<String, String>>[];
    
    // Add location filters
    if (advancedFilters.value['locations'] != null) {
      final locations = advancedFilters.value['locations'] as List<String>;
      for (var location in locations) {
        chips.add({
          'label': location,
          'type': 'location',
        });
      }
    }
    
    // Add task name filters
    if (advancedFilters.value['taskNames'] != null) {
      final taskNames = advancedFilters.value['taskNames'] as List<String>;
      for (var name in taskNames) {
        chips.add({
          'label': name,
          'type': 'taskName',
        });
      }
    }
    
    // Add date range filter
    if (advancedFilters.value['startDate'] != null && advancedFilters.value['endDate'] != null) {
      final startDate = advancedFilters.value['startDate'] as DateTime;
      final endDate = advancedFilters.value['endDate'] as DateTime;
      final dateLabel = '${startDate.day}-${endDate.day} ${_getMonthName(startDate.month)} ${startDate.year.toString().substring(2)}';
      chips.add({
        'label': dateLabel,
        'type': 'dateRange',
      });
    }
    
    // Add status filters
    if (advancedFilters.value['statuses'] != null) {
      final statuses = advancedFilters.value['statuses'] as List<String>;
      for (var status in statuses) {
        chips.add({
          'label': status,
          'type': 'status',
        });
      }
    }
    
    return chips;
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  // Remove a specific filter chip
  void removeFilterChip(Map<String, String> chip) {
    final filters = Map<String, dynamic>.from(advancedFilters.value);
    
    if (chip['type'] == 'location') {
      if (filters['locations'] != null) {
        final locations = List<String>.from(filters['locations']);
        locations.remove(chip['label']);
        if (locations.isEmpty) {
          filters.remove('locations');
        } else {
          filters['locations'] = locations;
        }
      }
    } else if (chip['type'] == 'taskName') {
      if (filters['taskNames'] != null) {
        final taskNames = List<String>.from(filters['taskNames']);
        taskNames.remove(chip['label']);
        if (taskNames.isEmpty) {
          filters.remove('taskNames');
        } else {
          filters['taskNames'] = taskNames;
        }
      }
    } else if (chip['type'] == 'status') {
      if (filters['statuses'] != null) {
        final statuses = List<String>.from(filters['statuses']);
        statuses.remove(chip['label']);
        if (statuses.isEmpty) {
          filters.remove('statuses');
        } else {
          filters['statuses'] = statuses;
        }
      }
    } else if (chip['type'] == 'dateRange') {
      filters.remove('startDate');
      filters.remove('endDate');
    }
    
    advancedFilters.value = filters;
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

  void toggleCardExpansion(String taskId) {
    if (expandedTaskId.value == taskId) {
      expandedTaskId.value = null; // Collapse if already expanded
    } else {
      expandedTaskId.value = taskId; // Expand this card
    }
  }

  bool isCardExpanded(String taskId) {
    return expandedTaskId.value == taskId;
  }

  void goToTaskDetails(TaskModel task) {
    Get.toNamed(AppRoutes.taskDetails, arguments: {'task': task});
  }

  // Accept/Reject task methods for task list
  Future<void> acceptTask(TaskModel task) async {
    try {
      // TODO: Call API to accept task
      // await ApiService.acceptTask(task.id);
      
      // Update task status locally (this will be replaced by API response)
      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          location: task.location,
          imageUrl: task.imageUrl,
          reward: task.reward,
          status: 'accepted', // Change status to accepted
          deadline: task.deadline,
          views: task.views,
          submissionStatus: task.submissionStatus,
          submittedStatus: task.submittedStatus,
          submittedAt: task.submittedAt,
        );
      }
      
      // Refresh filtered tasks
      applyFilter();
      
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
      
      // Refresh task list
      await loadTasks();
      
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


