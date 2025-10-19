import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/api_service.dart';
import '../../../widgets/error_modal.dart';
import '../../../widgets/success_modal.dart';
import '../../../routes/app_routes.dart';

class ResetPasswordController extends GetxController {
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final isLoading = false.obs;
  final obscureNewPassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments?['email'] ?? '';
  }

  @override
  void onClose() {
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleNewPasswordVisibility() {
    obscureNewPassword.value = !obscureNewPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      
      final response = await ApiService.resetPassword(
        email.value,
        otpController.text,
        newPasswordController.text,
      );

      if (response['success'] == true) {
        SuccessModal.show(
          Get.context!,
          title: 'Success!',
          message: 'Your password has been reset successfully',
          onPressed: () {
            Get.offAllNamed(AppRoutes.login);
          },
        );
      } else {
        ErrorModal.show(
          Get.context!,
          title: 'Failed',
          message: response['message'] ?? 'Failed to reset password',
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


