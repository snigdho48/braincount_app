import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../controllers/otp_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/custom_button.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor, width: 2),
      ),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
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
                // Title
                const Text(
                  'OTP Verification',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Obx(() => Text(
                      'Enter the 6-digit code sent to\n${controller.email.value}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textGrey,
                      ),
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(height: 40),
                // OTP Input
                Center(
                  child: Pinput(
                    controller: controller.otpController,
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                    ),
                    onCompleted: (pin) => controller.verifyOTP(),
                  ),
                ),
                const SizedBox(height: 40),
                // Verify Button
                Obx(() => CustomButton(
                      text: 'Verify',
                      onPressed: controller.verifyOTP,
                      isLoading: controller.isLoading.value,
                    )),
                const SizedBox(height: 24),
                // Resend OTP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't receive the code?",
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: controller.resendOTP,
                      child: const Text(
                        'Resend',
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
    );
  }
}


