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
  final selectedConditions = <String>[].obs;
  final notesController = TextEditingController();
  final submittedImages = <SubmissionImage>[].obs;
  final isUploading = <int>[].obs;
  final isSubmitting = false.obs;

  final maxImages = 4;

  final conditionOptions = [
    'Resolved',
    'Good',
    'Color Faded',
    'Colour Severely Bad',
    'Medium Teared',
    'Medium Damaged',
    'Medium Missing',
    'Structure Damaged',
    'Structure Missing',
    'Communication Right',
    'Communication Wrong',
    'Communication Missing',
  ];

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

  void toggleCondition(String condition) {
    if (selectedConditions.contains(condition)) {
      selectedConditions.remove(condition);
    } else {
      selectedConditions.add(condition);
    }
  }

  Future<void> captureImage() async {
    if (submittedImages.length >= maxImages) {
      ErrorModal.show(
        Get.context!,
        title: 'Limit Reached',
        message: 'You can only upload up to $maxImages images',
      );
      return;
    }

    try {
      final base64Image = await CameraService.takePhotoFromBackCamera();
      
      if (base64Image != null) {
        final imageIndex = submittedImages.length;
        isUploading.add(imageIndex);

        // Simulate upload delay
        await Future.delayed(const Duration(seconds: 2));

        final fileSize = CameraService.getBase64FileSize(base64Image);
        final submissionImage = SubmissionImage(
          base64Data: base64Image,
          fileName: 'Picture${submittedImages.length + 1}',
          fileSize: fileSize,
          status: 'completed',
        );

        submittedImages.add(submissionImage);
        isUploading.remove(imageIndex);
      }
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'Failed to capture image. Please try again.',
      );
    }
  }

  Future<void> browseImage() async {
    if (submittedImages.length >= maxImages) {
      ErrorModal.show(
        Get.context!,
        title: 'Limit Reached',
        message: 'You can only upload up to $maxImages images',
      );
      return;
    }

    try {
      final base64Image = await CameraService.pickImageFromGallery();
      
      if (base64Image != null) {
        final imageIndex = submittedImages.length;
        isUploading.add(imageIndex);

        // Simulate upload delay
        await Future.delayed(const Duration(seconds: 2));

        final fileSize = CameraService.getBase64FileSize(base64Image);
        final submissionImage = SubmissionImage(
          base64Data: base64Image,
          fileName: 'Picture${submittedImages.length + 1}',
          fileSize: fileSize,
          status: 'completed',
        );

        submittedImages.add(submissionImage);
        isUploading.remove(imageIndex);
      }
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'Failed to select image. Please try again.',
      );
    }
  }

  void removeImage(int index) {
    submittedImages.removeAt(index);
  }

  Future<void> submitTask() async {
    if (selectedConditions.isEmpty) {
      ErrorModal.show(
        Get.context!,
        title: 'Validation Error',
        message: 'Please select at least one billboard condition',
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
        conditions: selectedConditions.toList(),
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        images: submittedImages.toList(),
        submittedAt: DateTime.now(),
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

