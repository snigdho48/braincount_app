import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/task_details_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../core/utils/responsive.dart';

class TaskDetailsView extends GetView<TaskDetailsController> {
  const TaskDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Obx(() => Container(
        decoration:  BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              // Content
              Expanded(
                child: Obx(() {
                  final task = controller.task.value;
                  if (task == null) {
                    return  Center(
                      child: Text(
                        'Task not found',
                        style: TextStyle(color: AppColors.secondaryText),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Task Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/designs/dashboard dafult.png',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 200,
                                color: AppColors.cardBackground,
                                child:  Icon(
                                  Icons.image,
                                  color: AppColors.secondaryText,
                                  size: 64,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Task Title
                        Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Task Details
                        _buildDetailRow('Task ID:', task.id),
                        _buildDetailRow('Location:', task.location),
                        _buildDetailRow(
                          'Reward:',
                          '৳${task.reward.toStringAsFixed(2)}',
                        ),
                        _buildDetailRow(
                          'Status:',
                          task.status.toUpperCase(),
                          statusColor: task.isSubmitted
                              ? AppColors.success
                              : task.isPending
                                  ? AppColors.warning
                                  : AppColors.error,
                        ),
                        if (task.deadline != null)
                          _buildDetailRow(
                            'Deadline:',
                            DateFormat('dd MMM yyyy, HH:mm')
                                .format(task.deadline!),
                          ),
                        const SizedBox(height: 16),
                        // Description
                        Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          task.description,
                          style:  TextStyle(
                            fontSize: 14,
                            color: AppColors.secondaryText,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Submission Info
                        if (task.isSubmitted) ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.success.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Submission Information',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _buildDetailRow('Submission Status:',
                                    task.submissionStatus ?? 'N/A'),
                                _buildDetailRow('Submitted Status:',
                                    task.submittedStatus ?? 'N/A'),
                                _buildDetailRow('Views:', '${task.views}'),
                                if (task.submittedAt != null)
                                  _buildDetailRow(
                                    'Submitted At:',
                                    DateFormat('dd MMM yyyy, HH:mm')
                                        .format(task.submittedAt!),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                        // Submit Button
                        if (task.isPending)
                          CustomButton(
                            text: 'Submit Task',
                            onPressed: controller.goToSubmission,
                            icon: Icons.camera_alt,
                          ),
                      ],
                    ),
                  );
                }),
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
              'Task Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? statusColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child:               Text(
              label,
              style:  TextStyle(
                fontSize: 14,
                color: AppColors.secondaryText,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: statusColor ?? AppColors.primaryText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


