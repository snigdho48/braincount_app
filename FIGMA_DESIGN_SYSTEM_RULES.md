# BrainCount Flutter App - Figma Design System Integration Rules

> **Comprehensive guide for integrating Figma designs using Model Context Protocol (MCP)**

---

## 📋 Table of Contents
1. [Token Definitions](#1-token-definitions)
2. [Component Library](#2-component-library)
3. [Frameworks & Libraries](#3-frameworks--libraries)
4. [Asset Management](#4-asset-management)
5. [Icon System](#5-icon-system)
6. [Styling Approach](#6-styling-approach)
7. [Project Structure](#7-project-structure)
8. [Responsive Design](#8-responsive-design)
9. [Implementation Guidelines](#9-implementation-guidelines)

---

## 1. Token Definitions

### 1.1 Color Tokens
**Location**: `lib/app/core/theme/app_colors.dart`

The app uses a **theme-aware** color system that automatically adapts to dark/light mode:

```dart
import 'package:braincount/app/core/theme/app_colors.dart';

// Usage in widgets
Container(
  color: AppColors.background,          // Auto-switches based on theme
  child: Text(
    'Hello',
    style: TextStyle(color: AppColors.primaryText),
  ),
)
```

#### Color Categories:

**Background Colors:**
```dart
AppColors.background           // Dark: #121212, Light: #F5F5F5
AppColors.cardBackground       // Dark: #393838, Light: #FFFFFF
AppColors.tertiaryBackground   // Dark: #212121, Light: #FAFAFA
```

**Text Colors:**
```dart
AppColors.primaryText          // Dark: White, Light: #212121
AppColors.secondaryText        // Dark: #888787, Light: #757575
AppColors.textWhite            // Always white (const for const widgets)
AppColors.disabledText         // Dark: #4A4949, Light: #BDBDBD
```

**Border & Divider Colors:**
```dart
AppColors.border               // Dark: #4A4949, Light: #E0E0E0
AppColors.dividerColor         // Dark: #232323, Light: #E0E0E0
```

**Brand Colors (consistent across themes):**
```dart
AppColors.primary              // #85428C (Purple)
AppColors.primaryLight         // #9D5BAF
AppColors.primaryDark          // #5B099B
```

**Status Colors (consistent across themes):**
```dart
AppColors.success              // #4CAF50 (Green)
AppColors.error                // #F44336 (Red)
AppColors.warning              // #FF9800 (Orange)
AppColors.info                 // #2196F3 (Blue)
```

**Gradients:**
```dart
// Background gradient (auto-switches)
AppColors.backgroundGradient   

// Primary gradient (consistent)
AppColors.primaryGradient      // Purple → Dark Purple → Bright Purple

// Profile card gradient
AppColors.profileCardGradient  // Purple gradient for profile cards
```

---

### 1.2 Typography Tokens
**Location**: Font definitions in `pubspec.yaml`, usage via direct TextStyle

The app uses **licensed open-source fonts** safe for distribution:

#### Font Families Available:

```dart
// 1. BebasNeue (Google Fonts OFL)
// Usage: Display text, headers, titles
TextStyle(
  fontFamily: 'BebasNeue',
  fontWeight: FontWeight.w400,  // Regular
  fontSize: Responsive.fontSize(24),
)

// 2. Poppins (Google Fonts OFL)
// Usage: Body text, cards, buttons
TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,  // Regular
  fontWeight: FontWeight.w500,  // Medium
  fontWeight: FontWeight.w600,  // SemiBold
  fontWeight: FontWeight.w700,  // Bold
  fontSize: Responsive.fontSize(14),
)

// 3. Inter (Google Fonts OFL)
// Usage: Captions, small text, labels
TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,  // Regular
  fontWeight: FontWeight.w500,  // Medium
  fontWeight: FontWeight.w700,  // Bold
  fontSize: Responsive.fontSize(12),
)

// 4. Satoshi (Fontshare FFL)
// Usage: Modern UI elements, navigation
TextStyle(
  fontFamily: 'Satoshi',
  fontWeight: FontWeight.w400,  // Regular
  fontWeight: FontWeight.w500,  // Medium
  fontWeight: FontWeight.w700,  // Bold
  fontSize: Responsive.fontSize(14),
)
```

#### Font Size Scale (with Responsive):
```dart
Responsive.fontSize(48)  // Extra large (H1 display)
Responsive.fontSize(24)  // Large (H2 titles)
Responsive.fontSize(20)  // Headers
Responsive.fontSize(16)  // Body / buttons
Responsive.fontSize(14)  // Small body / labels
Responsive.fontSize(12)  // Captions / hints
Responsive.fontSize(10)  // Extra small
```

---

### 1.3 Spacing Tokens
**Location**: `lib/app/core/utils/responsive.dart`

All spacing uses the **Responsive** class for device-agnostic sizing:

```dart
import 'package:braincount/app/core/utils/responsive.dart';

// Direct sizing (scales with screen width)
Responsive.sp(16)              // 16px at base width (375px)

// Named spacing constants
Responsive.xs                  // 4px
Responsive.sm                  // 8px
Responsive.md                  // 16px
Responsive.lg                  // 24px
Responsive.xl                  // 32px

// Vertical spacing (optimized for height)
Responsive.xsVertical          // 4px
Responsive.smVertical          // 8px
Responsive.mdVertical          // 12px
Responsive.lgVertical          // 20px
Responsive.xlVertical          // 30px
```

**Example Usage:**
```dart
Container(
  padding: EdgeInsets.symmetric(
    horizontal: Responsive.md,        // 16px
    vertical: Responsive.smVertical,  // 8px
  ),
  margin: EdgeInsets.only(
    top: Responsive.lgVertical,       // 20px
    bottom: Responsive.smVertical,    // 8px
  ),
)
```

---

### 1.4 Border Radius Tokens
```dart
Responsive.radiusSm            // 8px
Responsive.radiusMd            // 12px
Responsive.radiusLg            // 16px
Responsive.radiusXl            // 24px

// Usage
BorderRadius.circular(Responsive.radiusMd)
```

---

### 1.5 Component Size Tokens
```dart
Responsive.iconSize            // 24px
Responsive.iconSizeSm          // 18px
Responsive.iconSizeLg          // 32px

Responsive.buttonHeight        // 50px
Responsive.buttonHeightLg      // 56px
Responsive.textFieldHeight     // 50px
```

---

## 2. Component Library

### 2.1 Component Architecture
**Pattern**: GetX + Stateless/Stateful Widgets
**Location**: `lib/app/widgets/` (global) and `lib/app/modules/{module}/widgets/` (module-specific)

### 2.2 Global Reusable Components

#### CustomButton
**Location**: `lib/app/widgets/custom_button.dart`

Standard button with consistent styling:

```dart
CustomButton(
  text: 'Login',
  onPressed: () {},
  isLoading: false,           // Optional: shows loader
  enabled: true,              // Optional: disables button
  backgroundColor: AppColors.primary,
  textColor: Colors.white,
)
```

#### CustomTextField
**Location**: `lib/app/widgets/custom_text_field.dart`

Standard text input field:

```dart
CustomTextField(
  controller: controller,
  hintText: 'Enter email',
  labelText: 'Email',         // Optional
  prefixIcon: Icons.email,    // Optional
  obscureText: false,         // For passwords
  keyboardType: TextInputType.emailAddress,
  validator: (value) => ...,  // Optional validation
)
```

#### UserHeader
**Location**: `lib/app/widgets/user_header.dart`

User profile header with avatar, name, ID:

```dart
UserHeader(
  scale: Responsive.scale,
  onSettingsTap: () {},       // Optional
  onNotificationTap: () {},   // Optional
)
```

#### BrainLoader
**Location**: `lib/app/widgets/brain_loader.dart`

Custom loading indicator:

```dart
BrainLoader(
  message: 'Loading...',      // Optional
  size: 50.0,                 // Optional
)
```

#### SuccessModal / ErrorModal
**Location**: `lib/app/widgets/success_modal.dart`, `error_modal.dart`

Feedback modals:

```dart
// Show success
Get.dialog(SuccessModal(
  title: 'Success!',
  message: 'Task submitted successfully',
  onConfirm: () => Get.back(),
));

// Show error
Get.dialog(ErrorModal(
  title: 'Error',
  message: 'Something went wrong',
  onRetry: () {},             // Optional retry action
));
```

#### StatsCard
**Location**: `lib/app/widgets/stats_card.dart`

Dashboard statistics card:

```dart
StatsCard(
  title: 'Total Earnings',
  value: '\$1,234',
  icon: Icons.attach_money,
  color: AppColors.success,
)
```

#### TaskCard
**Location**: `lib/app/widgets/task_card.dart`

Task display card:

```dart
TaskCard(
  task: taskModel,
  onTap: () {},
  showStatus: true,           // Optional
)
```

---

### 2.3 Module-Specific Components

#### SubmittedTaskCard
**Location**: `lib/app/modules/tasks/widgets/submitted_task_card.dart`

Task card for submitted tasks list.

#### TaskFilterModal
**Location**: `lib/app/modules/tasks/widgets/task_filter_modal.dart`

Bottom sheet modal for task filtering:

```dart
Get.bottomSheet(
  TaskFilterModal(
    onApply: (filters) {
      // Handle applied filters
    },
    initialFilters: controller.advancedFilters.value,
  ),
  isScrollControlled: true,
);
```

---

## 3. Frameworks & Libraries

### 3.1 Core Framework
- **Flutter SDK**: ^3.6.2
- **Dart SDK**: ^3.6.2

### 3.2 State Management
```yaml
get: ^4.7.2  # GetX for state, routing, and dependency injection
```

**Usage Pattern:**
```dart
// Controller
class MyController extends GetxController {
  final count = 0.obs;  // Observable
  
  void increment() => count.value++;
}

// View
class MyView extends GetView<MyController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Text('${controller.count}'));
  }
}

// Binding
class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyController>(() => MyController());
  }
}
```

### 3.3 UI & Styling Libraries
```yaml
flutter_svg: ^2.0.10+1           # SVG support
shimmer: ^3.0.0                  # Loading shimmer effects
dotted_border: ^2.1.0            # Dotted borders
flutter_animate: ^4.5.0          # Animations
animated_bottom_navigation_bar: ^1.4.0  # Bottom nav
```

### 3.4 Media & Permissions
```yaml
camera: ^0.11.0+2                # Camera access
image_picker: ^1.1.2             # Image picking
permission_handler: ^11.3.1      # Permissions
cached_network_image: ^3.4.1     # Image caching
```

### 3.5 Storage & Network
```yaml
shared_preferences: ^2.3.3       # Local storage
http: ^1.2.2                     # HTTP client
```

### 3.6 Authentication
```yaml
google_sign_in: ^6.2.2           # Google OAuth
pinput: ^5.0.0                   # OTP input
```

### 3.7 Utilities
```yaml
intl: ^0.19.0                    # Date/number formatting
font_awesome_flutter: ^10.10.0   # Font Awesome icons
one_request: ^2.1.1              # Permission requests
```

### 3.8 Build Tools
```yaml
flutter_launcher_icons: ^0.14.4  # App icon generation
flutter_native_splash: ^2.4.6    # Splash screen
```

---

## 4. Asset Management

### 4.1 Asset Organization

```
assets/
├── app_icon/               # App icons and logos
│   ├── braincount-logo.png
│   ├── favicon.png
│   └── google_logo.png
│
├── designs/                # Figma design references
│   ├── login.png
│   ├── dashboard dafult.png
│   ├── task list.png
│   └── ... (21 design files)
│
├── figma_exports/          # Exported Figma assets
│   ├── *.svg               # 42 SVG icons
│   └── *.png               # 22 PNG images
│
└── fonts/                  # Licensed font files
    ├── BebasNeue-Regular.ttf
    ├── Poppins-*.ttf
    ├── Inter-*.ttf
    ├── Satoshi-*.ttf
    └── OFL_*.txt           # License files
```

### 4.2 Asset Declaration
**Location**: `pubspec.yaml`

```yaml
flutter:
  assets:
    - assets/designs/
    - assets/app_icon/
    - assets/figma_exports/
    - assets/fonts/
```

### 4.3 Asset Usage

**Images:**
```dart
// Local assets
Image.asset(
  'assets/figma_exports/image_name.png',
  width: Responsive.sp(100),
  height: Responsive.sp(100),
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error);  // Fallback
  },
)

// Network images with caching
CachedNetworkImage(
  imageUrl: 'https://...',
  placeholder: (context, url) => BrainLoader(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

**SVGs:**
```dart
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.asset(
  'assets/figma_exports/icon.svg',
  width: Responsive.iconSize,
  height: Responsive.iconSize,
  color: AppColors.primaryText,  // Optional tint
)
```

### 4.4 Asset Optimization
- **Images**: Use appropriate resolution variants
- **SVGs**: Preferred for icons (smaller size)
- **Caching**: Network images cached via `cached_network_image`
- **Lazy Loading**: Images loaded on-demand

---

## 5. Icon System

### 5.1 Icon Sources

**1. Material Icons (Built-in)**
```dart
Icon(
  Icons.home,
  size: Responsive.iconSize,
  color: AppColors.primaryText,
)
```

**2. Font Awesome Icons**
```dart
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

FaIcon(
  FontAwesomeIcons.user,
  size: Responsive.iconSize,
  color: AppColors.primaryText,
)
```

**3. Custom SVG Icons**
```dart
SvgPicture.asset(
  'assets/figma_exports/{hash}.svg',
  width: Responsive.iconSize,
)
```

### 5.2 Icon Naming Convention
- **Figma exports**: Use hash-based names (e.g., `67a6248f2096d2b2d0548a4eea19bd790cdc22b3.svg`)
- **Custom icons**: Descriptive names (e.g., `filter_icon.svg`)

### 5.3 Icon Sizes
```dart
Responsive.iconSizeSm          // 18px - Small UI elements
Responsive.iconSize            // 24px - Standard icons
Responsive.iconSizeLg          // 32px - Large feature icons
```

---

## 6. Styling Approach

### 6.1 CSS Methodology
**Pattern**: Direct inline styles with theme-aware colors

The app uses **direct Flutter styling** rather than CSS:
- No styled-components equivalent
- Styles defined inline or in reusable widget methods
- Theme awareness via `AppColors` getters

### 6.2 Container Styling Pattern
```dart
Container(
  padding: EdgeInsets.symmetric(
    horizontal: Responsive.md,
    vertical: Responsive.smVertical,
  ),
  decoration: BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(Responsive.radiusMd),
    border: Border.all(
      color: AppColors.border,
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
    gradient: AppColors.primaryGradient,  // Optional
  ),
  child: Text('Content'),
)
```

### 6.3 Text Styling Pattern
```dart
Text(
  'Hello World',
  style: TextStyle(
    fontFamily: 'Poppins',
    fontSize: Responsive.fontSize(16),
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
    letterSpacing: 0.5,
    height: 1.5,  // Line height multiplier
  ),
)
```

### 6.4 Gradient Styling
```dart
// Linear gradient background
decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF85428C),
      Color(0xFF7B1BAB),
    ],
  ),
)

// Radial gradient
decoration: BoxDecoration(
  gradient: RadialGradient(
    center: Alignment.center,
    radius: 1.0,
    colors: [...],
  ),
)
```

### 6.5 Global Styles
**Location**: `lib/app/core/theme/app_theme.dart`

Global theme configuration:

```dart
class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    // ... more theme settings
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    // ... dark theme settings
  );
}
```

### 6.6 Responsive Design Implementation
```dart
// Breakpoint checks
if (Responsive.isSmallDevice) {
  // Adjust for small screens
} else if (Responsive.isTablet) {
  // Tablet layout
} else {
  // Default mobile
}

// Responsive scaling
final scale = Responsive.scaleWidth(393.0);  // Figma design width
Container(
  width: 100 * scale,
  height: 50 * scale,
)
```

---

## 7. Project Structure

### 7.1 Overall Organization

```
lib/
└── app/
    ├── core/                    # Core utilities and config
    │   ├── config/
    │   │   └── app_config.dart
    │   ├── theme/
    │   │   ├── app_colors.dart
    │   │   ├── app_theme.dart
    │   │   └── theme_extensions.dart
    │   └── utils/
    │       ├── app_fonts.dart
    │       └── responsive.dart
    │
    ├── data/                    # Data layer
    │   ├── models/              # Data models
    │   │   ├── task_model.dart
    │   │   ├── user_model.dart
    │   │   └── ... (8 models)
    │   └── services/            # API and utility services
    │       ├── api_service.dart
    │       ├── storage_service.dart
    │       ├── camera_service.dart
    │       └── theme_service.dart
    │
    ├── modules/                 # Feature modules
    │   ├── auth/                # Authentication module
    │   │   ├── bindings/
    │   │   ├── controllers/
    │   │   └── views/
    │   ├── dashboard/           # Dashboard module
    │   ├── tasks/               # Tasks module
    │   │   ├── bindings/
    │   │   ├── controllers/
    │   │   ├── views/
    │   │   └── widgets/         # Module-specific widgets
    │   ├── profile/
    │   ├── withdraw/
    │   └── ...
    │
    ├── routes/                  # Navigation
    │   ├── app_pages.dart
    │   └── app_routes.dart
    │
    └── widgets/                 # Global reusable widgets
        ├── custom_button.dart
        ├── custom_text_field.dart
        ├── user_header.dart
        └── ... (8 widgets)
```

### 7.2 Module Structure Pattern
Each feature module follows this structure:

```
module_name/
├── bindings/
│   └── module_binding.dart      # Dependency injection
├── controllers/
│   └── module_controller.dart   # Business logic
├── views/
│   └── module_view.dart         # UI
└── widgets/                      # Module-specific components
    └── custom_widget.dart
```

### 7.3 File Naming Convention
- **Snake case**: `file_name.dart`
- **Class names**: PascalCase (`ClassName`)
- **Variables**: camelCase (`variableName`)
- **Constants**: camelCase or UPPER_SNAKE_CASE

### 7.4 Feature Organization Pattern

**Separation of Concerns:**
1. **View**: Only UI rendering, no business logic
2. **Controller**: State management and business logic
3. **Service**: API calls and external interactions
4. **Model**: Data structures

**Example:**
```dart
// View (task_list_view.dart)
class TaskListView extends GetView<TaskListController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(...));
  }
}

// Controller (task_list_controller.dart)
class TaskListController extends GetxController {
  final tasks = <TaskModel>[].obs;
  
  void loadTasks() async {
    final data = await ApiService.getTasks();
    tasks.value = data;
  }
}

// Service (api_service.dart)
class ApiService {
  static Future<List<TaskModel>> getTasks() async {
    // HTTP request
  }
}

// Model (task_model.dart)
class TaskModel {
  final int id;
  final String title;
  // ...
}
```

---

## 8. Responsive Design

### 8.1 Responsive Utilities
**Location**: `lib/app/core/utils/responsive.dart`

```dart
// Screen dimensions
Responsive.screenWidth          // Current screen width
Responsive.screenHeight         // Current screen height

// Percentage-based sizing
Responsive.width(50)            // 50% of screen width
Responsive.height(30)           // 30% of screen height

// Scale factors
Responsive.scale                // Based on 393px Figma design
Responsive.scaleWidth(393.0)    // Custom scale factor
Responsive.scaleHeight(852.0)   // Height-based scale

// Device checks
Responsive.isSmallDevice        // Width < 360
Responsive.isLargeDevice        // Width > 600
Responsive.isTablet             // 600 <= Width < 1024
Responsive.isDesktop            // Width >= 1024

// Responsive sizing
Responsive.sp(16)               // Scales with screen width
Responsive.fontSize(14)         // Font size scaling
```

### 8.2 Breakpoint Strategy
```dart
Widget buildResponsive() {
  if (Responsive.isSmallDevice) {
    return CompactLayout();
  } else if (Responsive.isTablet) {
    return TabletLayout();
  } else {
    return StandardLayout();
  }
}
```

### 8.3 Figma to Flutter Conversion

**Step 1**: Note Figma design dimensions (e.g., 393×852)

**Step 2**: Calculate scale factor:
```dart
final scale = Responsive.scaleWidth(393.0);
```

**Step 3**: Apply scale to all dimensions:
```dart
Container(
  width: 100 * scale,        // 100px in Figma
  height: 50 * scale,        // 50px in Figma
  padding: EdgeInsets.all(16 * scale),
)
```

**Step 4**: Use responsive font sizes:
```dart
Text(
  'Title',
  style: TextStyle(
    fontSize: Responsive.fontSize(20),  // 20px in Figma
  ),
)
```

---

## 9. Implementation Guidelines

### 9.1 Figma to Flutter Workflow

**1. Extract Design Tokens**
```
Figma → Inspect → Note:
- Colors (hex values)
- Font families & sizes
- Spacing values
- Border radius
- Shadow properties
```

**2. Map to Existing Tokens**
```dart
// Figma color #85428C → AppColors.primary
// Figma spacing 16px → Responsive.md
// Figma font 'Poppins Medium 14px' → TextStyle(fontFamily: 'Poppins', fontSize: Responsive.fontSize(14), fontWeight: FontWeight.w500)
```

**3. Use Existing Components**
Before creating new components, check:
- `lib/app/widgets/` for global components
- `lib/app/modules/{module}/widgets/` for module components

**4. Build New Components**
If no existing component fits:
```dart
// Create reusable widget
class NewComponent extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  
  const NewComponent({
    required this.title,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Responsive.md),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(Responsive.radiusMd),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: Responsive.fontSize(14),
            color: AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}
```

**5. Handle Theme Switching**
Always use `AppColors` getters instead of hardcoded colors:
```dart
// ❌ Wrong
color: Color(0xFF393838)

// ✅ Correct
color: AppColors.cardBackground
```

**6. Implement Responsive Sizing**
```dart
// ❌ Wrong
width: 100
height: 50

// ✅ Correct
width: Responsive.sp(100)
height: Responsive.sp(50)
```

**7. Export and Use Figma Assets**
```bash
# Export from Figma as SVG/PNG
# Place in assets/figma_exports/
# Reference in code
Image.asset('assets/figma_exports/exported_image.png')
```

---

### 9.2 Common Patterns

#### Modal/Bottom Sheet
```dart
Get.bottomSheet(
  Container(
    height: Get.height * 0.8,
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(Responsive.radiusLg),
      ),
    ),
    child: YourWidget(),
  ),
  isScrollControlled: true,
  isDismissible: true,
);
```

#### Loading State
```dart
Obx(() => controller.isLoading.value
  ? BrainLoader(message: 'Loading...')
  : YourContent()
)
```

#### List with Filter Chips
```dart
// Filter chips above list
Column(
  children: [
    if (chips.isNotEmpty) _buildFilterChips(chips),
    Expanded(
      child: ListView.builder(...),
    ),
  ],
)
```

#### Card with Gradient
```dart
Container(
  decoration: BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(Responsive.radiusMd),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: YourContent(),
)
```

---

### 9.3 Best Practices

1. **Always use Responsive for sizing**
   - Never hardcode pixel values
   - Use `Responsive.sp()` for all dimensions

2. **Always use AppColors for colors**
   - Theme-aware by default
   - Consistent across the app

3. **Prefer existing components**
   - Check widget library first
   - Extend existing components when possible

4. **Follow GetX patterns**
   - Views extend `GetView<Controller>`
   - Use `Obx()` for reactive UI
   - Inject dependencies via bindings

5. **Handle loading/error states**
   - Show `BrainLoader` for loading
   - Use `ErrorModal` for errors
   - Provide fallbacks for images

6. **Optimize assets**
   - Use SVG for icons when possible
   - Compress images before adding
   - Lazy load network images

7. **Test on multiple screen sizes**
   - Small (< 360px)
   - Standard (375-414px)
   - Tablet (600+ px)

8. **Use proper error handling**
   ```dart
   try {
     await someAsyncOperation();
   } catch (e) {
     Get.dialog(ErrorModal(message: e.toString()));
   }
   ```

9. **Maintain consistency**
   - Use same spacing scale
   - Same border radius values
   - Same shadow properties

10. **Document complex logic**
    - Add comments for non-obvious code
    - Explain business rules
    - Note Figma design references

---

## 10. Quick Reference

### Color Quick Pick
```dart
// Backgrounds
AppColors.background
AppColors.cardBackground
AppColors.tertiaryBackground

// Text
AppColors.primaryText
AppColors.secondaryText
AppColors.textWhite

// Brand
AppColors.primary
AppColors.primaryGradient

// Status
AppColors.success
AppColors.error
AppColors.warning
AppColors.info
```

### Spacing Quick Pick
```dart
// Horizontal
Responsive.xs   // 4px
Responsive.sm   // 8px
Responsive.md   // 16px
Responsive.lg   // 24px
Responsive.xl   // 32px

// Vertical
Responsive.smVertical   // 8px
Responsive.mdVertical   // 12px
Responsive.lgVertical   // 20px
```

### Typography Quick Pick
```dart
// BebasNeue - Headers
fontFamily: 'BebasNeue'
fontSize: Responsive.fontSize(24)

// Poppins - Body
fontFamily: 'Poppins'
fontSize: Responsive.fontSize(14)
fontWeight: FontWeight.w500

// Inter - Captions
fontFamily: 'Inter'
fontSize: Responsive.fontSize(12)

// Satoshi - UI
fontFamily: 'Satoshi'
fontSize: Responsive.fontSize(14)
fontWeight: FontWeight.w500
```

---

## 11. Troubleshooting

### Common Issues

**Issue**: Colors not updating with theme
**Solution**: Use `AppColors` getters, not const values

**Issue**: UI not responsive on different devices
**Solution**: Use `Responsive.sp()` for all sizing

**Issue**: Fonts not loading
**Solution**: Check `pubspec.yaml` font declarations and paths

**Issue**: Assets not found
**Solution**: Verify asset paths in `pubspec.yaml` and run `flutter pub get`

**Issue**: Obx not rebuilding
**Solution**: Ensure observable variables use `.obs` and access with `.value`

---

## 12. Additional Resources

- **Project Docs**: See `DESIGN_SYSTEM.md`, `THEME_MIGRATION_GUIDE.md`
- **GetX Documentation**: https://pub.dev/packages/get
- **Flutter Responsive**: https://docs.flutter.dev/ui/layout/responsive
- **Material Design**: https://m3.material.io/

---

**Last Updated**: October 22, 2025
**Version**: 1.0.0

