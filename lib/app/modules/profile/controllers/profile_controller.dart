import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = await StorageService.getUser();
    if (user != null) {
      currentUser.value = user;
    }
  }

  void goToBalanceHistory() {
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


