# BrainCount Flutter App - Design System Rules

## 1. Token Definitions

### Colors
Colors are defined directly in code as `Color` objects:

```dart
// Primary Colors
const Color(0xFF232323) // Background dark
const Color(0xFF393838) // Card/Container background
const Color(0xFF303030) // Input field background
const Color(0xFFFFBB27) // Primary yellow/gold
const Color(0xFF0A97F5) // Primary blue/link color
const Color(0xFF27AF40) // Success green

// Text Colors
Colors.white // Primary text
const Color(0xFF888787) // Secondary text
const Color(0xFF7B7B7B) // Tertiary text
const Color(0xFFA9ACB4) // Placeholder/hint text
const Color(0xFFCBD0DC) // Inactive text

// Gradient Colors
const Color(0xFF5B099B) // Purple gradient
const Color(0xFFE786C2) // Pink gradient
const Color(0xFF85428C) // Dark purple gradient
const Color(0xEB58A3D8) // Light blue gradient (rgba(88,163,216,0.92))
const Color(0xE78C98EC) // Medium blue gradient (rgba(140,152,236,0.905))
const Color(0xE3C08EFF) // Light purple gradient (rgba(192,142,255,0.89))
```

### Typography
**Fonts are managed through Google Fonts package:**

```yaml
dependencies:
  google_fonts: ^6.2.1
```

#### Font Families & Usage
```dart
// Using Google Fonts (Recommended)
import 'package:google_fonts/google_fonts.dart';

Text(
  'Hello World',
  style: GoogleFonts.inter(
    fontSize: 16 * scale,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
)

// Font Families Used:
'Oddlini'   // Display font (Bold: 700) - Headers, Titles
'Satoshi'   // Body font (Medium: 500, Bold: 700) - Labels, UI
'Helvetica' // Alt body (Regular: 400, Bold: 700) - Input fields
'Poppins'   // Alt sans-serif - Cards, secondary text
'Inter'     // Alt sans-serif (Medium: 500) - Captions
'Urbanist'  // UI font (Medium: 500, SemiBold: 600) - Navigation

// Font Sizes (scaled with responsive factor)
48 * scale // Large display (H1)
20 * scale // Page titles (H2)
16 * scale // Button text
15 * scale // Input field text
14 * scale // Body text
13 * scale // Small body/labels
12 * scale // Small UI text
11 * scale // Micro text
10 * scale // Label text
```

#### Text Style Helper (Create if needed)
```dart
// lib/app/core/theme/text_styles.dart
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle heading1(double scale) => GoogleFonts.inter(
    fontSize: 48 * scale,
    fontWeight: FontWeight.w700,
  );
  
  static TextStyle body(double scale) => GoogleFonts.inter(
    fontSize: 14 * scale,
    fontWeight: FontWeight.w400,
  );
}
```

### Spacing
Spacing uses a responsive scale based on screen width:

```dart
final screenWidth = MediaQuery.of(context).size.width;
final baseWidth = 393.0; // Design base width
final scale = screenWidth / baseWidth;

// Common spacing values
2 * scale   // Micro
6 * scale   // Tiny
8 * scale   // Extra small
10 * scale  // Small
12 * scale  // Small-medium
16 * scale  // Medium
20 * scale  // Medium-large
24 * scale  // Large
30 * scale  // Extra large
40 * scale  // Huge
```

## 2. Component Library

### Location
Components are stored in:
- `lib/app/widgets/` - Shared/reusable components
- `lib/app/modules/*/views/` - Module-specific view components

### Key Reusable Components

#### UserHeader (`lib/app/widgets/user_header.dart`) ✅ NEW
**Replaces `_buildUserHeader` across all views**

```dart
UserHeader(
  scale: scale,
  showSettings: true,
  onSettingsTap: () => Get.toNamed(AppRoutes.profile),
)
```

**Props:**
- `scale`: double (required) - Responsive scale factor
- `showSettings`: bool (default: true) - Show/hide settings button
- `onSettingsTap`: VoidCallback? - Settings button callback

**Used in:**
- Dashboard View
- Task List View
- Balance History View
- Withdraw View
- Add Bank View
- Add New Bank View

#### CustomButton (`lib/app/widgets/custom_button.dart`)
```dart
CustomButton(
  text: 'Button Text',
  onPressed: () {},
  isLoading: false,
  gradient: LinearGradient(...), // Optional gradient
)
```

#### CustomTextField (`lib/app/widgets/custom_text_field.dart`)
```dart
CustomTextField(
  controller: controller,
  label: 'Label',
  hintText: 'Hint',
  keyboardType: TextInputType.text,
)
```

#### Modal Components
- `SuccessModal` - Success feedback
- `ErrorModal` - Error feedback
- `BrainLoader` - Loading indicator

#### Navigation
- `CustomBottomNavBar` - Custom bottom navigation with gradient center button
- Uses `animated_bottom_navigation_bar` package

### Common Patterns to Extract

#### 1. Input Field Pattern
Many views repeat this pattern - should be extracted:
```dart
Widget _buildInputField({
  required String label,
  required String hintText,
  required TextEditingController controller,
  required double scale,
  TextInputType keyboardType = TextInputType.text,
})
```

#### 2. Card Pattern
Repeated card design across views:
```dart
Widget _buildCard({
  required Widget child,
  required double scale,
  bool isSelected = false,
})
```

#### 3. Section Title Pattern
```dart
Widget _buildSectionTitle(String title, double scale)
```

## 3. Frameworks & Libraries

### Core Framework
- **Flutter SDK**: 3.5.4+
- **Dart**: 3.5.4+

### Key Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management & Navigation
  get: ^4.6.6
  
  # Network & API
  dio: ^5.4.0
  
  # Local Storage
  shared_preferences: ^2.2.2
  
  # UI Components
  animated_bottom_navigation_bar: ^1.3.3
  flutter_svg: ^2.0.9 # For SVG support (if added)
  
  # Utilities
  intl: ^0.19.0 # Date formatting
```

### Build System
- **Build tool**: Flutter build system (uses Gradle for Android, Xcode for iOS)
- **State management**: GetX (reactive programming with `.obs`)
- **Navigation**: GetX routing

## 4. Asset Management

### Storage Location
```
assets/
├── app_icon/
│   └── google_logo.png
├── figma_exports/
│   ├── [hash].png  # Exported images
│   └── [hash].svg  # Exported SVGs (note: need flutter_svg to render)
└── fonts/
    ├── Oddlini/
    ├── Satoshi/
    ├── Helvetica/
    └── ...
```

### Asset Declaration (`pubspec.yaml`)
```yaml
flutter:
  assets:
    - assets/app_icon/
    - assets/figma_exports/
  
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
```

### Asset Usage
```dart
// Images
Image.asset(
  'assets/figma_exports/filename.png',
  width: 40 * scale,
  height: 40 * scale,
  errorBuilder: (context, error, stackTrace) => Icon(...),
)

// Note: SVG files need flutter_svg package or use Icon fallbacks
```

### Optimization
- Images stored at appropriate resolutions
- Error builders provide fallback icons
- Assets are lazy-loaded by Flutter

## 5. Icon System

### Primary Approach
Material Design Icons (built-in):
```dart
Icon(
  Icons.credit_card,
  size: 19 * scale,
  color: Colors.white,
)
```

### Common Icons
- `Icons.credit_card` - Card/payment icons
- `Icons.account_balance` - Bank icons
- `Icons.person_outline` - User/profile icons
- `Icons.phone_android` - Mobile/phone icons
- `Icons.arrow_back_ios` - Back navigation
- `Icons.home` - Home navigation
- `Icons.task` - Task icons

### Custom Icons
- Stored as PNG in `assets/figma_exports/`
- SVG files exported from Figma (need `flutter_svg` package to render)
- Fallback to Material icons if asset fails to load

## 6. Styling Approach

### Responsive Design
All UI uses responsive scaling:
```dart
final screenWidth = MediaQuery.of(context).size.width;
final baseWidth = 393.0;
final scale = screenWidth / baseWidth;

// Apply to all dimensions
width: 360 * scale
height: 45 * scale
fontSize: 16 * scale
padding: EdgeInsets.all(12 * scale)
borderRadius: BorderRadius.circular(11 * scale)
```

### Gradient Backgrounds
```dart
// Radial gradient (common for buttons)
decoration: BoxDecoration(
  gradient: const RadialGradient(
    center: Alignment(-0.126, -2.234),
    radius: 1.5,
    colors: [
      Color(0xEB58A3D8),
      Color(0xE78C98EC),
      Color(0xE3C08EFF),
    ],
    stops: [0.242, 0.545, 0.849],
  ),
)

// Linear gradient (common for backgrounds)
decoration: BoxDecoration(
  gradient: LinearGradient(
    colors: [Color(0xFFE786C2), Color(0xFF85428C)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
)
```

### Text Gradient
```dart
ShaderMask(
  shaderCallback: (bounds) => const LinearGradient(
    colors: [Color(0xFF5B099B), Color(0xFF5B099B)],
  ).createShader(bounds),
  child: Text(
    'Label',
    style: TextStyle(
      color: Colors.white, // Will be masked
    ),
  ),
)
```

### Border and Shadow
```dart
// Container with border
decoration: BoxDecoration(
  border: Border.all(color: Colors.white, width: 1),
  borderRadius: BorderRadius.circular(8 * scale),
)

// Shadow
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.08),
    blurRadius: 2,
    offset: const Offset(0, 1),
  ),
]
```

## 7. Project Structure

```
lib/
├── app/
│   ├── data/
│   │   ├── models/         # Data models
│   │   │   ├── user_model.dart
│   │   │   ├── task_model.dart
│   │   │   ├── bank_account_model.dart
│   │   │   └── mobile_banking_model.dart
│   │   └── services/       # API & Storage services
│   │       ├── api_service.dart
│   │       └── storage_service.dart
│   │
│   ├── modules/            # Feature modules (GetX pattern)
│   │   ├── [module_name]/
│   │   │   ├── bindings/   # Dependency injection
│   │   │   ├── controllers/ # Business logic (GetX controllers)
│   │   │   └── views/      # UI components
│   │   │
│   │   ├── auth/
│   │   ├── dashboard/
│   │   ├── task_list/
│   │   ├── balance/
│   │   └── withdraw/
│   │
│   ├── routes/             # Navigation
│   │   ├── app_pages.dart  # Route definitions
│   │   └── app_routes.dart # Route constants
│   │
│   └── widgets/            # Shared widgets
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       ├── success_modal.dart
│       └── error_modal.dart
│
└── main.dart               # App entry point
```

## 8. State Management Patterns

### GetX Reactive Programming
```dart
// Controller
class MyController extends GetxController {
  final counter = 0.obs; // Observable
  final items = <Item>[].obs; // Observable list
  
  void increment() => counter.value++;
}

// View
class MyView extends GetView<MyController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Text('${controller.counter}'));
  }
}
```

### Navigation
```dart
// Navigate to named route
Get.toNamed(AppRoutes.login);

// Navigate with argument
Get.toNamed(AppRoutes.taskDetails, arguments: taskId);

// Go back
Get.back();
```

### Local Storage
```dart
// Save to SharedPreferences
final prefs = await SharedPreferences.getInstance();
await prefs.setString('key', jsonEncode(data));

// Read from SharedPreferences
final data = prefs.getString('key');
if (data != null) {
  final decoded = jsonDecode(data);
}
```

## 9. Form Handling

### Text Controllers
```dart
final controller = TextEditingController();

TextField(
  controller: controller,
  keyboardType: TextInputType.text,
  style: TextStyle(...),
  decoration: InputDecoration(
    hintText: 'Hint',
    border: InputBorder.none, // Remove borders
    contentPadding: EdgeInsets.zero,
  ),
)

// Dispose in controller
@override
void onClose() {
  controller.dispose();
  super.onClose();
}
```

### Validation
```dart
if (controller.text.isEmpty) {
  ErrorModal.show(
    Get.context!,
    title: 'Error',
    message: 'Field is required',
  );
  return;
}
```

## 10. API Integration

### Service Pattern
```dart
class ApiService {
  static Future<List<Model>> getData() async {
    try {
      final response = await dio.get('/endpoint');
      return (response.data as List)
          .map((json) => Model.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
```

### Usage in Controller
```dart
final isLoading = false.obs;
final data = <Model>[].obs;

Future<void> loadData() async {
  try {
    isLoading.value = true;
    data.value = await ApiService.getData();
  } catch (e) {
    ErrorModal.show(Get.context!, ...);
  } finally {
    isLoading.value = false;
  }
}
```

## 11. Animation Guidelines

### Bottom Navigation Animation
```dart
AnimatedBottomNavigationBar(
  icons: [Icons.home, Icons.task, Icons.person],
  activeIndex: selectedIndex,
  onTap: (index) => controller.changePage(index),
  gapLocation: GapLocation.center,
  notchSmoothness: NotchSmoothness.verySmoothEdge,
)
```

### Collapsible Sections
```dart
AnimatedCrossFade(
  firstChild: content,
  secondChild: SizedBox.shrink(),
  crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
  duration: Duration(milliseconds: 300),
  sizeCurve: Curves.easeInOut,
)
```

## 12. Best Practices

### Responsive Design
- **Always** multiply dimensions by `scale` factor
- Base design width: `393.0` (iPhone-like dimensions)
- Use `MediaQuery` to get screen dimensions
- Test on multiple screen sizes

### Performance
- Use `const` constructors where possible
- Lazy load images with error builders
- Dispose controllers and text controllers
- Use `Obx()` for minimal rebuilds (not `GetX<>()` or `GetBuilder()`)

### Code Organization
- One feature per module
- Keep views focused on UI only
- Business logic in controllers
- Reusable widgets in `/widgets`
- Models in `/data/models`

### Error Handling
- Always use try-catch in async operations
- Show user-friendly error modals
- Provide fallback UI for failed assets
- Log errors for debugging

### Figma Integration
1. Export assets to `assets/figma_exports/`
2. For PNGs: use `Image.asset()` with error builder
3. For SVGs: install `flutter_svg` or use Icon fallbacks
4. Match exact colors, spacing, typography from Figma
5. Use responsive scaling for all dimensions
6. Test on multiple screen sizes
