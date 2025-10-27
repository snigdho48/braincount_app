import 'package:get/get.dart';
import '../../../data/models/task_model.dart';
import '../../../routes/app_routes.dart';

class TaskDetailsController extends GetxController {
  final task = Rxn<TaskModel>();
  final isTaskAccepted = false.obs; // Track if pending task is accepted

  @override
  void onInit() {
    super.onInit();
    final taskData = Get.arguments?['task'];
    if (taskData != null) {
      task.value = taskData as TaskModel;
    }
  }

  Future<void> acceptTask() async {
    try {
      // TODO: Call API to accept task
      // await ApiService.acceptTask(task.value!.id);
      
      // Mark as accepted locally
      isTaskAccepted.value = true;
      
      Get.snackbar(
        'Task Accepted',
        'You can now submit this task',
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

  Future<void> rejectTask() async {
    try {
      // TODO: Call API to reject task
      // await ApiService.rejectTask(task.value!.id);
      
      Get.back(); // Go back to previous screen
      
      Get.snackbar(
        'Task Rejected',
        'You have rejected "${task.value?.title}"',
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

  void goToSubmission() {
    Get.toNamed(
      AppRoutes.taskSubmission,
      arguments: {'task': task.value},
    );
  }
}


