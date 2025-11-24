import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/task_submission_model.dart';
import '../../../data/services/camera_service.dart';
import '../../../data/services/api_service.dart';
import '../../../widgets/error_modal.dart';
import '../../../widgets/success_modal.dart';

class TaskSubmissionController extends GetxController {
  final task = Rxn<TaskModel>();
  final notesController = TextEditingController();
  final submittedImages = <int, SubmissionImage>{}.obs;
  final isUploading = <int>[].obs;
  final isSubmitting = false.obs;

  final maxImages = 4;

  // Status fields (4 different parts)
  final colourStatus = Rxn<String>();      // good, degraded, critical
  final structureStatus = Rxn<String>();  // good, degraded, critical
  final mediumStatus = Rxn<String>();     // good, degraded, critical
  final communicationStatus = Rxn<String>(); // good, critical
  
  // Status options
  final colourStatusOptions = ['good', 'degraded', 'critical'];
  final structureStatusOptions = ['good', 'degraded', 'critical'];
  final mediumStatusOptions = ['good', 'degraded', 'critical'];
  final communicationStatusOptions = ['good', 'critical'];

  @override
  void onInit() {
    super.onInit();
    final taskData = Get.arguments?['task'];
    if (taskData != null) {
      task.value = taskData as TaskModel;
    }
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }


  Future<void> captureImage(int index) async {
    try {
      isUploading.add(index);

      final base64Image = await CameraService.takePhotoFromBackCamera();
      
      if (base64Image != null) {
        // Simulate upload delay
        await Future.delayed(const Duration(seconds: 2));

        final fileSize = CameraService.getBase64FileSize(base64Image);
        final submissionImage = SubmissionImage(
          base64Data: base64Image,
          fileName: 'Picture${index + 1}',
          fileSize: fileSize,
          status: 'completed',
        );

        submittedImages[index] = submissionImage;
      }
      
      isUploading.remove(index);
    } catch (e) {
      isUploading.remove(index);
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'Failed to capture image. Please try again.',
      );
    }
  }

  Future<void> submitTask() async {
    // Validate that all status fields are selected (required)
    if (colourStatus.value == null) {
      ErrorModal.show(
        Get.context!,
        title: 'Validation Error',
        message: 'Please select Colour Status',
      );
      return;
    }
    if (structureStatus.value == null) {
      ErrorModal.show(
        Get.context!,
        title: 'Validation Error',
        message: 'Please select Structure Status',
      );
      return;
    }
    if (mediumStatus.value == null) {
      ErrorModal.show(
        Get.context!,
        title: 'Validation Error',
        message: 'Please select Medium Status',
      );
      return;
    }
    if (communicationStatus.value == null) {
      ErrorModal.show(
        Get.context!,
        title: 'Validation Error',
        message: 'Please select Communication Status',
      );
      return;
    }

    if (submittedImages.isEmpty) {
      ErrorModal.show(
        Get.context!,
        title: 'Validation Error',
        message: 'Please upload at least one image',
      );
      return;
    }

    try {
      isSubmitting.value = true;

      final submission = TaskSubmissionModel(
        taskId: task.value!.id,
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        images: submittedImages.values.toList(),
        submittedAt: DateTime.now(),
        colourStatus: colourStatus.value,
        structureStatus: structureStatus.value,
        mediumStatus: mediumStatus.value,
        communicationStatus: communicationStatus.value,
      );

      final response = await ApiService.submitTask(submission);

      if (response['success'] == true) {
        SuccessModal.show(
          Get.context!,
          title: 'Success!',
          message: 'Task submitted successfully',
          onPressed: () {
            Get.back(); // Close modal
            Get.back(); // Go back to previous screen
          },
        );
      } else {
        ErrorModal.show(
          Get.context!,
          title: 'Submission Failed',
          message: response['message'] ?? 'Failed to submit task',
        );
      }
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'An error occurred. Please try again.',
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}

