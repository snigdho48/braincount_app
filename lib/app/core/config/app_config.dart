import 'package:braincount/app/data/services/theme_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:one_request/one_request.dart';
import '../../data/services/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:braincount/firebase_options.dart';


class AppConfig {
  static void initialize() {
    _configureOneRequest();
    _initializeAuthHeaders();
  }
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  static Future<void> _initializeAuthHeaders() async {
    final token = await StorageService.getToken();
    if (token != null) {
      updateAuthHeaders(token);
    }
  }

  // API Configuration
  static const String _productionBaseUrl = 'https://dev.bc.reachableads.com/api';
  static const String _localBaseUrl = 'http://192.168.68.55:8000/api';
  // Update this with your current ngrok URL (ngrok URLs change on restart)
  static const String _ngrokBaseUrl = 'https://6197e15c60a5.ngrok-free.app/api';
  
  // Configuration: 'production', 'local', or 'ngrok'
  // Set to 'production' for live app, 'local' for local development, or 'ngrok' for ngrok tunnel
  static const String _environment = 'local';
  
  static String get baseUrl {
    switch (_environment) {
      case 'production':
        return _productionBaseUrl;
      case 'ngrok':
        return _ngrokBaseUrl;
      case 'local':
      default:
        return _localBaseUrl;
    }
  }

  static void updateAuthHeaders(String token) {
    // Headers for ngrok (free tier requires ngrok-skip-browser-warning)
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    
    // Add ngrok bypass header if using ngrok
    if (_environment == 'ngrok') {
      headers['ngrok-skip-browser-warning'] = 'true';
    }
    
    // Get current overlay settings to preserve them
    final overlaySettings = OneRequest.getOverlaySettings();
    
    OneRequest.configure(
      baseUrl: baseUrl,
      headers: headers,
      enableLogger: overlaySettings['logger'] ?? true, // Preserve logger setting
      enableLoader: overlaySettings['loader'],
      enableErrorOverlay: overlaySettings['errorOverlay'],
      enableSuccessOverlay: overlaySettings['successOverlay'],
    );
  }
  
  /// Enable or disable global overlays
  /// Use this to control loading, error, and success overlays globally
  static void setOverlaySettings({
    bool? enableLoader,
    bool? enableErrorOverlay,
    bool? enableSuccessOverlay,
  }) {
    OneRequest.setOverlaySettings(
      enableLoader: enableLoader,
      enableErrorOverlay: enableErrorOverlay,
      enableSuccessOverlay: enableSuccessOverlay,
    );
  }
  
  /// Get current overlay settings
  static Map<String, bool> getOverlaySettings() {
    return OneRequest.getOverlaySettings();
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

    // Set global base URL and initial headers (without auth token)
    // Auth token will be added via updateAuthHeaders() after login
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    // Add ngrok bypass header if using ngrok
    if (_environment == 'ngrok') {
      headers['ngrok-skip-browser-warning'] = 'true';
    }
    
    OneRequest.configure(
      // Uses baseUrl getter which switches between environments
      // Set _environment to 'production', 'local', or 'ngrok'
      baseUrl: baseUrl,
      headers: headers,
      // Global overlay settings - set to false to disable overlays globally
      enableLoader: true, // Set to false to disable loading overlay globally
      enableErrorOverlay: false, // Set to false to disable error overlay globally
      enableSuccessOverlay: false, // Set to false to disable success overlay globally
      enableErrorLogger: true, // Enable error logging (shows errors with red color)
      enableResponseLogger: true, // Enable response logging (shows successful responses with green color)
    );
    
    // Verify logger is enabled (for debugging)
    if (OneRequest.isLoggerEnabled()) {
      final errorEnabled = OneRequest.isErrorLoggerEnabled();
      final responseEnabled = OneRequest.isResponseLoggerEnabled();
      print('✅ OneRequest logger is ENABLED');
      print('   - Error Logger: ${errorEnabled ? "✅ Enabled" : "❌ Disabled"}');
      print('   - Response Logger: ${responseEnabled ? "✅ Enabled" : "❌ Disabled"}');
      print('   - Request Logger: ✅ Auto-enabled (shows when any logger is enabled)');
    } else {
      print('❌ OneRequest logger is DISABLED - No API logs will be shown');
    }

    // Set custom error handler to extract meaningful error messages
    OneRequest.setErrorHandler(
      handler: (body, status, url) {
        // Try to extract error message from response body
        String errorMsg = 'Network error occurred';
        
        // Handle Map response body (OneRequest passes body as Map)
        final bodyMap = body as Map<String, dynamic>?;
        if (bodyMap != null) {
          // Try to get error message from common fields
          final errorValue = bodyMap['error'];
          final messageValue = bodyMap['message'];
          final detailValue = bodyMap['detail'];
          
          // Handle different types of error values
          if (errorValue != null) {
            if (errorValue is String && errorValue.trim().isNotEmpty) {
              errorMsg = errorValue.trim();
            } else if (errorValue is Map) {
              // If error is a map, try to get message from it
              final mapMsg = (errorValue['message'] ?? errorValue.toString()).toString().trim();
              if (mapMsg.isNotEmpty) {
                errorMsg = mapMsg;
              }
            } else {
              final strMsg = errorValue.toString().trim();
              if (strMsg.isNotEmpty) {
                errorMsg = strMsg;
              }
            }
          } else if (messageValue != null) {
            final msg = messageValue.toString().trim();
            if (msg.isNotEmpty) {
              errorMsg = msg;
            }
          } else if (detailValue != null) {
            final detail = detailValue.toString().trim();
            if (detail.isNotEmpty) {
              errorMsg = detail;
            }
          }
        }
        
        // If we still don't have a valid error message, use status-based defaults
        if (errorMsg.trim().isEmpty || errorMsg == 'Network error occurred') {
          if (status == 401) {
            errorMsg = 'Authentication failed. Please login again.';
          } else if (status == 403) {
            errorMsg = 'You do not have permission to access this resource.';
          } else if (status == 404) {
            errorMsg = 'Resource not found.';
          } else if (status == 500) {
            errorMsg = 'Server error. Please try again later.';
          } else if (status != null) {
            errorMsg = 'Request failed with status $status';
          } else {
            errorMsg = 'Network error occurred. Please check your connection.';
          }
        }
        
        // Final safety check - never return empty string
        if (errorMsg.trim().isEmpty) {
          errorMsg = 'An error occurred. Please try again.';
        }
        
        return errorMsg;
      },
      logger: (error, stack) {
        // Error logging disabled for production
      },
    );
  }
}

