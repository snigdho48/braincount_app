import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/models/user_model.dart';
import '../../../widgets/error_modal.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final isLoading = false.obs;
  final obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      
      final response = await ApiService.login(
        emailController.text.trim(),
        passwordController.text,
      );

      if (response['success'] == true) {
        // Save token and user data
        await StorageService.saveToken(response['token']);
        await StorageService.saveUser(UserModel.fromJson(response['user']));
        await StorageService.setLoggedIn(true);

        // Navigate to home
        Get.offAllNamed(AppRoutes.home);
      } else {
        ErrorModal.show(
          Get.context!,
          title: 'Login Failed',
          message: response['message'] ?? 'Invalid credentials',
        );
      }
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'An error occurred. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      
      // In real app, integrate with Google Sign In
      final response = await ApiService.googleSignIn('mock_google_token');

      if (response['success'] == true) {
        await StorageService.saveToken(response['token']);
        await StorageService.saveUser(UserModel.fromJson(response['user']));
        await StorageService.setLoggedIn(true);

        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'Google sign in failed.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.register);
  }

  void goToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }
}


