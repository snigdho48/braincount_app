import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/splash_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Favicon on top
              Container(
                width: Responsive.sp(80),
                height: Responsive.sp(80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Responsive.radiusLg + Responsive.sp(4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: Responsive.sp(20),
                      offset: Offset(0, Responsive.sp(10)),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Responsive.radiusLg + Responsive.sp(4)),
                  child: Image.asset(
                    'assets/app_icon/favicon.png',
                    width: Responsive.sp(80),
                    height: Responsive.sp(80),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: Responsive.sp(80),
                        height: Responsive.sp(80),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(Responsive.radiusLg + Responsive.sp(4)),
                        ),
                        child: Icon(
                          Icons.psychology,
                          size: Responsive.sp(40),
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.3))
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.05, 1.05),
                    duration: 1500.ms,
                  )
                  .then()
                  .scale(
                    begin: const Offset(1.05, 1.05),
                    end: const Offset(1, 1),
                    duration: 1500.ms,
                  ),
              
              SizedBox(height: Responsive.lgVertical),
              
              // BrainCount Logo below
              SizedBox(
                height: Responsive.height(7),
                child: Image.asset(
                  'assets/app_icon/braincount-logo.png',
                  height: Responsive.height(7),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      'braincount',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(32),
                        fontWeight: FontWeight.bold,
                        color: AppColors.textWhite,
                        letterSpacing: 2,
                      ),
                    );
                  },
                ),
              )
                  .animate()
                  .fadeIn(duration: 1000.ms, delay: 500.ms)
                  .slideY(begin: 0.3, end: 0, duration: 1000.ms, delay: 500.ms),
              
              SizedBox(height: Responsive.mdVertical),
              
              // Loading indicator
              SizedBox(
                width: Responsive.sp(30),
                height: Responsive.sp(30),
                child: CircularProgressIndicator(
                  strokeWidth: Responsive.sp(3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primary.withOpacity(0.8),
                  ),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .fadeIn(duration: 800.ms, delay: 1000.ms)
                  .then()
                  .fadeOut(duration: 800.ms),
              
              SizedBox(height: Responsive.xlVertical),
              
              // App tagline
              Text(
                'Task-Based Earnings Platform',
                style: TextStyle(
                  fontSize: Responsive.fontSize(14),
                  color: AppColors.textGrey.withOpacity(0.8),
                  letterSpacing: 1,
                ),
              )
                  .animate()
                  .fadeIn(duration: 1000.ms, delay: 1500.ms)
                  .slideY(begin: 0.2, end: 0, duration: 1000.ms, delay: 1500.ms),
            ],
          ),
        ),
      ),
    );
  }
}

