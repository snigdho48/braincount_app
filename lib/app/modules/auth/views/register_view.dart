import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
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
                        // Back Button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: AppColors.textWhite,
                              size: Responsive.iconSize,
                            ),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        SizedBox(height: Responsive.mdVertical),
                        // Title
                        Text(
                          'Register Account',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(20),
                            fontWeight: FontWeight.bold,
                            color: AppColors.textWhite,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Responsive.lgVertical),
                        // First Name and Last Name Row
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: 'First Name',
                                hint: 'Write first name',
                                controller: controller.nameController,
                                isRequired: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: Responsive.md),
                            Expanded(
                              child: CustomTextField(
                                label: 'Last Name',
                                hint: 'Write Last name',
                                controller: TextEditingController(),
                                isRequired: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Responsive.mdVertical),
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
                        // Phone Field
                        CustomTextField(
                          label: 'Phone',
                          hint: 'Write phone number',
                          controller: TextEditingController(),
                          isRequired: true,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
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
                                  color: AppColors.textGrey,
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
                        SizedBox(height: Responsive.lgVertical),
                        // Register Button
                        Obx(() => CustomButton(
                              text: 'Create Account',
                              onPressed: controller.register,
                              isLoading: controller.isLoading.value,
                            )),
                        SizedBox(height: Responsive.mdVertical),
                        // Terms Text
                        Text(
                          'By continuing, you agree to our Terms of Service and Privacy Policy.',
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: Responsive.fontSize(12),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
