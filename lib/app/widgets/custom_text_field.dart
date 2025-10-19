import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final bool isRequired;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: Responsive.fontSize(14),
                color: AppColors.textWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  fontSize: Responsive.fontSize(14),
                  color: AppColors.error,
                ),
              ),
          ],
        ),
        SizedBox(height: Responsive.smVertical),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: Responsive.fontSize(15),
          ),
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.textGrey.withOpacity(0.6),
              fontSize: Responsive.fontSize(14),
            ),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.all(Responsive.sp(12)),
                    child: FaIcon(
                      prefixIcon,
                      color: AppColors.textGrey,
                      size: Responsive.iconSizeSm,
                    ),
                  )
                : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.cardDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.radiusMd),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.radiusMd),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.radiusMd),
              borderSide: BorderSide(
                color: AppColors.primary.withOpacity(0.5),
                width: Responsive.sp(1),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.radiusMd),
              borderSide: BorderSide(
                color: AppColors.error,
                width: Responsive.sp(1),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Responsive.md,
              vertical: Responsive.mdVertical,
            ),
          ),
        ),
      ],
    );
  }
}


