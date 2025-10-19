import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/api_service.dart';
import '../../../widgets/error_modal.dart';
import '../../../routes/app_routes.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      
      final response = await ApiService.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text,
      );

      if (response['success'] == true) {
        // Navigate to OTP verification
        Get.toNamed(
          AppRoutes.otpVerification,
          arguments: {'email': emailController.text.trim()},
        );
      } else {
        ErrorModal.show(
          Get.context!,
          title: 'Registration Failed',
          message: response['message'] ?? 'Registration failed',
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

  Future<void> registerWithGoogle() async {
    try {
      isLoading.value = true;
      
      // TODO: Implement Google Sign-In
      // For now, show a message
      ErrorModal.show(
        Get.context!,
        title: 'Coming Soon',
        message: 'Google registration will be available soon.',
      );
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

  void goToLogin() {
    Get.back();
  }
}


