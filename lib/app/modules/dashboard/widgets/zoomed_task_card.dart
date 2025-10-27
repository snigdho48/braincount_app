import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/task_model.dart';

class ZoomedTaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onClose;

  const ZoomedTaskCard({
    super.key,
    required this.task,
    required this.onAccept,
    required this.onReject,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final scale = Responsive.scaleWidth(393.0);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16 * scale,
        vertical: 12 * scale,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(
          color: AppColors.border.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with close button
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.id,
                    style: TextStyle(
                      fontSize: 12 * scale,
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    padding: EdgeInsets.all(4 * scale),
                    child: Icon(
                      Icons.close,
                      size: 20 * scale,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Task Image
          if (task.imageUrl.isNotEmpty)
            Container(
              height: 160 * scale,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16 * scale),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12 * scale),
                color: AppColors.tertiaryBackground,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12 * scale),
                child: Image.asset(
                  task.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.tertiaryBackground,
                      child: Icon(
                        Icons.image,
                        size: 50 * scale,
                        color: AppColors.secondaryText,
                      ),
                    );
                  },
                ),
              ),
            ),

          SizedBox(height: 16 * scale),

          // Task Details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Task Title
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                    height: 1.3,
                  ),
                ),
                
                SizedBox(height: 12 * scale),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16 * scale,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6 * scale),
                    Expanded(
                      child: Text(
                        task.location,
                        style: TextStyle(
                          fontSize: 14 * scale,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10 * scale),

                // Reward
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 16 * scale,
                      color: AppColors.success,
                    ),
                    SizedBox(width: 6 * scale),
                    Text(
                      '${task.reward.toStringAsFixed(2)} BDT',
                      style: TextStyle(
                        fontSize: 14 * scale,
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                if (task.deadline != null) ...[
                  SizedBox(height: 10 * scale),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16 * scale,
                        color: AppColors.warning,
                      ),
                      SizedBox(width: 6 * scale),
                      Text(
                        'Exp: ${DateFormat('dd/MM/yy').format(task.deadline!)}',
                        style: TextStyle(
                          fontSize: 14 * scale,
                          color: AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                ],

                SizedBox(height: 12 * scale),

                // Description
                Text(
                  task.description,
                  style: TextStyle(
                    fontSize: 13 * scale,
                    color: AppColors.secondaryText,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          SizedBox(height: 20 * scale),

          // Accept/Reject Buttons
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Row(
              children: [
                // Accept Button
                Expanded(
                  child: GestureDetector(
                    onTap: onAccept,
                    child: Container(
                      height: 48 * scale,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(10 * scale),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.success.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Accept',
                          style: TextStyle(
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12 * scale),

                // Reject Button
                Expanded(
                  child: GestureDetector(
                    onTap: onReject,
                    child: Container(
                      height: 48 * scale,
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(10 * scale),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.error.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Reject',
                          style: TextStyle(
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

