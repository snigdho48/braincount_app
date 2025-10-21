import 'dart:convert';
import 'package:braincount/app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import '../controllers/task_submission_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../data/services/camera_service.dart';
import '../../../data/services/theme_service.dart';

class TaskSubmissionView extends GetView<TaskSubmissionController> {
  const TaskSubmissionView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    
    return Scaffold(
      body: Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
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
                  padding: EdgeInsets.all(Responsive.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Current Billboard Image
                      _buildCurrentBillboardImage(),
                      SizedBox(height: Responsive.lgVertical),
                      // Billboard Condition
                      _buildConditionSection(),
                      // Notes Section (conditional)
                      Obx(() {
                        if (controller.selectedConditions.contains('If other please write')) {
                          return Column(
                            children: [
                              SizedBox(height: Responsive.lgVertical),
                              _buildNotesSection(),
                              SizedBox(height: Responsive.lgVertical),
                            ],
                          );
                        }
                        return SizedBox(height: Responsive.lgVertical);
                      }),
                      // Billboard Pictures
                      _buildPicturesSection(),
                      SizedBox(height: Responsive.lgVertical),
                      // Upload List
                      _buildUploadList(),
                      SizedBox(height: Responsive.xlVertical),
                      // Submit Button
                      Obx(() => CustomButton(
                            text: 'Submit',
                            onPressed: controller.submitTask,
                            isLoading: controller.isSubmitting.value,
                          )),
                      SizedBox(height: Responsive.lgVertical),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(bottom: Responsive.lg),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.5),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryText,
            ),
          ),
          Expanded(
            child: Text(
              'Task Submission',
              style: TextStyle(
                fontSize: Responsive.fontSize(18),
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: Responsive.sp(40)),
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
                color: AppColors.secondaryText,
                fontSize: Responsive.fontSize(14),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.sp(12), 
                vertical: Responsive.sp(4)
              ),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.8),
                borderRadius: BorderRadius.circular(Responsive.radiusLg),
              ),
              child: Text(
                'Severe Damage',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Responsive.fontSize(11),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.smVertical),
        ClipRRect(
          borderRadius: BorderRadius.circular(Responsive.radiusLg),
          child: Image.asset(
            'assets/designs/dashboard dafult.png',
            width: double.infinity,
            height: Responsive.sp(150),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: Responsive.sp(150),
                color: AppColors.cardBackground,
                child:  Icon(
                  Icons.image,
                  color: AppColors.secondaryText,
                  size: Responsive.sp(48),
                ),
              );
            },
          ),
        ),
        SizedBox(height: Responsive.smVertical),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map, color: AppColors.success, size: Responsive.sp(16)),
              label: Text(
                'See Map',
                style: TextStyle(
                  color: AppColors.success,
                  fontSize: Responsive.fontSize(12),
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
        Text(
          'Billboard Condition:',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: Responsive.fontSize(16),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Responsive.smVertical),
        Obx(() {
          final conditions = controller.conditionOptions;
          return Column(
            children: List.generate(
              (conditions.length / 2).ceil(),
              (rowIndex) {
                final startIndex = rowIndex * 2;
                final endIndex = (startIndex + 2).clamp(0, conditions.length);
                final rowItems = conditions.sublist(startIndex, endIndex);
                
                return Padding(
                  padding: EdgeInsets.only(bottom: Responsive.sp(8)),
                  child: Row(
                    children: [
                      ...rowItems.map((condition) {
                        final isSelected = controller.selectedConditions.contains(condition);
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => controller.toggleCondition(condition),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: Responsive.sp(20),
                                  height: Responsive.sp(20),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: AppColors.borderColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(Responsive.sp(4)),
                                  ),
                                  child: isSelected
                                      ? Icon(
                                          Icons.check,
                                          size: Responsive.sp(14),
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                SizedBox(width: Responsive.sp(8)),
                                Expanded(
                                  child: Text(
                                    condition,
                                    style: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: Responsive.fontSize(13),
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      // Add empty space if odd number of items
                      if (rowItems.length == 1) Expanded(child: SizedBox()),
                    ],
                  ),
                );
              },
            ),
          );
        }),
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
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: Responsive.fontSize(14),
          ),
          decoration: InputDecoration(
            hintText: 'intentional damage or hacking of display system',
            hintStyle: TextStyle(
              color: AppColors.secondaryText,
              fontSize: Responsive.fontSize(14),
            ),
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.radiusLg),
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
        Text(
          'Billboard Picture:',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: Responsive.fontSize(14),
          ),
        ),
        SizedBox(height: Responsive.sp(4)),
         Text(
          'You can select 4 images at once. Only JPG or PNG supported.',
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: Responsive.fontSize(11),
          ),
        ),
        SizedBox(height: Responsive.mdVertical),
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
        SizedBox(height: Responsive.mdVertical),
        // Browse Files Button
        CustomButton(
          text: 'Browse files',
          onPressed: controller.browseImage,
          height: Responsive.sp(48),
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
          dashPattern: [Responsive.sp(6), Responsive.sp(3)],
          borderType: BorderType.RRect,
          radius: Radius.circular(Responsive.radiusLg),
          child: Container(
            width: Responsive.sp(70),
            height: Responsive.sp(70),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(Responsive.radiusLg),
            ),
            child: hasImage
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Responsive.radiusLg),
                        child: Image.memory(
                          base64Decode(
                              controller.submittedImages[index].base64Data),
                          width: Responsive.sp(70),
                          height: Responsive.sp(70),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: Responsive.sp(2),
                        right: Responsive.sp(2),
                        child: GestureDetector(
                          onTap: () => controller.removeImage(index),
                          child: Container(
                            padding: EdgeInsets.all(Responsive.sp(2)),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: Responsive.sp(12),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                :  Icon(
                    Icons.add,
                    color: AppColors.secondaryText,
                    size: Responsive.sp(32),
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
            margin: EdgeInsets.only(bottom: Responsive.smVertical),
            padding: EdgeInsets.all(Responsive.md),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(Responsive.radiusLg),
              border: Border.all(
                color: AppColors.border.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.description,
                  color: AppColors.info,
                  size: Responsive.sp(32),
                ),
                SizedBox(width: Responsive.sp(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        image.fileName,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: Responsive.fontSize(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Responsive.sp(4)),
                      Row(
                        children: [
                          Text(
                            '${CameraService.formatFileSize(image.fileSize)} • ',
                            style:  TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: Responsive.fontSize(12),
                            ),
                          ),
                          if (isUploading)
                            Text(
                              'Uploading...',
                              style: TextStyle(
                                color: AppColors.warning,
                                fontSize: Responsive.fontSize(12),
                              ),
                            )
                          else
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.success,
                                  size: Responsive.sp(14),
                                ),
                                SizedBox(width: Responsive.sp(4)),
                                Text(
                                  'Completed',
                                  style: TextStyle(
                                    color: AppColors.success,
                                    fontSize: Responsive.fontSize(12),
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


