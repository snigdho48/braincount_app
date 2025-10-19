import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_request/one_request.dart';
import 'app/core/config/app_config.dart';
import 'app/core/theme/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize app configuration (OneRequest, etc.)
  AppConfig.initialize();
  
  runApp(const BrainCountApp());
}

class BrainCountApp extends StatelessWidget {
  const BrainCountApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BrainCount',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash, // Start with custom splash screen
      getPages: AppPages.routes,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
      builder: OneRequest.initLoading, // Initialize OneRequest loading overlay
    );
  }
}
