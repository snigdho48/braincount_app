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
      print('Splash: Starting initialization...');
      
      // Show splash screen for 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      print('Splash: Delay completed, checking login status...');
      
      // Check if user is logged in
      final isLoggedIn = await StorageService.isLoggedIn();
      print('Splash: isLoggedIn = $isLoggedIn');
      
      if (isLoggedIn) {
        print('Splash: Navigating to home');
        Get.offAllNamed(AppRoutes.home);
      } else {
        print('Splash: Navigating to login');
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      print('Splash error: $e');
      // Fallback to login if there's an error
      print('Splash: Fallback to login due to error');
      Get.offAllNamed(AppRoutes.login);
    }
  }
}

