import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/otp_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

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
                  child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Back Button
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
                SizedBox(height: Responsive.xlVertical),
                // Illustration
                Center(
                  child: Container(
                    width: Responsive.sp(230),
                    height: Responsive.sp(230),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(Responsive.radiusXl),
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: Responsive.sp(100),
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: Responsive.xlVertical),
                // Title
                  Text(
                  'OTP Verification',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(20),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Responsive.mdVertical),
                // Description
                Text(
                  'Enter email and phone number to send one time Password',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: Responsive.fontSize(14),
                    height: 1.5,
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
                SizedBox(height: Responsive.xlVertical * 2),
                // Continue Button
                Obx(() => CustomButton(
                      text: 'Continue',
                      onPressed: controller.sendOtp,
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
    );
  }
}
