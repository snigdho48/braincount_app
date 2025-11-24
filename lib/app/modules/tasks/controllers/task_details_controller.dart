import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/api_service.dart';
import '../../../routes/app_routes.dart';

class TaskDetailsController extends GetxController {
  final task = Rxn<TaskModel>();
  final isLoading = false.obs;
  final isTaskAccepted = false.obs; // Track if pending task is accepted
  final submission = Rxn<Map<String, dynamic>>(); // Store submission data if available

  @override
  void onInit() {
    super.onInit();
    final taskData = Get.arguments?['task'];
    if (taskData != null) {
      task.value = taskData as TaskModel;
      // Load full task details from API
      loadTaskDetails();
    }
  }

  Future<void> loadTaskDetails() async {
    if (task.value == null) return;
    
    try {
      isLoading.value = true;
      final taskDetails = await ApiService.getTaskDetails(task.value!.id);
      task.value = taskDetails;
      
      // Check if task has submission data (from backend response)
      // The backend returns submission data in the task details response
    } catch (e) {
      // If API fails, keep the task data from arguments
      // Show error but don't block the UI
      String errorMsg = 'Failed to load task details';
      if (e.toString().isNotEmpty && !e.toString().contains('Exception: ')) {
        errorMsg = e.toString().replaceFirst('Exception: ', '');
      }
      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> acceptTask() async {
    if (task.value == null) return;
    
    try {
      final response = await ApiService.acceptTask(task.value!.id);
      
      if (response['success'] == true) {
        // Reload task details to get updated status
        await loadTaskDetails();
        
        // Mark as accepted locally
        isTaskAccepted.value = true;
        
        Get.snackbar(
          'Task Accepted',
          response['message'] ?? 'You can now submit this task',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        
        // Optionally go back after a short delay to show the updated task in the list
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back();
        });
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to accept task',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      String errorMsg = 'Failed to accept task';
      if (e.toString().isNotEmpty && !e.toString().contains('Exception: ')) {
        errorMsg = e.toString().replaceFirst('Exception: ', '');
      }
      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    }
  }

  Future<void> rejectTask() async {
    if (task.value == null) return;
    
    try {
      final response = await ApiService.rejectTask(task.value!.id);
      
      if (response['success'] == true) {
        Get.back(); // Go back to previous screen immediately
        
        Get.snackbar(
          'Task Rejected',
          response['message'] ?? 'You have rejected "${task.value?.title}"',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.secondary,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to reject task',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      String errorMsg = 'Failed to reject task';
      if (e.toString().isNotEmpty && !e.toString().contains('Exception: ')) {
        errorMsg = e.toString().replaceFirst('Exception: ', '');
      }
      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    }
  }

  void goToSubmission() {
    Get.toNamed(
      AppRoutes.taskSubmission,
      arguments: {'task': task.value},
    );
  }
}


