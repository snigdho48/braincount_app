import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/theme_service.dart';

/// AppColors - Theme-aware color getter
/// Use this class to get colors that automatically change with theme
class AppColors {
  static ThemeService get _themeService => Get.find<ThemeService>();
  static bool get _isDark => _themeService.isDarkMode.value;

  // Background Colors
  static Color get background => _isDark ? const Color(0xFF232323) : const Color(0xFFF5F5F5);
  static Color get cardBackground => _isDark ? const Color(0xFF393838) : Colors.white;
  static Color get cardDark => const Color(0xFF393838); // Alias for dark card (always dark)
  static Color get tertiaryBackground => _isDark ? const Color(0xFF212121) : const Color(0xFFFAFAFA);
  
  // Text Colors
  static Color get primaryText => _isDark ? Colors.white : const Color(0xFF212121);
  static Color get secondaryText => _isDark ? const Color(0xFF888787) : const Color(0xFF757575);
  static Color get textGrey => _isDark ? const Color(0xFF888787) : const Color(0xFF757575); // Alias for secondaryText
  static const Color textWhite = Colors.white; // Always white regardless of theme (const for use in const widgets)
  static Color get disabledText => _isDark ? const Color(0xFF4A4949) : const Color(0xFFBDBDBD);
  
  // Border Colors
  static Color get border => _isDark ? const Color(0xFF4A4949) : const Color(0xFFE0E0E0);
  static Color get borderColor => _isDark ? const Color(0xFF4A4949) : const Color(0xFFE0E0E0); // Alias for border
  static Color get divider => _isDark ? const Color(0xFF232323) : const Color(0xFFE0E0E0);
  static Color get dividerColor => _isDark ? const Color(0xFF232323) : const Color(0xFFE0E0E0); // Alias for divider
  
  // Primary Colors (same for both themes)
  static const Color primary = Color(0xFF85428C);
  static const Color primaryLight = Color(0xFF9D5BAF);
  static const Color primaryDark = Color(0xFF5B099B);
  
  // Status Colors (same for both themes)
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Gradients
  static LinearGradient get backgroundGradient => _isDark 
      ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF232323),
            Color(0xFF393838),
            Color(0xFF232323),
          ],
        )
      : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFAFAFA),
            Color(0xFFF5F5F5),
            Color(0xFFEEEEEE),
          ],
        );
  
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF85428C),
      Color(0xFF7B1BAB),
      Color(0xFF9D2BF5),
    ],
  );
  
  // Profile Card Gradient
  static LinearGradient get profileCardGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 127, 80, 163),
      Color(0xFF7B1BAB),
      Color.fromARGB(255, 157, 43, 245),
    ],
  );
  
  // Shadow Colors
  static Color get shadowColor => _isDark 
      ? Colors.black.withOpacity(0.3)
      : Colors.black.withOpacity(0.1);
  
  // Overlay Colors
  static Color get overlayColor => _isDark 
      ? Colors.black.withOpacity(0.5)
      : Colors.black.withOpacity(0.3);
  
  // Icon Colors
  static Color get iconColor => _isDark ? Colors.white : const Color(0xFF212121);
  static Color get iconColorSecondary => _isDark ? const Color(0xFF888787) : const Color(0xFF757575);
}
