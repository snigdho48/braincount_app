import 'package:get/get.dart';
import '../../../data/models/task_model.dart';
import '../../../routes/app_routes.dart';

class TaskDetailsController extends GetxController {
  final task = Rxn<TaskModel>();

  @override
  void onInit() {
    super.onInit();
    final taskData = Get.arguments?['task'];
    if (taskData != null) {
      task.value = taskData as TaskModel;
    }
  }

  void goToSubmission() {
    Get.toNamed(
      AppRoutes.taskSubmission,
      arguments: {'task': task.value},
    );
  }
}


