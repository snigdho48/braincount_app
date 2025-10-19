# Figma MCP Integration Guide for BrainCount

## Overview
This guide explains how to export images and designs from Figma directly into the BrainCount Flutter project using the Figma Desktop MCP integration.

---

## Setup Complete ✅

1. **Asset Directory Created**: `assets/figma_exports/`
2. **Pubspec Updated**: Added `assets/figma_exports/` to asset declarations
3. **Design System Rules**: Created comprehensive design system documentation at `.cursor/rules/braincount_design_system.md`

---

## How to Export Images from Figma

### Step 1: Select a Node in Figma Desktop
Open your Figma design file and **select the element** (frame, component, image, etc.) you want to export.

### Step 2: Use Figma MCP Commands

#### Option A: Get Design Context (with automatic image export)
```bash
/Figma Desktop/get_design_context
```

This will:
- Generate Flutter code for the selected element
- **Automatically export any images/assets** to: `d:\braincount_app\braincount\assets\figma_exports\`
- Provide code using existing BrainCount components and styling

**Parameters:**
- `dirForAssetWrites`: `d:\braincount_app\braincount\assets\figma_exports`
- `clientLanguages`: `dart`
- `clientFrameworks`: `flutter`

#### Option B: Get Screenshot
```bash
/Figma Desktop/get_screenshot
```

This will export a PNG screenshot of the selected node.

#### Option C: Get Metadata (structure only, no images)
```bash
/Figma Desktop/get_metadata
```

This provides XML structure without exporting images.

---

## What Happens When You Export

### Automatic Image Export
When you use `get_design_context`, the Figma MCP will:

1. **Detect images** in your selected Figma node
2. **Export them** to `assets/figma_exports/`
3. **Generate Flutter code** that references these images correctly
4. **Use responsive sizing** from the `Responsive` utility class
5. **Apply BrainCount colors** from `AppColors`

### Example Generated Code
```dart
Container(
  width: Responsive.sp(200),
  height: Responsive.sp(300),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(Responsive.radiusLg),
    image: DecorationImage(
      image: AssetImage('assets/figma_exports/user_avatar.png'),
      fit: BoxFit.cover,
    ),
  ),
)
```

---

## Workflow for Converting Figma Designs

### 1. Select Your Design Element
In Figma Desktop, click on the frame, component, or image you want to convert.

### 2. Run the Command
Use the `/Figma Desktop/get_design_context` command in Cursor.

### 3. Review Generated Assets
Check `assets/figma_exports/` for exported images:
```
assets/
└── figma_exports/
    ├── user_avatar.png
    ├── task_icon.png
    ├── background_pattern.png
    └── [other exported images]
```

### 4. Review Generated Code
The MCP will provide Flutter code that:
- Uses `Responsive` utility for all sizing
- References exported images correctly
- Applies `AppColors` styling
- Follows GetX patterns
- Reuses existing custom widgets

### 5. Integrate into Your Project
Copy the generated code into the appropriate view file in your module:
```
lib/app/modules/your_module/views/your_view.dart
```

---

## Available Figma MCP Commands

### 1. `get_design_context`
**Best for**: Full component conversion with images
```bash
/Figma Desktop/get_design_context
```
- ✅ Exports images
- ✅ Generates complete Flutter code
- ✅ Uses project conventions

### 2. `get_screenshot`
**Best for**: Getting visual reference
```bash
/Figma Desktop/get_screenshot
```
- ✅ PNG export of selected element
- ❌ No code generation

### 3. `get_metadata`
**Best for**: Understanding structure
```bash
/Figma Desktop/get_metadata
```
- ✅ XML structure with node IDs
- ❌ No images
- ❌ No code generation

### 4. `get_variable_defs`
**Best for**: Extracting design tokens
```bash
/Figma Desktop/get_variable_defs
```
- ✅ Color variables
- ✅ Typography tokens
- ✅ Spacing values

### 5. `get_code_connect_map`
**Best for**: Finding linked components
```bash
/Figma Desktop/get_code_connect_map
```
- ✅ Component mappings
- ✅ Source file locations

### 6. `create_design_system_rules`
**Best for**: Initial setup (already completed)
```bash
/Figma Desktop/create_design_system_rules
```
- ✅ Generates design system documentation

---

## Tips for Best Results

### ✅ DO:
1. **Select specific elements** before running commands
2. **Use get_design_context** for components with images
3. **Review exported images** in `assets/figma_exports/`
4. **Test responsive sizing** on different screen sizes
5. **Reuse existing widgets** when possible
6. **Keep Figma selection focused** (select single components, not entire pages)

### ❌ DON'T:
1. Run commands without selecting anything (will return "Nothing is selected")
2. Select too large/complex frames (break them down first)
3. Forget to check `pubspec.yaml` includes `assets/figma_exports/`
4. Use hardcoded sizes in generated code (always use `Responsive`)

---

## Example Workflow

### Converting a Profile Avatar Image

1. **In Figma**: Select the user avatar image
2. **Run**: `/Figma Desktop/get_design_context`
3. **Result**: Image exported to `assets/figma_exports/profile_avatar.png`
4. **Generated code**:
```dart
CircleAvatar(
  radius: Responsive.sp(40),
  backgroundImage: AssetImage('assets/figma_exports/profile_avatar.png'),
)
```
5. **Use in profile view**:
```dart
// lib/app/modules/profile/views/profile_view.dart
Obx(() => CircleAvatar(
  radius: Responsive.sp(40),
  backgroundImage: controller.user.value?.avatar != null
    ? NetworkImage(controller.user.value!.avatar!)
    : const AssetImage('assets/figma_exports/profile_avatar.png') as ImageProvider,
))
```

---

## Troubleshooting

### "Nothing is selected"
**Solution**: Select an element in Figma Desktop first

### Images not exporting
**Solution**: Ensure you're using `get_design_context` (not `get_metadata`)

### Assets not found at runtime
**Solution**: 
1. Check `pubspec.yaml` includes `assets/figma_exports/`
2. Run `flutter pub get`
3. Restart your app

### Images look pixelated
**Solution**: Export @2x or @3x versions from Figma for better resolution

---

## Current Project Status

✅ **Completed:**
- Asset directory created
- Pubspec.yaml updated
- Design system rules documented
- Responsive utility configured
- Custom components available

📋 **Ready for:**
- Exporting Figma images
- Converting Figma designs to Flutter code
- Integrating new screens and components

---

## Next Steps

1. **Open Figma Desktop** with your BrainCount design file
2. **Select an element** you want to convert
3. **Run** `/Figma Desktop/get_design_context` in Cursor
4. **Review** exported images in `assets/figma_exports/`
5. **Integrate** generated code into your views

The system is now fully configured to accept Figma exports! 🎉

