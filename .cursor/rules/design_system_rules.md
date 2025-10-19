# BrainCount Flutter App - Design System Rules

## 1. Token Definitions

### Colors (`lib/app/core/theme/app_colors.dart`)
```dart
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF8B5CF6);
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color primaryDark = Color(0xFF7C3AED);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF1A0B2E), Color(0xFF16213E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Background Colors
  static const Color background = Color(0xFF1A0B2E);
  static const Color cardBackground = Color(0xFF16213E);
  static const Color cardDark = Color(0xFF0F172A);
  
  // Text Colors
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFF94A3B8);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // Border Colors
  static const Color borderColor = Color(0xFF334155);
}
```

### Responsive Sizing (`lib/app/core/utils/responsive.dart`)
```dart
class Responsive {
  // Spacing
  static double get xs => sp(4);      // ~4px
  static double get sm => sp(8);      // ~8px
  static double get md => sp(16);     // ~16px
  static double get lg => sp(24);     // ~24px
  static double get xl => sp(32);     // ~32px
  
  // Vertical Spacing
  static double get xsVertical => sp(4);   // ~4px
  static double get smVertical => sp(8);   // ~8px
  static double get mdVertical => sp(12);  // ~12px
  static double get lgVertical => sp(20);  // ~20px
  static double get xlVertical => sp(30);  // ~30px
  
  // Typography
  static double fontSize(double size) => Get.width * (size / 375);
  
  // Icons
  static double get iconSize => sp(24);
  static double get iconSizeSm => sp(18);
  static double get iconSizeLg => sp(32);
  
  // Border Radius
  static double get radiusSm => sp(8);
  static double get radiusMd => sp(12);
  static double get radiusLg => sp(16);
  static double get radiusXl => sp(24);
  
  // Button Heights
  static double get buttonHeight => sp(50);
  static double get buttonHeightLg => sp(56);
}
```

### Typography
- Base font: System default (Material Design)
- Enhanced fonts: Google Fonts (configured in `pubspec.yaml`)
- Font sizing: Always use `Responsive.fontSize(size)` for responsive text

## 2. Component Library

### Location
All reusable components are in `lib/app/widgets/`

### Core Components

#### CustomButton (`lib/app/widgets/custom_button.dart`)
```dart
CustomButton(
  text: 'Login',
  onPressed: () {},
  isLoading: false,
  isOutlined: false,
  icon: FontAwesomeIcons.check, // Optional
)
```

#### CustomTextField (`lib/app/widgets/custom_text_field.dart`)
```dart
CustomTextField(
  label: 'Email',
  hint: 'Enter your email',
  controller: emailController,
  isRequired: true,
  prefixIcon: FontAwesomeIcons.envelope,
  keyboardType: TextInputType.emailAddress,
  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
)
```

#### StatsCard (`lib/app/widgets/stats_card.dart`)
```dart
StatsCard(
  icon: FontAwesomeIcons.tasks,
  label: 'Total Tasks',
  value: '150',
  color: AppColors.primary,
)
```

#### TaskCard (`lib/app/widgets/task_card.dart`)
```dart
TaskCard(
  task: taskModel,
  onTap: () => Get.to(() => TaskDetailsView()),
)
```

#### Modals
```dart
// Success Modal
SuccessModal.show(
  context,
  title: 'Success',
  message: 'Operation completed',
  onPressed: () => Get.back(),
);

// Error Modal
ErrorModal.show(
  context,
  title: 'Error',
  message: 'Something went wrong',
  onPressed: () => Get.back(),
);
```

#### BrainLoader (`lib/app/widgets/brain_loader.dart`)
```dart
BrainLoader(
  message: 'Loading...',
  size: 100, // Optional
)
```

## 3. Frameworks & Libraries

### Core Framework
- **Flutter**: Cross-platform mobile framework
- **Dart**: Programming language

### Key Dependencies
```yaml
# State Management & Navigation
get: ^4.7.2

# UI Components
font_awesome_flutter: ^10.10.0
animated_bottom_navigation_bar: ^1.4.0
flutter_animate: ^4.5.0

# Networking
one_request: ^2.1.1
http: ^1.2.2

# Local Storage
shared_preferences: ^2.3.3

# Image Handling
camera: ^0.11.0+2
image_picker: ^1.1.2
cached_network_image: ^3.4.1

# UI Enhancements
shimmer: ^3.0.0
dotted_border: ^2.1.0
pinput: ^5.0.0

# Icons & Images
flutter_svg: ^2.0.10+1
```

## 4. Asset Management

### Directory Structure
```
assets/
├── app_icon/
│   ├── favicon.png
│   └── braincount-logo.png
└── designs/
    ├── login.png
    ├── register.png
    ├── dashboard dafult.png
    └── [other design references]
```

### Asset Declaration (`pubspec.yaml`)
```yaml
flutter:
  assets:
    - assets/app_icon/
    - assets/designs/
```

### Usage Patterns
```dart
// Local Images
Image.asset(
  'assets/app_icon/braincount-logo.png',
  width: Responsive.width(30),
  height: Responsive.height(10),
  fit: BoxFit.contain,
)

// Network Images with Cache
CachedNetworkImage(
  imageUrl: 'https://example.com/image.png',
  placeholder: (context, url) => BrainLoader(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)

// Base64 Images (preferred for API responses)
Image.memory(base64Decode(base64String))
```

## 5. Icon System

### Primary Icon Library
- **Font Awesome Flutter** (`font_awesome_flutter: ^10.10.0`)

### Usage Pattern
```dart
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Standard Icons
FaIcon(
  FontAwesomeIcons.house,
  color: AppColors.primary,
  size: Responsive.iconSize,
)

// In Buttons
IconButton(
  icon: FaIcon(
    FontAwesomeIcons.eye,
    size: Responsive.iconSizeSm,
  ),
  onPressed: () {},
)
```

### Common Icons
- Navigation: `house`, `listCheck`, `user`
- Actions: `eye`, `eyeSlash`, `check`, `close`
- Forms: `envelope`, `lock`, `user`
- Social: `google`

## 6. Styling Approach

### Design Pattern
- **Material Design** with custom dark theme
- **GetX** for state management and navigation
- **Responsive sizing** for all dimensions

### Global Theme (`lib/app/core/theme/app_theme.dart`)
```dart
class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    // ... more theme config
  );
}
```

### Responsive Implementation Rules

#### ✅ DO:
```dart
// Use Responsive utilities
padding: EdgeInsets.all(Responsive.md),
height: Responsive.buttonHeight,
fontSize: Responsive.fontSize(16),
borderRadius: BorderRadius.circular(Responsive.radiusMd),

// Use predefined spacing
SizedBox(height: Responsive.mdVertical),
SizedBox(width: Responsive.sm),
```

#### ❌ DON'T:
```dart
// Avoid hardcoded values
padding: EdgeInsets.all(16),
height: 50,
fontSize: 16,
borderRadius: BorderRadius.circular(12),

// Avoid percentage-based heights (too large)
height: MediaQuery.of(context).size.height * 0.5,
```

### Container Styling Pattern
```dart
Container(
  padding: EdgeInsets.all(Responsive.md),
  decoration: BoxDecoration(
    color: AppColors.cardDark,
    borderRadius: BorderRadius.circular(Responsive.radiusLg),
    border: Border.all(
      color: AppColors.borderColor,
      width: Responsive.sp(1),
    ),
    gradient: AppColors.primaryGradient, // Optional
  ),
  child: // ...
)
```

## 7. Project Structure

### Directory Organization
```
lib/
├── main.dart
└── app/
    ├── core/
    │   ├── config/
    │   │   └── app_config.dart          # App-wide configuration
    │   ├── theme/
    │   │   ├── app_colors.dart          # Color tokens
    │   │   └── app_theme.dart           # Theme configuration
    │   └── utils/
    │       └── responsive.dart          # Responsive utilities
    ├── data/
    │   ├── models/                      # Data models
    │   │   ├── user_model.dart
    │   │   ├── task_model.dart
    │   │   └── ...
    │   └── services/                    # Service layer
    │       ├── api_service.dart
    │       ├── storage_service.dart
    │       └── camera_service.dart
    ├── modules/                         # Feature modules (GetX pattern)
    │   ├── splash/
    │   │   ├── bindings/
    │   │   ├── controllers/
    │   │   └── views/
    │   ├── auth/
    │   │   ├── bindings/
    │   │   ├── controllers/
    │   │   └── views/
    │   ├── dashboard/
    │   ├── tasks/
    │   ├── profile/
    │   └── ...
    ├── routes/
    │   ├── app_pages.dart               # Route definitions
    │   └── app_routes.dart              # Route constants
    └── widgets/                         # Reusable widgets
        ├── custom_button.dart
        ├── custom_text_field.dart
        ├── stats_card.dart
        └── ...
```

### Module Pattern (GetX CLI)
Each feature follows this structure:
```
module_name/
├── bindings/
│   └── module_binding.dart          # Dependency injection
├── controllers/
│   └── module_controller.dart       # Business logic
└── views/
    └── module_view.dart             # UI
```

### Navigation Pattern
```dart
// Named routes (preferred)
Get.toNamed(AppRoutes.dashboard);
Get.offAllNamed(AppRoutes.home);

// Direct navigation
Get.to(() => DashboardView());
Get.off(() => LoginView());
```

## 8. Figma to Flutter Conversion Guide

### When Converting Figma Designs:

1. **Colors**: Map to `AppColors` constants
2. **Spacing**: Use `Responsive.md`, `Responsive.lg`, etc.
3. **Typography**: Use `Responsive.fontSize(size)`
4. **Components**: Reuse existing widgets from `lib/app/widgets/`
5. **Icons**: Use Font Awesome icons
6. **Images**: Store in `assets/` and declare in `pubspec.yaml`

### Example Conversion
```dart
// Figma: Container with padding 16px, purple background
Container(
  padding: EdgeInsets.all(Responsive.md),  // 16px → Responsive.md
  decoration: BoxDecoration(
    color: AppColors.primary,                // Purple → AppColors.primary
    borderRadius: BorderRadius.circular(Responsive.radiusMd),
  ),
  child: Text(
    'Hello',
    style: TextStyle(
      color: AppColors.textWhite,
      fontSize: Responsive.fontSize(16),
    ),
  ),
)
```

## 9. API Integration Pattern

### Using one_request
```dart
// In ApiService
static Future<Map<String, dynamic>> fetchData() async {
  final result = await _request.send<Map<String, dynamic>>(
    url: '/endpoint',
    method: RequestType.GET,
    loader: true,
    maxRetries: 2,
  );
  
  return result.fold(
    (data) => data,
    (error) => throw Exception(error),
  );
}
```

### Image Handling (Base64)
```dart
// Always use base64 for images
final base64Image = base64Encode(imageBytes);

// API request
await ApiService.uploadImage({'image': base64Image});

// Display
Image.memory(base64Decode(base64Image))
```

## 10. State Management Pattern

### Controller Structure
```dart
class MyController extends GetxController {
  // Reactive variables
  final isLoading = false.obs;
  final userData = Rxn<UserModel>();
  
  // Text controllers
  final emailController = TextEditingController();
  
  // Form key
  final formKey = GlobalKey<FormState>();
  
  @override
  void onInit() {
    super.onInit();
    // Initialize
  }
  
  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
  
  // Methods
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      // Fetch logic
    } finally {
      isLoading.value = false;
    }
  }
}
```

### View Structure
```dart
class MyView extends GetView<MyController> {
  const MyView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const BrainLoader();
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(Responsive.lg),
            child: // ... content
          );
        }),
      ),
    );
  }
}
```

---

## Quick Reference Card

### Most Common Patterns

```dart
// Spacing
padding: EdgeInsets.all(Responsive.md)
SizedBox(height: Responsive.mdVertical)

// Colors
color: AppColors.primary
decoration: BoxDecoration(gradient: AppColors.primaryGradient)

// Typography
fontSize: Responsive.fontSize(16)

// Border Radius
borderRadius: BorderRadius.circular(Responsive.radiusMd)

// Icons
FaIcon(FontAwesomeIcons.icon, size: Responsive.iconSize)

// Navigation
Get.toNamed(AppRoutes.route)

// State
Obx(() => Text(controller.value.value))

// Loading
const BrainLoader(message: 'Loading...')
```

