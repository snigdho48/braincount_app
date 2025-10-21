import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: Get.height - Get.mediaQuery.padding.top - Get.mediaQuery.padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.all(Responsive.md),
                  child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primaryText,
                        size: Responsive.iconSize,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  SizedBox(height: Responsive.lgVertical),
                  // Logo (Favicon)
                  Center(
                    child: Container(
                      width: Responsive.sp(113),
                      height: Responsive.sp(113),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Responsive.radiusLg),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Responsive.radiusLg),
                        child: Image.asset(
                          'assets/app_icon/favicon.png',
                          width: Responsive.sp(113),
                          height: Responsive.sp(113),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(Responsive.radiusLg),
                              ),
                              child: Icon(
                                Icons.psychology,
                                size: Responsive.sp(60),
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.lgVertical),
                  // Title
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(20),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Responsive.lgVertical),
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
                  SizedBox(height: Responsive.mdVertical),
                  // Password Field
                  Obx(() => CustomTextField(
                        label: 'Password',
                        hint: '******',
                        controller: controller.passwordController,
                        isRequired: true,
                        isPassword: controller.obscurePassword.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.secondaryText,
                            size: Responsive.iconSizeSm,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      )),
                  SizedBox(height: Responsive.smVertical),
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: controller.goToForgotPassword,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: Responsive.fontSize(14),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.lgVertical),
                  // Login Button
                  Obx(() => CustomButton(
                        text: 'Login',
                        onPressed: controller.login,
                        isLoading: controller.isLoading.value,
                      )),
                  SizedBox(height: Responsive.lgVertical),
                  // Or divider
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.borderColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Responsive.md),
                        child: Text(
                          'or login with',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: Responsive.fontSize(14),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.borderColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.lgVertical),
                  // Google Login Button
                  GestureDetector(
                    onTap: controller.loginWithGoogle,
                    child: Container(
                      height: Responsive.buttonHeight,
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(Responsive.radiusXl + Responsive.sp(6)),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: Responsive.sp(1),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/app_icon/google_logo.png',
                            width: Responsive.sp(24),
                            height: Responsive.sp(24),
                          ),
                          SizedBox(width: Responsive.sm),
                          Text(
                            'Login with Google',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(16),
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.xlVertical),
                  // Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: Responsive.fontSize(14),
                        ),
                      ),
                      TextButton(
                        onPressed: controller.goToRegister,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: Responsive.fontSize(14),
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
        ),
      ),
    )
    );
  }
}
