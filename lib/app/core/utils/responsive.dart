import 'package:get/get.dart';

/// Responsive utility class for consistent sizing across different screen sizes
class Responsive {
  // Screen dimensions
  static double get screenWidth => Get.width;
  static double get screenHeight => Get.height;

  // Responsive width
  static double width(double percentage) => Get.width * (percentage / 100);
  
  // Responsive height
  static double height(double percentage) => Get.height * (percentage / 100);

  // Responsive font size based on screen width
  static double fontSize(double size) => Get.width * (size / 375); // 375 is base width (iPhone SE)

  // Responsive spacing
  static double sp(double size) => Get.width * (size / 375);

  // Horizontal spacing - REDUCED VALUES
  static double get xs => sp(4); // ~4px
  static double get sm => sp(8); // ~8px
  static double get md => sp(16); // ~16px
  static double get lg => sp(24); // ~24px
  static double get xl => sp(32); // ~32px

  // Vertical spacing - REDUCED VALUES
  static double get xsVertical => sp(4); // ~4px
  static double get smVertical => sp(8); // ~8px
  static double get mdVertical => sp(12); // ~12px
  static double get lgVertical => sp(20); // ~20px
  static double get xlVertical => sp(30); // ~30px

  // Common sizes
  static double get iconSize => sp(24);
  static double get iconSizeSm => sp(18);
  static double get iconSizeLg => sp(32);

  // Border radius
  static double get radiusSm => sp(8);
  static double get radiusMd => sp(12);
  static double get radiusLg => sp(16);
  static double get radiusXl => sp(24);

  // Button heights - REDUCED
  static double get buttonHeight => sp(50); // Fixed ~50px
  static double get buttonHeightLg => sp(56); // Fixed ~56px

  // Text field heights
  static double get textFieldHeight => sp(50);

  // Check if it's a small device
  static bool get isSmallDevice => Get.width < 360;
  
  // Check if it's a large device
  static bool get isLargeDevice => Get.width > 600;

  // Check if it's tablet
  static bool get isTablet => Get.width >= 600 && Get.width < 1024;

  // Check if it's desktop
  static bool get isDesktop => Get.width >= 1024;

  // Scale factor based on design width
  static double scaleWidth(double width) => Get.width / width;

  // Scale factor based on design height
  static double scaleHeight(double height) => Get.height / height;
  
  // Default scale based on Figma design width (393px)
  static double get scale => Get.width / 393.0;

}

