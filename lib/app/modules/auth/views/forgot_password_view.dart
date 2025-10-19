import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

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
                minHeight: Get.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
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
                  SizedBox(height: Responsive.lgVertical),
                  // Title
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(20),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                  ),
                  SizedBox(height: Responsive.mdVertical),
                  // Description
                  Text(
                    'No worries! Enter your email address below and we will send you a code to reset password.',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: Responsive.fontSize(14),
                      height: 1.5,
                    ),
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
                  SizedBox(height: Responsive.xlVertical * 2),
                  // Reset Button
                  Obx(() => CustomButton(
                        text: 'Reset Password',
                        onPressed: controller.sendResetCode,
                        isLoading: controller.isLoading.value,
                      )),
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
