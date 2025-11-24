import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/api_service.dart';
import '../../../routes/app_routes.dart';

class TaskListController extends GetxController {
  final tasks = <TaskModel>[].obs;
  final filteredTasks = <TaskModel>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs; // For pagination loading
  final selectedFilter = 'all'.obs;
  final searchController = TextEditingController();
  final searchQuery = ''.obs;
  final advancedFilters = Rx<Map<String, dynamic>>({});
  
  // Pagination state
  final currentPage = 1.obs;
  final hasNextPage = false.obs;
  final totalCount = 0.obs;
  final pageSize = 10;
  
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
    loadTasks(reset: true);
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
      // Error handled silently
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> loadTasks({bool reset = true}) async {
    try {
      if (reset) {
        isLoading.value = true;
        currentPage.value = 1;
        tasks.value = [];
      } else {
        isLoadingMore.value = true;
      }
      
      final response = await ApiService.getTasks(
        status: selectedFilter.value,
        page: currentPage.value,
        pageSize: pageSize,
      );
      
      final tasksList = (response['results'] ?? response['tasks'] ?? []) as List;
      final newTasks = tasksList
          .map((task) => TaskModel.fromJson(task))
          .toList();
      
      if (reset) {
        tasks.value = newTasks;
      } else {
        tasks.addAll(newTasks);
      }
      
      // Update pagination state
      totalCount.value = response['count'] ?? 0;
      hasNextPage.value = response['next'] != null;
      
      applyFilter();
      
      // Show success message if no tasks found (informational)
      if (tasks.isEmpty && selectedFilter.value != 'all' && reset) {
        Get.snackbar(
          'No Tasks',
          'No ${selectedFilter.value} tasks found',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      // Extract error message
      String errorString = e.toString();
      
      // Show user-friendly error message
      String errorMessage = 'Failed to load tasks';
      
      // Check for specific error patterns
      if (errorString.isEmpty || errorString == 'Exception: ') {
        errorMessage = 'Network error. Please check your connection and try again.';
      } else if (errorString.toLowerCase().contains('connection') || 
                 errorString.toLowerCase().contains('network') ||
                 errorString.toLowerCase().contains('socket') ||
                 errorString.toLowerCase().contains('connection refused')) {
        errorMessage = 'Network error. Please check your internet connection.';
      } else if (errorString.contains('401') || errorString.toLowerCase().contains('unauthorized')) {
        errorMessage = 'Session expired. Please login again.';
      } else if (errorString.contains('403') || errorString.toLowerCase().contains('forbidden')) {
        errorMessage = 'You do not have permission to view tasks.';
      } else if (errorString.contains('404') || errorString.toLowerCase().contains('not found')) {
        errorMessage = 'Tasks endpoint not found.';
      } else if (errorString.contains('500') || errorString.toLowerCase().contains('server')) {
        errorMessage = 'Server error. Please try again later.';
      } else if (errorString.contains('timeout')) {
        errorMessage = 'Request timeout. Please try again.';
      } else {
        // Extract actual error message if available
        final match = RegExp(r'Exception:\s*(.+)').firstMatch(errorString);
        if (match != null && match.group(1)?.isNotEmpty == true) {
          errorMessage = match.group(1)!;
        } else if (errorString.length > 20) {
          // Use error string if it's meaningful
          errorMessage = errorString.replaceFirst('Exception: ', '');
        }
      }
      
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  // Load more tasks (pagination)
  Future<void> loadMoreTasks() async {
    if (isLoadingMore.value || !hasNextPage.value) {
      return; // Already loading or no more pages
    }
    
    currentPage.value++;
    await loadTasks(reset: false);
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
      // Accepted but not yet submitted
      tempTasks = tempTasks.where((task) => task.status == 'accepted' && !task.isSubmitted).toList();
    } else if (selectedFilter.value == 'submitted') {
      // Submitted tasks
      tempTasks = tempTasks.where((task) => task.isSubmittedTask).toList();
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
    advancedFilters.value = filters;
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
      final response = await ApiService.acceptTask(task.id);
      
      if (response['success'] == true) {
        // Change filter to 'accepted' to show the accepted task
        selectedFilter.value = 'accepted';
        
        // Refresh task list to get updated status
        await loadTasks();
        
        Get.snackbar(
          'Task Accepted',
          response['message'] ?? 'You can now submit "${task.title}"',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to accept task',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
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
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    }
  }

  Future<void> rejectTask(TaskModel task) async {
    try {
      final response = await ApiService.rejectTask(task.id);
      
      if (response['success'] == true) {
        // If currently viewing pending tasks, switch to 'all' to show remaining tasks
        // (rejected tasks won't show in pending filter anymore)
        if (selectedFilter.value == 'pending') {
          selectedFilter.value = 'all';
        }
        
        // Refresh task list to get updated status
        await loadTasks();
        
        Get.snackbar(
          'Task Rejected',
          response['message'] ?? 'You have rejected "${task.title}"',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.secondary,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to reject task',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
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
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    }
  }
}


