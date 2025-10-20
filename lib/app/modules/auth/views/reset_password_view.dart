import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reset_password_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textWhite,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.psychology,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Title
                  const Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Enter OTP and create a new password',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // OTP Field
                  CustomTextField(
                    label: 'OTP Code',
                    hint: 'Enter 6-digit OTP',
                    controller: controller.otpController,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter OTP';
                      }
                      if (value.length != 6) {
                        return 'OTP must be 6 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // New Password Field
                  Obx(() => CustomTextField(
                        label: 'New Password',
                        hint: '******',
                        controller: controller.newPasswordController,
                        isRequired: true,
                        isPassword: controller.obscureNewPassword.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter new password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscureNewPassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.textGrey,
                          ),
                          onPressed: controller.toggleNewPasswordVisibility,
                        ),
                      )),
                  const SizedBox(height: 20),
                  // Confirm Password Field
                  Obx(() => CustomTextField(
                        label: 'Confirm Password',
                        hint: '******',
                        controller: controller.confirmPasswordController,
                        isRequired: true,
                        isPassword: controller.obscureConfirmPassword.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != controller.newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscureConfirmPassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.textGrey,
                          ),
                          onPressed: controller.toggleConfirmPasswordVisibility,
                        ),
                      )),
                  const SizedBox(height: 40),
                  // Reset Password Button
                  Obx(() => CustomButton(
                        text: 'Reset Password',
                        onPressed: controller.resetPassword,
                        isLoading: controller.isLoading.value,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


