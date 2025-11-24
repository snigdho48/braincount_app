import 'package:get/get.dart';
import '../../../data/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Show splash screen for 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      
      // Check if user is logged in
      final isLoggedIn = await StorageService.isLoggedIn();
      
      if (isLoggedIn) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      // Fallback to login if there's an error
      Get.offAllNamed(AppRoutes.login);
    }
  }
}

