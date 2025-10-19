import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/api_service.dart';
import '../../../widgets/error_modal.dart';
import '../../../routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendResetCode() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      
      final response = await ApiService.forgotPassword(
        emailController.text.trim(),
      );

      if (response['success'] == true) {
        Get.toNamed(
          AppRoutes.resetPassword,
          arguments: {'email': emailController.text.trim()},
        );
      } else {
        ErrorModal.show(
          Get.context!,
          title: 'Failed',
          message: response['message'] ?? 'Failed to send OTP',
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
}


