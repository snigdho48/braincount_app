# BrainCount Flutter App - Design System Rules

## Project Overview
BrainCount is a Flutter mobile application built with GetX for state management, featuring a task management system with a dark-themed gradient UI.

---

## 1. Token Definitions

### Colors (`lib/app/core/theme/app_colors.dart`)

**Primary Colors:**
```dart
static const Color primary = Color(0xFF8B5CF6);        // Purple
static const Color primaryDark = Color(0xFF7C3AED);
static const Color primaryLight = Color(0xFFA78BFA);
```

**Gradient Colors:**
```dart
static const Color gradientStart = Color(0xFF8B5CF6);  // Purple
static const Color gradientEnd = Color(0xFFEC4899);    // Pink
```

**Background Colors:**
```dart
static const Color background = Color(0xFF1A0B2E);           // Dark purple
static const Color backgroundDark = Color(0xFF0F0820);       // Darker purple
static const Color cardBackground = Color(0xFF2A1F3D);       // Card purple
static const Color cardDark = Color(0xFF1F1534);             // Darker card
```

**Text Colors:**
```dart
static const Color textWhite = Colors.white;
static const Color textGrey = Color(0xFF9CA3AF);
static const Color textDark = Color(0xFF6B7280);
```

**Status Colors:**
```dart
static const Color success = Color(0xFF10B981);        // Green
static const Color error = Color(0xFFEF4444);          // Red
static const Color warning = Color(0xFFF59E0B);        // Orange
static const Color info = Color(0xFF3B82F6);           // Blue
```

**Gradients:**
```dart
// Primary gradient (used for buttons)
static const LinearGradient primaryGradient = LinearGradient(
  colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],  // Purple → Pink
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

// Background gradient (used for screens)
static const LinearGradient backgroundGradient = LinearGradient(
  colors: [Color(0xFF1A0B2E), Color(0xFF0F0820)],  // Dark purple → Darker
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
```

### Spacing & Sizing (`lib/app/core/utils/responsive.dart`)

**Base Calculation:**
```dart
// All sizes scale based on screen width
// Base width: 375px (iPhone SE)
static double sp(double size) => Get.width * (size / 375);
```

**Horizontal Spacing:**
```dart
static double get xs => sp(4);     // ~4px
static double get sm => sp(8);     // ~8px
static double get md => sp(16);    // ~16px
static double get lg => sp(24);    // ~24px
static double get xl => sp(32);    // ~32px
```

**Vertical Spacing:**
```dart
static double get xsVertical => sp(4);    // ~4px
static double get smVertical => sp(8);    // ~8px
static double get mdVertical => sp(12);   // ~12px
static double get lgVertical => sp(20);   // ~20px
static double get xlVertical => sp(30);   // ~30px
```

**Border Radius:**
```dart
static double get radiusSm => sp(8);     // ~8px
static double get radiusMd => sp(12);    // ~12px
static double get radiusLg => sp(16);    // ~16px
static double get radiusXl => sp(24);    // ~24px
```

**Component Heights:**
```dart
static double get buttonHeight => sp(50);        // ~50px
static double get buttonHeightLg => sp(56);      // ~56px
static double get textFieldHeight => sp(50);     // ~50px
```

**Icon Sizes:**
```dart
static double get iconSizeSm => sp(18);   // ~18px
static double get iconSize => sp(24);     // ~24px
static double get iconSizeLg => sp(32);   // ~32px
```

**Font Sizes:**
```dart
static double fontSize(double size) => Get.width * (size / 375);

// Usage examples:
Responsive.fontSize(12)  // ~12px - small text
Responsive.fontSize(14)  // ~14px - body text
Responsive.fontSize(16)  // ~16px - body text
Responsive.fontSize(18)  // ~18px - subheading
Responsive.fontSize(24)  // ~24px - heading
Responsive.fontSize(32)  // ~32px - large heading
```

**Responsive Breakpoints:**
```dart
static bool get isSmallDevice => Get.width < 360;       // Small phones
static bool get isLargeDevice => Get.width > 600;       // Large phones
static bool get isTablet => Get.width >= 600 && Get.width < 1024;
static bool get isDesktop => Get.width >= 1024;
```

---

## 2. Component Library

### Custom Components (`lib/app/widgets/`)

**Available Components:**
1. `custom_button.dart` - Primary gradient button
2. `custom_text_field.dart` - Styled input fields with validation
3. `stats_card.dart` - Dashboard statistics card
4. `task_card.dart` - Task list item card
5. `brain_loader.dart` - Animated loading indicator
6. `success_modal.dart` - Success message modal
7. `error_modal.dart` - Error message modal

### Component Usage Examples

#### CustomButton
```dart
CustomButton(
  text: 'Login',
  onPressed: () {},
  isLoading: false,
  height: Responsive.buttonHeight,
  fontSize: Responsive.fontSize(16),
)
```

#### CustomTextField
```dart
CustomTextField(
  label: 'Email',
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  prefixIcon: Icon(Icons.email, size: Responsive.iconSize),
  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
)
```

#### StatsCard
```dart
StatsCard(
  title: 'Total Balance',
  value: '৳1,250',
  icon: Icons.account_balance_wallet,
  color: AppColors.primary,
)
```

#### TaskCard
```dart
TaskCard(
  task: Task(
    id: 1,
    title: 'Complete Survey',
    reward: 50.0,
    status: 'pending',
  ),
  onTap: () => Get.to(() => TaskDetailsView()),
)
```

---

## 3. Frameworks & Libraries

### Core Framework
- **Flutter**: Mobile app framework (Dart)
- **GetX**: State management, routing, and dependency injection

### Key Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6                              # State management
  http: ^1.2.2                             # API calls
  shared_preferences: ^2.3.4               # Local storage
  google_sign_in: ^6.2.2                   # Google authentication
  font_awesome_flutter: ^10.10.0           # Icons
  pinput: ^5.0.0                          # OTP input
  flutter_animate: ^4.5.0                  # Animations
  animated_bottom_navigation_bar: ^1.4.0   # Bottom navigation
  permission_handler: ^11.4.0              # Permissions
```

### Build System
- **Gradle**: Android builds
- **CocoaPods**: iOS builds
- **Flutter CLI**: Main build tool

---

## 4. Asset Management

### Asset Structure
```
assets/
  ├── app_icon/              # App icons and logos
  │   ├── braincount-logo.png
  │   ├── favicon.png
  │   └── google_logo.png
  ├── designs/               # Design reference images
  │   ├── login.png
  │   ├── dashboard dafult.png
  │   └── [other design files]
  └── figma_exports/         # Exported Figma assets
```

### Asset Declaration (`pubspec.yaml`)
```yaml
flutter:
  assets:
    - assets/app_icon/
    - assets/designs/
    - assets/figma_exports/
```

### Asset Usage
```dart
// Image assets
Image.asset(
  'assets/app_icon/google_logo.png',
  width: Responsive.sp(24),
  height: Responsive.sp(24),
)

// Network images with placeholder
Image.network(
  imageUrl,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
)
```

### Asset Optimization
- PNG format for logos and icons
- Compress images before adding to project
- Use appropriate image resolutions for different screen densities
- Store Figma exports in `assets/figma_exports/`

---

## 5. Icon System

### Icon Libraries
1. **Material Icons** (default Flutter icons)
2. **FontAwesome** (`font_awesome_flutter` package)

### Icon Usage Patterns
```dart
// Material Icons
Icon(
  Icons.home,
  size: Responsive.iconSize,
  color: AppColors.primary,
)

// FontAwesome Icons
FaIcon(
  FontAwesomeIcons.clipboardCheck,
  size: Responsive.iconSize,
  color: AppColors.textWhite,
)
```

### Icon Conventions
- Use `Responsive.iconSize` (24px) for standard icons
- Use `Responsive.iconSizeSm` (18px) for small icons
- Use `Responsive.iconSizeLg` (32px) for large icons
- Primary color for active/selected states
- Grey for inactive states

---

## 6. Styling Approach

### Design Philosophy
- **Dark Theme**: Purple/pink gradient with dark backgrounds
- **Glassmorphism**: Subtle transparency and blur effects
- **Consistent Spacing**: All spacing uses `Responsive` utility
- **Gradient Accents**: Primary actions use gradient backgrounds
- **Rounded Corners**: All cards/buttons have rounded corners

### Common Styling Patterns

#### Container with Card Style
```dart
Container(
  padding: EdgeInsets.all(Responsive.md),
  decoration: BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(Responsive.radiusLg),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: Responsive.sp(10),
        offset: Offset(0, Responsive.sp(2)),
      ),
    ],
  ),
  child: // content
)
```

#### Gradient Button Container
```dart
Container(
  height: Responsive.buttonHeight,
  decoration: BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(Responsive.radiusXl),
  ),
  child: // button content
)
```

#### Text Styles
```dart
// Heading
Text(
  'Welcome',
  style: TextStyle(
    fontSize: Responsive.fontSize(24),
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  ),
)

// Body text
Text(
  'Description',
  style: TextStyle(
    fontSize: Responsive.fontSize(14),
    color: AppColors.textGrey,
  ),
)
```

#### Full Screen Background
```dart
Container(
  decoration: const BoxDecoration(
    gradient: AppColors.backgroundGradient,
  ),
  child: SafeArea(
    child: SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: Get.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.all(Responsive.md),
            child: // content
          ),
        ),
      ),
    ),
  ),
)
```

---

## 7. Project Structure

### Directory Organization
```
lib/
├── app/
│   ├── core/
│   │   ├── theme/
│   │   │   └── app_colors.dart              # Color tokens
│   │   ├── utils/
│   │   │   └── responsive.dart              # Responsive utility
│   │   └── config/
│   │       └── app_config.dart              # App configuration
│   ├── data/
│   │   ├── models/                          # Data models
│   │   ├── providers/                       # API providers
│   │   └── services/                        # Services (API, Camera, etc.)
│   ├── modules/                             # Feature modules
│   │   ├── auth/
│   │   │   ├── bindings/                    # GetX bindings
│   │   │   ├── controllers/                 # GetX controllers
│   │   │   └── views/                       # UI screens
│   │   ├── dashboard/
│   │   ├── tasks/
│   │   ├── profile/
│   │   └── [other modules]
│   ├── routes/
│   │   ├── app_pages.dart                   # Route definitions
│   │   └── app_routes.dart                  # Route names
│   └── widgets/                             # Reusable widgets
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       └── [other widgets]
└── main.dart                                # App entry point
```

### Feature Module Pattern (GetX)
Each feature follows this structure:
```
module_name/
├── bindings/
│   └── module_binding.dart       # Dependency injection
├── controllers/
│   └── module_controller.dart    # Business logic & state
└── views/
    └── module_view.dart          # UI presentation
```

### State Management Pattern
```dart
// Controller
class DashboardController extends GetxController {
  final balance = 0.0.obs;              // Observable state
  final isLoading = false.obs;
  
  void fetchData() async {
    isLoading.value = true;
    // API call
    isLoading.value = false;
  }
}

// View
class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Text('${controller.balance.value}'));  // Reactive UI
  }
}
```

---

## 8. Figma Integration Guidelines

### When Converting Figma Designs to Flutter:

1. **Colors**: Match Figma colors to `AppColors` constants
2. **Spacing**: Use `Responsive` utility for all measurements
3. **Typography**: Use `Responsive.fontSize()` for text sizes
4. **Icons**: Use Material or FontAwesome icons
5. **Images**: Export to `assets/figma_exports/` and reference properly
6. **Gradients**: Use predefined gradients or create new ones in `AppColors`
7. **Components**: Reuse existing custom widgets when possible
8. **Responsive**: All sizes must use `Responsive.sp()` or predefined values

### Asset Export from Figma:
- Export directory: `d:\braincount_app\braincount\assets\figma_exports`
- Format: PNG or SVG
- Naming: Use lowercase with underscores (e.g., `user_avatar.png`)
- Include @2x and @3x variants for different densities

### Code Generation Pattern:
```dart
// Always import these
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

// Use responsive sizing
Container(
  width: Responsive.width(90),           // Percentage-based width
  height: Responsive.sp(200),            // Fixed responsive height
  margin: EdgeInsets.all(Responsive.md), // Predefined spacing
  padding: EdgeInsets.symmetric(
    horizontal: Responsive.md,
    vertical: Responsive.smVertical,
  ),
  decoration: BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(Responsive.radiusLg),
  ),
)
```

---

## 9. Best Practices

### ✅ DO:
- Use `Responsive` utility for ALL sizing
- Use `AppColors` constants for colors
- Follow GetX pattern (binding → controller → view)
- Make components reusable
- Use `Obx()` for reactive UI updates
- Export Figma assets to `assets/figma_exports/`
- Use descriptive widget names
- Add loading states for async operations
- Handle errors with `ErrorModal`

### ❌ DON'T:
- Use hardcoded pixel values
- Use `const` for values that need to be responsive
- Mix state management patterns
- Create duplicate widgets
- Forget to add assets to `pubspec.yaml`
- Use deprecated methods like `.withOpacity()` (use `.withValues()` instead)
- Ignore lint warnings

---

## 10. Common Patterns

### Navigation
```dart
// Navigate to new screen
Get.to(() => const TaskDetailsView());

// Navigate and replace
Get.off(() => const DashboardView());

// Navigate to named route
Get.toNamed(Routes.PROFILE);

// Go back
Get.back();
```

### Loading States
```dart
Obx(() => controller.isLoading.value
  ? const BrainLoader()
  : YourContent()
)
```

### Modals
```dart
// Success
Get.dialog(SuccessModal(message: 'Task completed!'));

// Error
Get.dialog(ErrorModal(message: 'Something went wrong'));
```

---

## Summary

This Flutter app uses:
- **Framework**: Flutter + GetX
- **Design**: Dark theme with purple/pink gradients
- **Responsive**: Custom `Responsive` utility (375px base width)
- **Colors**: Centralized in `AppColors`
- **Components**: Reusable widgets in `lib/app/widgets/`
- **Assets**: Stored in `assets/` directory, Figma exports go to `assets/figma_exports/`
- **Icons**: Material Icons + FontAwesome
- **Pattern**: GetX MVC (binding → controller → view)

When integrating Figma designs, extract assets to the `figma_exports` folder and ensure all measurements use the `Responsive` utility class.

