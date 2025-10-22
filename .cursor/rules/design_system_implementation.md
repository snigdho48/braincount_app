# BrainCount Design System - Quick Implementation Guide

## Color System
```dart
// Always use theme-aware colors
AppColors.background          // Auto-switches with theme
AppColors.cardBackground
AppColors.primaryText
AppColors.secondaryText
AppColors.border

// Brand colors (consistent)
AppColors.primary             // #85428C
AppColors.success             // #4CAF50
AppColors.error               // #F44336
AppColors.info                // #2196F3

// Gradients
AppColors.primaryGradient
AppColors.backgroundGradient
```

## Typography
```dart
// Font Families
'BebasNeue'    // Headers (weight: 400)
'Poppins'      // Body (weight: 400, 500, 600, 700)
'Inter'        // Captions (weight: 400, 500, 700)
'Satoshi'      // UI (weight: 400, 500, 700)

// Example
Text(
  'Title',
  style: TextStyle(
    fontFamily: 'Poppins',
    fontSize: Responsive.fontSize(16),
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  ),
)
```

## Responsive Sizing
```dart
// Always use Responsive class
Responsive.sp(16)              // Scaled pixels
Responsive.fontSize(14)        // Scaled font size

// Named spacing
Responsive.xs                  // 4px
Responsive.sm                  // 8px
Responsive.md                  // 16px
Responsive.lg                  // 24px
Responsive.xl                  // 32px

// Vertical spacing
Responsive.smVertical          // 8px
Responsive.mdVertical          // 12px
Responsive.lgVertical          // 20px

// Border radius
Responsive.radiusSm            // 8px
Responsive.radiusMd            // 12px
Responsive.radiusLg            // 16px

// Component sizes
Responsive.iconSize            // 24px
Responsive.buttonHeight        // 50px
```

## Container Pattern
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
        color: Colors.black.withOpacity(0.05),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
)
```

## GetX Patterns
```dart
// Controller
class MyController extends GetxController {
  final data = <Model>[].obs;  // Observable
  final isLoading = false.obs;
  
  void loadData() async {
    isLoading.value = true;
    data.value = await ApiService.getData();
    isLoading.value = false;
  }
}

// View
class MyView extends GetView<MyController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => 
      controller.isLoading.value
        ? BrainLoader()
        : ListView.builder(...)
    );
  }
}
```

## Modal/Bottom Sheet
```dart
Get.bottomSheet(
  Container(
    height: Get.height * 0.85,
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(Responsive.radiusLg),
      ),
    ),
    child: YourContent(),
  ),
  isScrollControlled: true,
  isDismissible: true,
);
```

## Filter Chips Pattern
```dart
// Active filter chips (like in Figma)
if (chips.isNotEmpty)
  Container(
    padding: EdgeInsets.symmetric(
      horizontal: Responsive.md,
      vertical: Responsive.smVertical,
    ),
    child: Wrap(
      spacing: Responsive.sp(12),
      runSpacing: Responsive.sp(12),
      children: chips.map((chip) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.sp(12),
          vertical: Responsive.sp(6),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(Responsive.sp(15)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              chip['label']!,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: Responsive.fontSize(14),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(width: Responsive.sp(10)),
            GestureDetector(
              onTap: () => onRemove(chip),
              child: Icon(
                Icons.close,
                size: Responsive.sp(12),
                color: Colors.white,
              ),
            ),
          ],
        ),
      )).toList(),
    ),
  )
```

## Reusable Components
```dart
// Button
CustomButton(
  text: 'Submit',
  onPressed: () {},
  isLoading: false,
)

// Text Field
CustomTextField(
  controller: controller,
  hintText: 'Enter text',
  labelText: 'Label',
)

// Loader
BrainLoader(message: 'Loading...')

// Modals
Get.dialog(SuccessModal(
  title: 'Success',
  message: 'Operation completed',
));

Get.dialog(ErrorModal(
  title: 'Error',
  message: 'Something went wrong',
));
```

## Asset Usage
```dart
// Images
Image.asset(
  'assets/figma_exports/image.png',
  width: Responsive.sp(100),
  errorBuilder: (_, __, ___) => Icon(Icons.error),
)

// SVG
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.asset(
  'assets/figma_exports/icon.svg',
  width: Responsive.iconSize,
  color: AppColors.primaryText,
)

// Cached network image
CachedNetworkImage(
  imageUrl: url,
  placeholder: (_, __) => BrainLoader(),
  errorWidget: (_, __, ___) => Icon(Icons.error),
)
```

## Best Practices
1. ✅ Always use `Responsive` for sizing
2. ✅ Always use `AppColors` for colors
3. ✅ Use `Obx()` for reactive UI
4. ✅ Handle loading/error states
5. ✅ Provide image fallbacks
6. ✅ Use existing components first
7. ✅ Follow GetX patterns
8. ✅ Test on different screen sizes

## Common Mistakes to Avoid
1. ❌ Hardcoded pixel values → Use `Responsive.sp()`
2. ❌ Hardcoded colors → Use `AppColors`
3. ❌ Direct `Color()` → Use theme-aware `AppColors`
4. ❌ Forgetting `.value` on observables
5. ❌ Not wrapping with `Obx()` for reactive UI
6. ❌ Missing error/loading states
7. ❌ No image fallbacks

