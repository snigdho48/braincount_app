import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/splash_controller.dart';
import '../../../core/theme/app_colors.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Favicon on top
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/app_icon/favicon.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.psychology,
                          size: 40,
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
              
              const SizedBox(height: 30),
              
              // BrainCount Logo below
              Container(
                height: 60,
                child: Image.asset(
                  'assets/app_icon/braincount-logo.png',
                  height: 60,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text(
                      'braincount',
                      style: TextStyle(
                        fontSize: 32,
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
              
              const SizedBox(height: 20),
              
              // Loading indicator
              Container(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primary.withOpacity(0.8),
                  ),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .fadeIn(duration: 800.ms, delay: 1000.ms)
                  .then()
                  .fadeOut(duration: 800.ms),
              
              const SizedBox(height: 20),
              

              const SizedBox(height: 40),
              
              // App tagline
              Text(
                'Task-Based Earnings Platform',
                style: TextStyle(
                  fontSize: 14,
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

