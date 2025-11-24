import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/models/user_model.dart';
import '../../../widgets/error_modal.dart';
import '../../../routes/app_routes.dart';
import '../../../core/config/app_config.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final obscurePassword = true.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      
      final response = await ApiService.login(
        emailController.text.trim(),
        passwordController.text,
      );

      if (response['success'] == true) {
        // Save token and user data
        await StorageService.saveToken(response['token']);
        await StorageService.saveUser(UserModel.fromJson(response['user']));
        await StorageService.setLoggedIn(true);

        // Update OneRequest headers with auth token
        AppConfig.updateAuthHeaders(response['token']);

        // Navigate to home
        Get.offAllNamed(AppRoutes.home);
      } else {
        ErrorModal.show(
          Get.context!,
          title: 'Login Failed',
          message: response['message'] ?? 'Invalid credentials',
        );
      }
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'An error occurred. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      isGoogleLoading.value = true;
      
      // Sign out first to force account picker (ignore errors if already signed out)
      try {
        await _googleSignIn.signOut();
      } catch (e) {
        // Ignore if already signed out
      }
      
      // Sign in with Google (will show account picker)
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // User cancelled the sign-in
        isGoogleLoading.value = false;
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      // Send ID token to backend for verification
      final response = await ApiService.googleSignIn(googleAuth.idToken!);

      if (response['success'] == true) {
        await StorageService.saveToken(response['token']);
        await StorageService.saveUser(UserModel.fromJson(response['user']));
        await StorageService.setLoggedIn(true);

        // Update OneRequest headers with auth token
        AppConfig.updateAuthHeaders(response['token']);

        Get.offAllNamed(AppRoutes.home);
      } else {
        ErrorModal.show(
          Get.context!,
          title: 'Login Failed',
          message: response['message'] ?? 'Google sign in failed',
        );
      }
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'Google sign in failed. Please try again.',
      );
    } finally {
      isGoogleLoading.value = false;
    }
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.register);
  }

  void goToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }
}


