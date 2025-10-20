# Balance History - Collapsible Sections Implementation

## Overview
Added collapsible/expandable functionality to the "History" and "Withdraw History" sections with smooth animations.

## Features Added

### 1. Collapsible Sections
- ✅ **History Section**: Stats cards (Pending/Rejected/Completed/Pending Amount)
- ✅ **Withdraw History Section**: Transaction list
- ✅ **Smooth Animations**: 300ms ease-in-out transitions
- ✅ **Rotating Arrow Icon**: Visual feedback when expanding/collapsing
- ✅ **Tap Anywhere**: Entire header is tappable

### 2. Controller Changes

**File**: `lib/app/modules/balance/controllers/balance_history_controller.dart`

Added reactive state for collapsible sections:

```dart
// Collapsible sections
final isHistoryExpanded = true.obs;
final isWithdrawHistoryExpanded = true.obs;

void toggleHistory() {
  isHistoryExpanded.value = !isHistoryExpanded.value;
}

void toggleWithdrawHistory() {
  isWithdrawHistoryExpanded.value = !isWithdrawHistoryExpanded.value;
}
```

**Default State**: Both sections start expanded (`true`)

### 3. View Changes

**File**: `lib/app/modules/balance/views/balance_history_view.dart`

#### New Widget: `_buildCollapsibleSection()`

```dart
Widget _buildCollapsibleSection({
  required String title,
  required RxBool isExpanded,
  required VoidCallback onToggle,
  required double scale,
  required Widget child,
}) {
  return Obx(() => Column(
    children: [
      // Header with title and expand/collapse icon
      GestureDetector(
        onTap: onToggle,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, ...),
              SizedBox(width: 8 * scale),
              AnimatedRotation(
                turns: isExpanded.value ? 0.5 : 0, // Rotates 180° when expanded
                duration: const Duration(milliseconds: 300),
                child: Icon(Icons.keyboard_arrow_down, ...),
              ),
            ],
          ),
        ),
      ),
      
      SizedBox(height: 7 * scale),
      
      // Collapsible content with animation
      AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: isExpanded.value
            ? child
            : const SizedBox.shrink(), // Hidden when collapsed
      ),
    ],
  ));
}
```

#### Usage in ScrollView

```dart
Expanded(
  child: SingleChildScrollView(
    child: Column(
      children: [
        // History Section (Collapsible)
        _buildCollapsibleSection(
          title: 'History:',
          isExpanded: controller.isHistoryExpanded,
          onToggle: controller.toggleHistory,
          scale: scale,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            child: _buildStatsSection(scale),
          ),
        ),

        SizedBox(height: 30 * scale),

        // Withdraw History Section (Collapsible)
        _buildCollapsibleSection(
          title: 'Withdraw History:',
          isExpanded: controller.isWithdrawHistoryExpanded,
          onToggle: controller.toggleWithdrawHistory,
          scale: scale,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            child: _buildWithdrawHistoryList(scale),
          ),
        ),

        SizedBox(height: 100 * scale),
      ],
    ),
  ),
)
```

## Animations

### 1. Arrow Icon Rotation
```dart
AnimatedRotation(
  turns: isExpanded.value ? 0.5 : 0,
  duration: const Duration(milliseconds: 300),
  child: Icon(Icons.keyboard_arrow_down),
)
```
- **Collapsed**: Arrow points down (0°)
- **Expanded**: Arrow points up (180°)
- **Animation**: Smooth 300ms rotation

### 2. Content Expand/Collapse
```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  child: isExpanded.value ? child : const SizedBox.shrink(),
)
```
- **Collapsed**: `SizedBox.shrink()` (height: 0)
- **Expanded**: Full content visible
- **Animation**: Smooth 300ms size transition with ease-in-out curve

## User Interaction

### Tap to Toggle
```dart
GestureDetector(
  onTap: onToggle, // Calls controller.toggleHistory() or toggleWithdrawHistory()
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
    child: Row([Title, Icon]),
  ),
)
```

**Tap Area**: Entire header row (title + icon + padding)

## Layout Structure

```
SingleChildScrollView
└── Column
    ├── Collapsible Section 1 (History)
    │   ├── Header (tappable)
    │   │   ├── "History:" Text
    │   │   └── Arrow Icon (animated rotation)
    │   └── Content (animated size)
    │       └── Stats Cards (4 cards)
    │           ├── Pending Task
    │           ├── Rejected Task
    │           ├── Task Completed
    │           └── Pending Amount
    ├── Spacing (30px)
    ├── Collapsible Section 2 (Withdraw History)
    │   ├── Header (tappable)
    │   │   ├── "Withdraw History:" Text
    │   │   └── Arrow Icon (animated rotation)
    │   └── Content (animated size)
    │       └── Transaction List (3 cards)
    │           ├── Withdraw 01
    │           ├── Withdraw 02
    │           └── Withdraw 03
    └── Bottom Spacing (100px)
```

## Responsive Design

All measurements scale with screen size:

```dart
padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale)
fontSize: 13 * scale
iconSize: 20 * scale
spacing: 8 * scale
```

## State Management

### GetX Observables
- `controller.isHistoryExpanded` - RxBool (reactive)
- `controller.isWithdrawHistoryExpanded` - RxBool (reactive)

### Reactivity
- `Obx(() => ...)` - Automatically rebuilds when state changes
- Smooth animations on every state change
- No manual setState() needed

## Benefits

### User Experience
✅ **Cleaner Interface**: Less visual clutter
✅ **Better Navigation**: Focus on important content
✅ **Save Space**: Collapse sections you don't need
✅ **Smooth Animations**: Polished, professional feel
✅ **Clear Visual Feedback**: Rotating arrow shows state

### Developer Experience
✅ **Reusable Widget**: `_buildCollapsibleSection()` can be used anywhere
✅ **Easy to Maintain**: Clean separation of concerns
✅ **Flexible**: Can easily add more collapsible sections
✅ **Reactive**: GetX handles state automatically

## Testing Checklist

- [x] Both sections expand/collapse independently
- [x] Arrow icon rotates smoothly
- [x] Content animates smoothly
- [x] No layout jumps or glitches
- [x] Tappable area is large enough
- [x] Scrolling works with collapsed/expanded states
- [x] Default state is expanded
- [x] Responsive on all screen sizes
- [x] No lint errors

## Future Enhancements

Possible additions:
1. Persist collapsed state (SharedPreferences)
2. Add collapse/expand all button
3. Add slide animation in addition to size animation
4. Custom icons for different sections
5. Haptic feedback on tap
6. Section badges (e.g., "4 items")

## Summary

Both "History" and "Withdraw History" sections are now fully collapsible with:
- 🎯 Smooth 300ms animations
- 🔄 Rotating arrow icons
- 👆 Large tap areas
- 📱 Responsive design
- ⚡ GetX reactive state
- ✨ Professional UX

Perfect for keeping the interface clean and organized! 🚀

