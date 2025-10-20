import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/theme_service.dart';
import 'app_theme.dart';

extension ThemeExtensions on BuildContext {
  // Quick access to theme service
  ThemeService get themeService => Get.find<ThemeService>();
  
  // Check if dark mode
  bool get isDarkMode => themeService.isDarkMode.value;
  
  // Background colors
  Color get backgroundColor => isDarkMode ? AppTheme.darkBackground : AppTheme.lightBackground;
  Color get cardColor => isDarkMode ? AppTheme.darkCard : AppTheme.lightCard;
  Color get borderColor => isDarkMode ? AppTheme.darkBorder : AppTheme.lightBorder;
  Color get tertiaryColor => isDarkMode ? AppTheme.darkTertiary : AppTheme.lightTertiary;
  
  // Text colors
  Color get textColor => isDarkMode ? AppTheme.darkText : AppTheme.lightText;
  Color get secondaryTextColor => isDarkMode ? AppTheme.darkSecondaryText : AppTheme.lightSecondaryText;
  
  // Gradients
  LinearGradient get backgroundGradient => isDarkMode 
      ? AppTheme.backgroundGradient 
      : AppTheme.lightBackgroundGradient;
}

