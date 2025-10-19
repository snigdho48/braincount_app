import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../data/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: Responsive.sp(12)),
        padding: EdgeInsets.all(Responsive.sp(12)),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(Responsive.radiusLg),
          border: Border.all(
            color: AppColors.success.withOpacity(0.3),
            width: Responsive.sp(1),
          ),
        ),
        child: Row(
          children: [
            // Task Image
            ClipRRect(
              borderRadius: BorderRadius.circular(Responsive.radiusMd),
              child: Image.asset(
                'assets/designs/dashboard dafult.png',
                width: Responsive.sp(80),
                height: Responsive.sp(80),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: Responsive.sp(80),
                    height: Responsive.sp(80),
                    color: AppColors.cardBackground,
                    child: Icon(
                      Icons.image,
                      color: AppColors.textGrey,
                      size: Responsive.iconSize,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: Responsive.sp(12)),
            // Task Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${task.id}: ',
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: Responsive.fontSize(12),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          task.title,
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: Responsive.fontSize(14),
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.sp(4)),
                  Text(
                    'Submission Status: ${task.submissionStatus ?? "Accepted"}',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: Responsive.fontSize(12),
                    ),
                  ),
                  Text(
                    'Submitted Status: ${task.submittedStatus ?? "Good"}',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: Responsive.fontSize(12),
                    ),
                  ),
                  Text(
                    'View: ${task.views}',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: Responsive.fontSize(12),
                    ),
                  ),
                ],
              ),
            ),
            // Arrow Icon
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textGrey,
                  size: Responsive.sp(16),
                ),
                SizedBox(height: Responsive.sp(24)),
                if (task.deadline != null)
                  Text(
                    DateFormat('dd/MM/yy').format(task.deadline!),
                    style: TextStyle(
                      color: AppColors.error,
                      fontSize: Responsive.fontSize(11),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
