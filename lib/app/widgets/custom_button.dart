import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final double? width;
  final double? height;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.width,
    this.height,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width,
      height: height ?? Responsive.buttonHeight,
      decoration: BoxDecoration(
        gradient: isOutlined ? null : AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(Responsive.radiusXl + Responsive.sp(6)),
        border: isOutlined
            ? Border.all(color: AppColors.borderColor, width: Responsive.sp(2))
            : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Responsive.radiusXl + Responsive.sp(6)),
          ),
          padding: EdgeInsets.symmetric(horizontal: Responsive.md),
        ),
        child: isLoading
            ? SizedBox(
                height: Responsive.iconSize,
                width: Responsive.iconSize,
                child: CircularProgressIndicator(
                  color: AppColors.textWhite,
                  strokeWidth: Responsive.sp(2),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: AppColors.textWhite, size: Responsive.iconSize),
                    SizedBox(width: Responsive.sm),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}


