import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
                  const SizedBox(height: 20),
                  // Logo
                  Container(
                    height: 80,
                    child: Image.asset(
                      'assets/app_icon/braincount-logo.png',
                      height: 80,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 120,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.psychology,
                            size: 50,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Title
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // Name Field
                  CustomTextField(
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    controller: controller.nameController,
                    isRequired: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Email Field
                  CustomTextField(
                    label: 'Email',
                    hint: 'Write email address',
                    controller: controller.emailController,
                    isRequired: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  Obx(() => CustomTextField(
                        label: 'Password',
                        hint: '******',
                        controller: controller.passwordController,
                        isRequired: true,
                        isPassword: controller.obscurePassword.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.textGrey,
                          ),
                          onPressed: controller.togglePasswordVisibility,
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
                          if (value != controller.passwordController.text) {
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
                  const SizedBox(height: 30),
                  // Register Button
                  Obx(() => CustomButton(
                        text: 'Register',
                        onPressed: controller.register,
                        isLoading: controller.isLoading.value,
                      )),
                  const SizedBox(height: 30),
                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: controller.goToLogin,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: AppColors.info,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


