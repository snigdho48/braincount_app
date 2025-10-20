# Theme Migration Guide

## Overview
The app now has a complete light/dark theme system. All pages need to use `AppColors` instead of hardcoded colors to support theme switching.

## How to Make a Page Theme-Aware

### 1. Import AppColors
```dart
import '../../../core/theme/app_colors.dart';
```

### 2. Wrap the Body in Obx
Wrap the main container/body in `Obx()` to make it reactive to theme changes:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.background,
    body: Obx(() => Container(
      decoration: BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: // Your content here
    )),
  );
}
```

### 3. Replace Hardcoded Colors with AppColors

#### Background Colors
- `Color(0xFF232323)` → `AppColors.background`
- `Color(0xFF393838)` → `AppColors.cardBackground`
- `Color(0xFF212121)` → `AppColors.tertiaryBackground`

#### Text Colors
- `Colors.white` → `AppColors.primaryText`
- `Color(0xFF888787)` → `AppColors.secondaryText`
- `Color(0xFF4A4949)` → `AppColors.disabledText`

#### Border & Divider Colors
- `Color(0xFF4A4949)` → `AppColors.border`
- `Color(0xFF232323)` → `AppColors.divider`

#### Primary Colors (Don't Change)
- `Color(0xFF85428C)` → `AppColors.primary`
- Success, error, warning colors → Use `AppColors.success`, `AppColors.error`, `AppColors.warning`

#### Gradients
- Background gradient → `AppColors.backgroundGradient`
- Primary gradient → `AppColors.primaryGradient`

### 4. Available AppColors Properties

```dart
// Backgrounds
AppColors.background
AppColors.cardBackground
AppColors.tertiaryBackground

// Text
AppColors.primaryText
AppColors.secondaryText
AppColors.disabledText

// Borders
AppColors.border
AppColors.divider

// Primary Colors
AppColors.primary
AppColors.primaryLight
AppColors.primaryDark

// Status
AppColors.success
AppColors.error
AppColors.warning
AppColors.info

// Gradients
AppColors.backgroundGradient
AppColors.primaryGradient
AppColors.profileCardGradient

// Others
AppColors.shadowColor
AppColors.overlayColor
AppColors.iconColor
AppColors.iconColorSecondary
```

## Example: Before and After

### Before (Hardcoded)
```dart
Container(
  decoration: BoxDecoration(
    color: const Color(0xFF393838),
  ),
  child: Text(
    'Hello',
    style: TextStyle(color: Colors.white),
  ),
)
```

### After (Theme-Aware)
```dart
Container(
  decoration: BoxDecoration(
    color: AppColors.cardBackground,
  ),
  child: Text(
    'Hello',
    style: TextStyle(color: AppColors.primaryText),
  ),
)
```

## Pages That Need Migration
- ✅ Profile View (DONE)
- ⏳ Dashboard View
- ⏳ Task List View
- ⏳ Task Details View
- ⏳ Balance History View
- ⏳ Withdraw Views
- ⏳ Login/Register Views
- ⏳ All other views

## Testing
After updating a page:
1. Run the app
2. Go to Profile > Preferences > Theme
3. Switch between Dark and Light modes
4. Verify all colors change appropriately
5. Check that text is readable in both themes
6. Ensure borders and dividers are visible

## Notes
- Always wrap reactive content in `Obx()`
- Use `AppColors` getters, not constants (they're dynamic)
- Test on both light and dark themes
- Keep primary/accent colors consistent across themes

