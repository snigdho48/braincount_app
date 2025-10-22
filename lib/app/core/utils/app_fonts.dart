import 'package:flutter/material.dart';

/// Centralized font management for BrainCount App
/// ALL FONTS ARE LICENSED - Safe for Play Store submission
/// 
/// Font replacements:
/// - Oddlini → BebasNeue (Google Fonts OFL)
/// - Helvetica → Inter (Google Fonts OFL)
/// 
/// Licensed fonts:
/// ✓ BebasNeue - Headings (Google Fonts OFL license)
/// ✓ Poppins - Body text (Google Fonts OFL license)
/// ✓ Inter - UI elements (Google Fonts OFL license)
/// ✓ Satoshi - Modern text (Fontshare FFL license)
class AppFonts {
  // BebasNeue - Display/Heading font (replaces Oddlini)
  static TextStyle bebasNeue({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // For backward compatibility - maps to BebasNeue
  static TextStyle oddlini({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) => bebasNeue(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  // Satoshi - Modern sans-serif font
  static TextStyle satoshi({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Satoshi',
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Poppins - Popular body font
  static TextStyle poppins({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Inter - Clean interface font (replaces Helvetica)
  static TextStyle inter({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // For backward compatibility - maps to Inter
  static TextStyle helvetica({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) => inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  // Convenience methods for common text styles
  
  // Headings - Use Oddlini
  static TextStyle heading1({Color? color}) => oddlini(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle heading2({Color? color}) => oddlini(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle heading3({Color? color}) => oddlini(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: color,
      );

  // Body text - Use Poppins
  static TextStyle bodyLarge({Color? color}) => poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle bodyMedium({Color? color}) => poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle bodySmall({Color? color}) => poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
      );

  // UI elements - Use Inter
  static TextStyle caption({Color? color}) => inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle button({Color? color}) => oddlini(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: color,
      );
}

