# BrainCount Flutter App - Complete Design System Documentation

## 📋 Table of Contents
1. [Font Management](#font-management)
2. [Color System](#color-system)
3. [Reusable Components](#reusable-components)
4. [Responsive Design](#responsive-design)
5. [Widget Patterns](#widget-patterns)
6. [Best Practices](#best-practices)

---

## 🔤 Font Management

### Current Implementation
The project uses **Google Fonts** package for font management:

```yaml
dependencies:
  google_fonts: ^6.2.1
```

### Fonts Used in Design
Based on Figma design analysis, the following fonts are used:

1. **Oddlini** (Display/Headers)
   - Weight: 700 (Bold)
   - Usage: Page titles, headings, button text
   
2. **Satoshi** (Body/UI)
   - Weight: 500 (Medium), 700 (Bold)
   - Usage: Labels, section titles, body text
   
3. **Helvetica** (Alternative Body)
   - Weight: 400 (Regular), 700 (Bold)
   - Usage: Input fields, descriptions, helper text
   
4. **Poppins** (Alternative Sans-serif)
   - Weight: 400-600
   - Usage: Cards, secondary text
   
5. **Inter** (Alternative Sans-serif)
   - Weight: 500 (Medium)
   - Usage: Subtitles, captions
   
6. **Urbanist** (UI Text)
   - Weight: 500 (Medium), 600 (SemiBold)
   - Usage: Navigation, small UI elements

### Font Implementation with Google Fonts

#### Method 1: Using Google Fonts Package (Recommended)
```dart
import 'package:google_fonts/google_fonts.dart';

Text(
  'Hello World',
  style: GoogleFonts.inter(
    fontSize: 16 * scale,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
)
```

#### Method 2: Create Text Style Helpers
Create `lib/app/core/theme/text_styles.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Scale factor passed from widget
  static TextStyle heading1(double scale) => GoogleFonts.inter(
    fontSize: 48 * scale,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle heading2(double scale) => GoogleFonts.inter(
    fontSize: 20 * scale,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle body(double scale) => GoogleFonts.inter(
    fontSize: 14 * scale,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle label(double scale) => GoogleFonts.inter(
    fontSize: 10 * scale,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF7B7B7B),
  );

  static TextStyle button(double scale) => GoogleFonts.inter(
    fontSize: 16 * scale,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
}
```

### Font Fallback Strategy
If a specific font is not available via Google Fonts, use system fallbacks:

```dart
TextStyle(
  fontFamily: 'Oddlini',  // Primary
  fontFamilyFallback: const ['Inter', 'Helvetica', 'sans-serif'],
  fontSize: 20 * scale,
  fontWeight: FontWeight.w700,
)
```

### Local Font Installation (Alternative)
If you prefer local fonts, download and add them:

```yaml
# pubspec.yaml
flutter:
  fonts:
    - family: Oddlini
      fonts:
        - asset: assets/fonts/Oddlini/Oddlini-Bold.ttf
          weight: 700
    
    - family: Satoshi
      fonts:
        - asset: assets/fonts/Satoshi/Satoshi-Medium.ttf
          weight: 500
        - asset: assets/fonts/Satoshi/Satoshi-Bold.ttf
          weight: 700
    
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter/Inter-Regular.ttf
          weight: 400
        - asset: assets/fonts/Inter/Inter-Medium.ttf
          weight: 500
        - asset: assets/fonts/Inter/Inter-Bold.ttf
          weight: 700
```

---

## 🎨 Color System

### Primary Colors
```dart
// Backgrounds
const Color(0xFF232323) // Main dark background
const Color(0xFF393838) // Card/Container background
const Color(0xFF303030) // Input field background
const Color(0xFF160531) // Dashboard purple background

// Brand Colors
const Color(0xFFFFBB27) // Primary yellow/gold
const Color(0xFF0A97F5) // Primary blue/accent
const Color(0xFF27AF40) // Success green

// Text Colors
Colors.white              // Primary text
const Color(0xFF888787)  // Secondary text
const Color(0xFF7B7B7B)  // Tertiary text
const Color(0xFFA9ACB4)  // Placeholder text
const Color(0xFFCBD0DC)  // Inactive text
```

### Gradient Colors
```dart
// Purple Gradient (Labels, Headers)
const LinearGradient(
  colors: [Color(0xFF5B099B), Color(0xFF5B099B)],
)

// Pink-Purple Gradient (Navigation, Buttons)
const LinearGradient(
  colors: [Color(0xFFE786C2), Color(0xFF85428C)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
)

// Blue-Purple Gradient (Primary Buttons)
const RadialGradient(
  center: Alignment(-0.126, -2.234),
  radius: 1.5,
  colors: [
    Color(0xEB58A3D8), // Light blue
    Color(0xE78C98EC), // Medium blue
    Color(0xE3C08EFF), // Light purple
  ],
  stops: [0.242, 0.545, 0.849],
)
```

### Create Color Constants File
`lib/app/core/theme/app_colors.dart`:

```dart
import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const background = Color(0xFF232323);
  static const cardBackground = Color(0xFF393838);
  static const inputBackground = Color(0xFF303030);
  static const dashboardBackground = Color(0xFF160531);

  // Brand
  static const primary = Color(0xFFFFBB27);
  static const accent = Color(0xFF0A97F5);
  static const success = Color(0xFF27AF40);
  static const error = Colors.red;

  // Text
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFF888787);
  static const textTertiary = Color(0xFF7B7B7B);
  static const textPlaceholder = Color(0xFFA9ACB4);
  static const textInactive = Color(0xFFCBD0DC);

  // Gradients
  static const purpleGradient = LinearGradient(
    colors: [Color(0xFF5B099B), Color(0xFF5B099B)],
  );

  static const pinkPurpleGradient = LinearGradient(
    colors: [Color(0xFFE786C2), Color(0xFF85428C)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const buttonGradient = RadialGradient(
    center: Alignment(-0.126, -2.234),
    radius: 1.5,
    colors: [
      Color(0xEB58A3D8),
      Color(0xE78C98EC),
      Color(0xE3C08EFF),
    ],
    stops: [0.242, 0.545, 0.849],
  );
}
```

---

## 🧩 Reusable Components

### 1. UserHeader Widget
**Location**: `lib/app/widgets/user_header.dart`

**Usage**:
```dart
UserHeader(
  scale: scale,
  showSettings: true,
  onSettingsTap: () => Get.toNamed(AppRoutes.profile),
)
```

**Props**:
- `scale`: double - Responsive scale factor
- `showSettings`: bool - Show/hide settings button
- `onSettingsTap`: VoidCallback? - Settings button callback

### 2. CustomButton Widget
**Location**: `lib/app/widgets/custom_button.dart`

**Usage**:
```dart
CustomButton(
  text: 'Submit',
  onPressed: () {},
  isLoading: false,
  gradient: AppColors.buttonGradient,
)
```

### 3. CustomTextField Widget
**Location**: `lib/app/widgets/custom_text_field.dart`

**Usage**:
```dart
CustomTextField(
  controller: controller,
  label: 'Email',
  hintText: 'Enter your email',
  keyboardType: TextInputType.emailAddress,
)
```

### 4. Common Modal Widgets
**Locations**:
- `lib/app/widgets/success_modal.dart`
- `lib/app/widgets/error_modal.dart`
- `lib/app/widgets/brain_loader.dart`

### 5. Task Card Widget
**Location**: `lib/app/modules/tasks/widgets/task_card.dart`

### 6. Stats Card Widget
Used in Dashboard and Balance History

---

## 📐 Responsive Design

### Scale Factor Pattern
**Every dimension must be multiplied by scale**:

```dart
final screenWidth = MediaQuery.of(context).size.width;
final baseWidth = 393.0; // iPhone design width
final scale = screenWidth / baseWidth;

// Apply to ALL dimensions
Container(
  width: 360 * scale,
  height: 45 * scale,
  padding: EdgeInsets.all(12 * scale),
  margin: EdgeInsets.only(bottom: 8 * scale),
  child: Text(
    'Hello',
    style: TextStyle(fontSize: 16 * scale),
  ),
)
```

### Responsive Utility Class (Optional)
Create `lib/app/core/utils/responsive.dart`:

```dart
import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  late final double scale;
  late final double width;
  late final double height;

  Responsive(this.context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = width / 393.0; // Base width
  }

  double w(double size) => size * scale;
  double h(double size) => size * scale;
  double sp(double size) => size * scale;
}

// Usage
final responsive = Responsive(context);
Container(
  width: responsive.w(360),
  height: responsive.h(45),
  child: Text(
    'Hello',
    style: TextStyle(fontSize: responsive.sp(16)),
  ),
)
```

---

## 🎯 Widget Patterns

### 1. Common Pattern: Build Methods
Instead of repeating code, extract to build methods:

```dart
Widget _buildSection(double scale) {
  return Container(
    padding: EdgeInsets.all(16 * scale),
    child: Column(
      children: [
        _buildTitle(scale),
        _buildContent(scale),
      ],
    ),
  );
}
```

### 2. Reusable Input Field Pattern
```dart
Widget _buildInputField({
  required String label,
  required String hintText,
  required TextEditingController controller,
  required double scale,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Label
      Text(label, style: TextStyle(fontSize: 10 * scale)),
      SizedBox(height: 4 * scale),
      // Input
      TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    ],
  );
}
```

### 3. Card Pattern
```dart
Widget _buildCard({
  required Widget child,
  required double scale,
  bool isSelected = false,
}) {
  return Container(
    padding: EdgeInsets.all(12 * scale),
    decoration: BoxDecoration(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(11 * scale),
      border: isSelected
          ? Border.all(color: AppColors.accent, width: 2)
          : null,
    ),
    child: child,
  );
}
```

---

## ✅ Best Practices

### 1. Always Use Scale Factor
```dart
// ❌ BAD
Container(width: 100, height: 50)

// ✅ GOOD
Container(width: 100 * scale, height: 50 * scale)
```

### 2. Use Const Constructors
```dart
// ✅ GOOD - Improves performance
const SizedBox(width: double.infinity)
const Icon(Icons.home)
```

### 3. Extract Reusable Widgets
```dart
// ❌ BAD - Repeating same widget
// In multiple files

// ✅ GOOD - Create reusable widget
// lib/app/widgets/user_header.dart
```

### 4. Use GetX for State Management
```dart
// Observable
final counter = 0.obs;

// Update
counter.value++;

// React to changes
Obx(() => Text('${controller.counter}'))
```

### 5. Error Handling for Images
```dart
Image.asset(
  'path/to/image.png',
  errorBuilder: (context, error, stackTrace) => Icon(Icons.fallback),
)
```

### 6. Dispose Controllers
```dart
@override
void onClose() {
  controller.dispose();
  super.onClose();
}
```

---

## 📂 Project Structure

```
lib/
├── app/
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_colors.dart      # Color constants
│   │   │   ├── app_theme.dart       # Theme config
│   │   │   └── text_styles.dart     # Text style helpers
│   │   ├── config/
│   │   │   └── app_config.dart
│   │   └── utils/
│   │       └── responsive.dart      # Responsive utility
│   │
│   ├── data/
│   │   ├── models/                  # Data models
│   │   └── services/                # API, Storage services
│   │
│   ├── modules/                     # Feature modules
│   │   ├── auth/
│   │   ├── dashboard/
│   │   ├── tasks/
│   │   ├── balance/
│   │   └── withdraw/
│   │
│   ├── widgets/                     # Shared widgets
│   │   ├── user_header.dart         # ✅ NEW
│   │   ├── custom_button.dart
│   │   ├── custom_text_field.dart
│   │   ├── success_modal.dart
│   │   ├── error_modal.dart
│   │   └── brain_loader.dart
│   │
│   └── routes/
│       ├── app_pages.dart
│       └── app_routes.dart
│
└── main.dart
```

---

## 🔄 Migration Guide

### Step 1: Replace _buildUserHeader
Replace all instances of `_buildUserHeader` with the new `UserHeader` widget:

**Before**:
```dart
_buildUserHeader(scale)
```

**After**:
```dart
UserHeader(scale: scale)
```

### Step 2: Update Imports
```dart
import '../../widgets/user_header.dart';
```

### Step 3: Use Color Constants
Replace hardcoded colors with `AppColors`:

**Before**:
```dart
color: const Color(0xFF232323)
```

**After**:
```dart
color: AppColors.background
```

---

## 🎓 Font Setup Checklist

- [x] Using `google_fonts: ^6.2.1`
- [ ] Create `text_styles.dart` helper file
- [ ] Replace all `fontFamily: 'Oddlini'` with `GoogleFonts.inter()`
- [ ] Test fonts on multiple devices
- [ ] Add font fallbacks
- [ ] Document custom fonts if needed

---

## 📚 Additional Resources

- [Google Fonts Package](https://pub.dev/packages/google_fonts)
- [Flutter Text Styling](https://docs.flutter.dev/cookbook/design/fonts)
- [GetX State Management](https://pub.dev/packages/get)
- [Responsive Design in Flutter](https://docs.flutter.dev/ui/layout/responsive)

---

**Last Updated**: 2025-01-20
**Version**: 1.0.0
**Maintained by**: BrainCount Development Team

