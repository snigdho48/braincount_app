import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import '../controllers/task_submission_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../data/services/camera_service.dart';

class TaskSubmissionView extends GetView<TaskSubmissionController> {
  const TaskSubmissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Current Billboard Image
                      _buildCurrentBillboardImage(),
                      const SizedBox(height: 24),
                      // Billboard Condition
                      _buildConditionSection(),
                      const SizedBox(height: 24),
                      // Notes Section
                      _buildNotesSection(),
                      const SizedBox(height: 24),
                      // Billboard Pictures
                      _buildPicturesSection(),
                      const SizedBox(height: 24),
                      // Upload List
                      _buildUploadList(),
                      const SizedBox(height: 30),
                      // Submit Button
                      Obx(() => CustomButton(
                            text: 'Submit',
                            onPressed: controller.submitTask,
                            isLoading: controller.isSubmitting.value,
                          )),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.5),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.textWhite,
            ),
          ),
          const Expanded(
            child: Text(
              'Task Submission',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentBillboardImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              'Current Billboard Image:',
              style: TextStyle(
                color: AppColors.textGrey,
                fontSize: 14,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Severe Damage',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/designs/dashboard dafult.png',
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 150,
                color: AppColors.cardBackground,
                child:  Icon(
                  Icons.image,
                  color: AppColors.textGrey,
                  size: 48,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map, color: AppColors.success, size: 16),
              label: Text(
                'See Map',
                style: TextStyle(
                  color: AppColors.success,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConditionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Billboard Condition:',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: controller.conditionOptions.map((condition) {
                final isSelected =
                    controller.selectedConditions.contains(condition);
                return GestureDetector(
                  onTap: () => controller.toggleCondition(condition),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                          border: Border.all(
                            color: AppColors.borderColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        condition,
                        style:  TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller.notesController,
          maxLines: 3,
          style: TextStyle(color: AppColors.textWhite),
          decoration: InputDecoration(
            hintText: 'intentional damage or hacking of display system',
            hintStyle: TextStyle(color: AppColors.textGrey),
            filled: true,
            fillColor: AppColors.cardDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPicturesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Billboard Picture:',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
         Text(
          'You can select 4 images at once. Size : PDF or JPG of Max Size 120 KB',
          style: TextStyle(
            color: AppColors.textGrey,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 16),
        // Image Slots
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildImageSlot(0),
            _buildImageSlot(1),
            _buildImageSlot(2),
            _buildImageSlot(3),
          ],
        ),
        const SizedBox(height: 16),
        // Browse Files Button
        CustomButton(
          text: 'Browse files',
          onPressed: controller.browseImage,
          height: 48,
        ),
      ],
    );
  }

  Widget _buildImageSlot(int index) {
    return Obx(() {
      final hasImage = controller.submittedImages.length > index;
      
      return GestureDetector(
        onTap: hasImage ? null : controller.captureImage,
        child: DottedBorder(
          color: AppColors.borderColor,
          strokeWidth: 2,
          dashPattern: const [6, 3],
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: hasImage
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          base64Decode(
                              controller.submittedImages[index].base64Data),
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () => controller.removeImage(index),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                :  Icon(
                    Icons.add,
                    color: AppColors.textGrey,
                    size: 32,
                  ),
          ),
        ),
      );
    });
  }

  Widget _buildUploadList() {
    return Obx(() {
      if (controller.submittedImages.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        children: controller.submittedImages.asMap().entries.map((entry) {
          final index = entry.key;
          final image = entry.value;
          final isUploading = controller.isUploading.contains(index);

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.description,
                  color: AppColors.info,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        image.fileName,
                        style: const TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${CameraService.formatFileSize(image.fileSize)} • ',
                            style:  TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 12,
                            ),
                          ),
                          if (isUploading)
                            const Text(
                              'Uploading...',
                              style: TextStyle(
                                color: AppColors.warning,
                                fontSize: 12,
                              ),
                            )
                          else
                            const Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.success,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Completed',
                                  style: TextStyle(
                                    color: AppColors.success,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isUploading)
                  IconButton(
                    onPressed: () => controller.removeImage(index),
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.error,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }
}


