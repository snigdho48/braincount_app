import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/services/theme_service.dart';
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final currentUser = Rxn<UserModel>();
  Rxn<UserModel> get user => currentUser; // Alias for currentUser
  
  // Language selection
  final selectedLanguage = 'EN'.obs;
  final availableLanguages = ['EN', 'BN'];
  
  // Theme service
  final ThemeService _themeService = Get.find<ThemeService>();
  
  // Computed property for theme mode
  bool get isDarkMode => _themeService.isDarkMode.value;
  RxBool get isDarkModeObs => _themeService.isDarkMode;

  void navigateToLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }
  
  void changeLanguage(String language) {
    selectedLanguage.value = language;
    // TODO: Implement actual language change logic with GetX localization
  }
  
  void toggleTheme() {
    _themeService.toggleTheme();
  }

  Future<void> loadUserData() async {
    final userData = await StorageService.getUser();
    if (userData != null) {
      currentUser.value = userData;
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


