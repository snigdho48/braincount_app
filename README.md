# BrainCount - Task-Based Earnings App

A full-featured Flutter application built with GetX architecture for managing billboard inspection tasks and earnings.

## Features

### Authentication
- ✅ Login with email/password
- ✅ Google Sign-In integration
- ✅ User registration
- ✅ OTP verification
- ✅ Forgot password & reset password

### Dashboard
- ✅ 3D task visualization
- ✅ Summary statistics (completed, pending, rejected tasks)
- ✅ Current balance display
- ✅ Recent tasks list
- ✅ Quick access to withdraw

### Task Management
- ✅ Task list with filters (All, Pending, Submitted)
- ✅ Task details view
- ✅ Task submission with camera integration
- ✅ **Back camera capture** for billboard photos
- ✅ **Base64 image encoding** for API submission
- ✅ Multiple image upload (up to 4 images)
- ✅ Billboard condition checklist
- ✅ Upload progress tracking

### Profile & Balance
- ✅ User profile page
- ✅ Balance history with transaction details
- ✅ Withdrawal system (Bank, bKash, Nagad, Rocket)

### UI/UX Features
- ✅ Beautiful purple gradient theme
- ✅ **Animated brain loader** (thematically relevant)
- ✅ Smooth animations with flutter_animate
- ✅ Custom widgets (buttons, text fields, cards)
- ✅ Error and success modals
- ✅ Bottom navigation
- ✅ Pull-to-refresh functionality

## Tech Stack

- **Framework**: Flutter
- **State Management**: GetX
- **Architecture**: GetX Pattern (MVC)
- **Camera**: camera & image_picker packages
- **Image Handling**: Base64 encoding
- **Local Storage**: shared_preferences
- **HTTP**: http package
- **UI Components**: 
  - Google Fonts
  - Flutter Animate
  - Pinput (OTP input)
  - Dotted Border
  - Shimmer
  - Cached Network Image

## Project Structure

```
lib/
├── app/
│   ├── core/
│   │   └── theme/
│   │       ├── app_colors.dart
│   │       └── app_theme.dart
│   ├── data/
│   │   ├── models/
│   │   │   ├── user_model.dart
│   │   │   ├── task_model.dart
│   │   │   ├── task_submission_model.dart
│   │   │   ├── balance_model.dart
│   │   │   └── dashboard_stats_model.dart
│   │   └── services/
│   │       ├── api_service.dart
│   │       ├── storage_service.dart
│   │       └── camera_service.dart
│   ├── modules/
│   │   ├── auth/
│   │   │   ├── bindings/
│   │   │   ├── controllers/
│   │   │   └── views/
│   │   ├── dashboard/
│   │   ├── tasks/
│   │   ├── task_submission/
│   │   ├── profile/
│   │   ├── balance/
│   │   └── withdraw/
│   ├── routes/
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   └── widgets/
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       ├── brain_loader.dart
│       ├── task_card.dart
│       ├── stats_card.dart
│       ├── success_modal.dart
│       └── error_modal.dart
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (3.6.2 or higher)
- Dart SDK (^3.6.2)
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository** (or navigate to the project directory)

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
   
   Or using yarn (as per project preference):
   ```bash
   yarn install
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

### Camera Permissions

The app automatically requests camera permissions when needed. Permissions are configured in:

**Android**: `android/app/src/main/AndroidManifest.xml`
- CAMERA
- READ_EXTERNAL_STORAGE
- WRITE_EXTERNAL_STORAGE
- INTERNET

**iOS**: Add to `ios/Runner/Info.plist`:
```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to capture billboard photos</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need photo library access to select images</string>
```

## Key Features Implementation

### Task Submission with Back Camera

The task submission page includes:
- **Back camera capture** using `camera` and `image_picker` packages
- **Base64 encoding** of images for API submission
- Multiple image upload slots (up to 4)
- Real-time upload progress
- Billboard condition checklist
- Optional notes field

```dart
// Camera Service automatically uses back camera
final base64Image = await CameraService.takePhotoFromBackCamera();
```

### Image Handling as Base64

All images are handled as base64-encoded strings:
```dart
class SubmissionImage {
  final String base64Data;  // Image stored as base64
  final String fileName;
  final int fileSize;
  final String status;
}
```

### Animated Loader

Custom brain-themed loader with animations:
```dart
BrainLoader(
  message: 'Loading tasks...',
  size: 100,
)
```

## API Integration

The app uses mock API responses for demo purposes. To integrate with a real backend:

1. Update `baseUrl` in `lib/app/data/services/api_service.dart`
2. Uncomment real API calls and remove mock responses
3. Configure your backend to accept base64 image data

Example API request format:
```json
{
  "task_id": "01",
  "conditions": ["Color Faded", "Medium Damaged"],
  "notes": "Billboard needs repair",
  "images": [
    {
      "base64_data": "data:image/jpeg;base64,...",
      "file_name": "Picture1",
      "file_size": 102400,
      "status": "completed"
    }
  ],
  "submitted_at": "2025-10-09T10:30:00Z"
}
```

## Design References

Design mockups are located in `assets/designs/`:
- Login screen
- Registration
- OTP verification
- Dashboard
- Task list
- Task submission
- Profile
- Balance history
- Withdraw screens

## Default Credentials (Mock)

For testing purposes:
- **Email**: Any valid email
- **Password**: Any password (min 6 characters)

The app uses mock authentication and will accept any credentials.

## Customization

### Colors

Edit `lib/app/core/theme/app_colors.dart` to customize the color scheme.

### API Endpoints

Edit `lib/app/data/services/api_service.dart` to configure your backend URLs.

### Business Logic

Controllers are located in each module's `controllers/` directory.

## Running Tests

```bash
flutter test
```

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Troubleshooting

### Camera not working
- Ensure permissions are granted in device settings
- Check AndroidManifest.xml has camera permissions
- For iOS, check Info.plist has camera usage descriptions

### Images not uploading
- Check network connectivity
- Verify API endpoint is accessible
- Check image size (should be < 120KB as per design spec)

### Build errors
```bash
flutter clean
flutter pub get
flutter run
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is created for BrainCount application.

## Support

For issues and questions, please create an issue in the repository.

---

**Built with ❤️ using Flutter & GetX**
