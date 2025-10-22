import 'package:braincount/app/data/services/theme_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:one_request/one_request.dart';

class AppConfig {
  static void initialize() {
    _configureOneRequest();
  }
static Future<void> initializeTheme() async {
    // Initialize theme service
  final themeService = ThemeService();
  themeService.onInit();
  await themeService.loadTheme();
  Get.put(themeService);
}
  /// Register licenses for ALL fonts - CRITICAL for Play Store approval
  /// All fonts now have proper open-source licenses
  static void registerFontLicenses() {
    LicenseRegistry.addLicense(() async* {
      // 1. BebasNeue (Google Fonts - OFL license)
      try {
        final String bebasNeueLicense =
            await rootBundle.loadString('assets/fonts/OFL_BebasNeue.txt');
        yield LicenseEntryWithLineBreaks(['BebasNeue'], bebasNeueLicense);
      } catch (_) {
        // License file not found
      }

      // 2. Poppins (Google Fonts - OFL license)
      try {
        final String poppinsLicense =
            await rootBundle.loadString('assets/fonts/OFL_Poppins.txt');
        yield LicenseEntryWithLineBreaks(['Poppins'], poppinsLicense);
      } catch (_) {}

      // 3. Inter (Google Fonts - OFL license)
      try {
        final String interLicense =
            await rootBundle.loadString('assets/fonts/OFL_Inter.txt');
        yield LicenseEntryWithLineBreaks(['Inter'], interLicense);
      } catch (_) {}

      // 4. Satoshi (Fontshare - FFL license)
      try {
        final String satoshiLicense =
            await rootBundle.loadString('assets/fonts/OFL_Satoshi.txt');
        yield LicenseEntryWithLineBreaks(['Satoshi'], satoshiLicense);
      } catch (_) {}
    });
  }
  static void _configureOneRequest() {
    // Configure loading UI with BrainCount theme
    OneRequest.loadingconfig(
      backgroundColor: const Color(0xFF1A0B2E).withOpacity(0.9),
      indicator: const CircularProgressIndicator(
        color: Color(0xFF8B5CF6),
        strokeWidth: 3,
      ),
      indicatorColor: const Color(0xFF8B5CF6),
      progressColor: const Color(0xFF8B5CF6),
      textColor: Colors.white,
      success: const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 32),
      error: const Icon(Icons.error, color: Color(0xFFEF4444), size: 32),
      info: const Icon(Icons.info, color: Color(0xFF3B82F6), size: 32),
    );

    // Set global base URL and headers
    OneRequest.configure(
      baseUrl: 'https://your-api-url.com/api', // Replace with your actual API URL
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Set custom error handler
    OneRequest.setErrorHandler(
      handler: (dynamic body, int? status, String? url) {
        // Extract error message from response body
        try {
          if (body != null && body is Map) {
            return body['message']?.toString() ?? 
                   body['error']?.toString() ?? 
                   'An error occurred';
          }
        } catch (_) {
          // Ignore parsing errors
        }
        return 'Network error occurred';
      },
      logger: (error, stack) => debugPrint('API Error: $error'),
    );
  }
}

