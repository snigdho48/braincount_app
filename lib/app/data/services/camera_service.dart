import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  static final ImagePicker _picker = ImagePicker();

  // Request camera permission
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  // Take photo from back camera using camera package
  static Future<String?> takePhotoFromBackCamera() async {
    try {
      final hasPermission = await requestCameraPermission();
      if (!hasPermission) {
        return null;
      }

      // Use ImagePicker with back camera preference
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 85,
      );

      if (photo == null) return null;

      // Convert to base64
      final bytes = await File(photo.path).readAsBytes();
      final base64String = base64Encode(bytes);
      
      return base64String;
    } catch (e) {
      return null;
    }
  }

  // Take photo from gallery (alternative)
  static Future<String?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) return null;

      final bytes = await File(image.path).readAsBytes();
      final base64String = base64Encode(bytes);
      
      return base64String;
    } catch (e) {
      return null;
    }
  }

  // Get file size from base64
  static int getBase64FileSize(String base64String) {
    final bytes = base64Decode(base64String);
    return bytes.length;
  }

  // Format file size for display
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }
}

