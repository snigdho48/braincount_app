import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/models/user_model.dart';
import '../../../widgets/error_modal.dart';
import '../../../routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  final emailController = TextEditingController();
  final isLoading = false.obs;
  final email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments?['email'] ?? '';
    emailController.text = email.value;
  }

  @override
  void onClose() {
    otpController.dispose();
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendOtp() async {
    try {
      isLoading.value = true;
      // TODO: Send OTP to email
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'OTP Sent',
        'A verification code has been sent to your email',
        backgroundColor: AppColors.success.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'Failed to send OTP. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOTP() async {
    if (otpController.text.length != 6) {
      ErrorModal.show(
        Get.context!,
        title: 'Invalid OTP',
        message: 'Please enter 6-digit OTP',
      );
      return;
    }

    try {
      isLoading.value = true;
      
      final response = await ApiService.verifyOTP(
        email.value,
        otpController.text,
      );

      if (response['success'] == true) {
        // Save token and user data
        await StorageService.saveToken(response['token']);
        await StorageService.saveUser(UserModel.fromJson(response['user']));
        await StorageService.setLoggedIn(true);

        // Navigate to dashboard
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        ErrorModal.show(
          Get.context!,
          title: 'Verification Failed',
          message: response['message'] ?? 'Invalid OTP',
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

  Future<void> resendOTP() async {
    // Implement resend OTP logic
    Get.snackbar(
      'OTP Sent',
      'A new OTP has been sent to your email',
      backgroundColor: AppColors.success.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
}

