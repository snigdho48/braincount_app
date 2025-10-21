import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class BrainLoader extends StatelessWidget {
  final String? message;
  final double? size;

  const BrainLoader({
    super.key,
    this.message,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final loaderSize = size ?? Responsive.sp(100);
    
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated brain icon (using creative shapes)
          Container(
            width: loaderSize,
            height: loaderSize,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.5),
                  blurRadius: Responsive.sp(20),
                  spreadRadius: Responsive.sp(5),
                ),
              ],
            ),
            child: Icon(
              Icons.psychology,
              size: loaderSize * 0.5,
              color: Colors.white,
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.5))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.1, 1.1),
                duration: 1000.ms,
              )
              .then()
              .scale(
                begin: const Offset(1.1, 1.1),
                end: const Offset(1, 1),
                duration: 1000.ms,
              ),
          if (message != null) ...[
            SizedBox(height: Responsive.mdVertical),
            Text(
              message!,
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: Responsive.fontSize(14),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .fadeIn(duration: 800.ms)
                .then()
                .fadeOut(duration: 800.ms),
          ],
        ],
      ),
    );
  }
}
