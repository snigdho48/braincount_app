import 'package:get/get.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/api_service.dart';
import '../../../routes/app_routes.dart';

class TaskListController extends GetxController {
  final tasks = <TaskModel>[].obs;
  final filteredTasks = <TaskModel>[].obs;
  final isLoading = false.obs;
  final selectedFilter = 'all'.obs;

  @override
  void onInit() {
    super.onInit();
    final status = Get.arguments?['status'] ?? 'all';
    selectedFilter.value = status;
    loadTasks();
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

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    loadTasks();
  }

  void applyFilter() {
    if (selectedFilter.value == 'all') {
      filteredTasks.value = tasks;
    } else {
      filteredTasks.value =
          tasks.where((task) => task.status == selectedFilter.value).toList();
    }
  }

  void goToTaskDetails(TaskModel task) {
    Get.toNamed(AppRoutes.taskDetails, arguments: {'task': task});
  }
}


