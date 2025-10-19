import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import 'custom_button.dart';

class SuccessModal extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onPressed;

  const SuccessModal({
    super.key,
    required this.title,
    required this.message,
    required this.onPressed,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SuccessModal(
        title: title,
        message: message,
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(Responsive.lg),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(Responsive.radiusXl),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.sp(20)),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                size: Responsive.sp(48),
                color: Colors.white,
              ),
            ),
            SizedBox(height: Responsive.mdVertical),
            Text(
              title,
              style: TextStyle(
                fontSize: Responsive.fontSize(24),
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Responsive.smVertical),
            Text(
              message,
              style: TextStyle(
                fontSize: Responsive.fontSize(14),
                color: AppColors.textGrey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Responsive.lgVertical),
            CustomButton(
              text: 'Continue',
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
