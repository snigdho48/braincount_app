import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF8B5CF6);
  static const Color primaryDark = Color(0xFF7C3AED);
  static const Color primaryLight = Color(0xFFA78BFA);
  
  // Gradient Colors
  static const Color gradientStart = Color(0xFF8B5CF6);
  static const Color gradientEnd = Color(0xFFEC4899);
  
  // Background Colors
  static const Color background = Color(0xFF1A0B2E);
  static const Color backgroundDark = Color(0xFF0F0820);
  static const Color cardBackground = Color(0xFF2A1F3D);
  static const Color cardDark = Color(0xFF1F1534);
  
  // Text Colors
  static const Color textWhite = Colors.white;
  static const Color textGrey = Color(0xFF9CA3AF);
  static const Color textDark = Color(0xFF6B7280);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // Task Status Colors
  static const Color taskCompleted = Color(0xFF10B981);
  static const Color taskPending = Color(0xFFF59E0B);
  static const Color taskRejected = Color(0xFFEF4444);
  
  // UI Elements
  static const Color borderColor = Color(0xFF8B5CF6);
  static const Color dividerColor = Color(0xFF374151);
  static const Color iconColor = Color(0xFF9CA3AF);
  
  // Button Colors
  static const Color buttonGradientStart = Color(0xFF8B5CF6);
  static const Color buttonGradientEnd = Color(0xFFEC4899);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, backgroundDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}


