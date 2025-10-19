import 'package:get/get.dart';
import '../controllers/main_navigation_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../tasks/controllers/task_list_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavigationController>(() => MainNavigationController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<TaskListController>(() => TaskListController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

