import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/theme_service.dart';

class SubmittedTaskCard extends StatelessWidget {
  final TaskModel task;
  final int index;
  final VoidCallback onTap;

  const SubmittedTaskCard({
    super.key,
    required this.task,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Use a solid light grey background in light mode for better card appearance
    final isDark = Get.find<ThemeService>().isDarkMode.value;
    final cardColor = isDark ? AppColors.cardBackground : Colors.white;
    
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Responsive.sp(12)),
            padding: EdgeInsets.all(Responsive.sp(14)),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(Responsive.sp(10)),
              border: Border.all(
                color: isDark 
                    ? AppColors.success.withOpacity(0.5) 
                    : AppColors.success.withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark 
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black.withOpacity(0.15),
                  blurRadius: isDark ? 8 : 12,
                  offset: Offset(0, isDark ? 2 : 4),
                  spreadRadius: isDark ? 0 : 1,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            // Task number
            Padding(
              padding: EdgeInsets.only(right: Responsive.sp(10)),
              child: Text(
                '${(index + 1).toString().padLeft(2, '0')}:',
                style: TextStyle(
                  fontSize: Responsive.fontSize(12),
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            
            // Task content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task title
                  Text(
                    'TASK: ${task.title}',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(15),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                      letterSpacing: -0.15,
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: Responsive.sp(8)),
                  
                  // Task image and details
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Task image
                      Container(
                        width: Responsive.sp(66),
                        height: Responsive.sp(42),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Responsive.sp(6)),
                          image: DecorationImage(
                            image: task.imageUrl.isNotEmpty
                                ? NetworkImage(task.imageUrl)
                                : const AssetImage('assets/figma_exports/50f61fdb67813faee19ba296bbb09fda88e00dfd.png') as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      
                      SizedBox(width: Responsive.sp(18)),
                      
                      // Task details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Submission Status: ${task.submissionStatus ?? 'Accepted'}',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(9),
                                color: AppColors.primaryText,
                                height: 1.25,
                                letterSpacing: 0.18,
                              ),
                            ),
                            SizedBox(height: Responsive.sp(4)),
                            Text(
                              'Submitted Status: ${task.submittedStatus ?? 'Good'}',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(9),
                                color: AppColors.primaryText,
                                height: 1.25,
                                letterSpacing: 0.18,
                              ),
                            ),
                            SizedBox(height: Responsive.sp(4)),
                            Text(
                              'View: ${task.views}',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(9),
                                color: AppColors.primaryText,
                                height: 1.25,
                                letterSpacing: 0.18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Arrow icon
                      Transform.rotate(
                        angle: 0, // 268.584 degrees in radians
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: Responsive.sp(12),
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
          
          // Expiry badge
          _buildExpiryBadge(),
        ],
      ),
    );
  }

  Widget _buildExpiryBadge() {
    if (task.deadline == null) return const SizedBox.shrink();
    
    final deadlineText = '${task.deadline!.day.toString().padLeft(2, '0')}/${task.deadline!.month.toString().padLeft(2, '0')}/${task.deadline!.year.toString().substring(2)}';
    
    return Positioned(
      right: Responsive.sp(10),
      bottom: Responsive.sp(25),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.sp(6),
          vertical: Responsive.sp(3),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Responsive.sp(12)),
          border: Border.all(color: AppColors.error.withOpacity(0.5)),
        ),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: Responsive.fontSize(8),
              height: 1.25,
              letterSpacing: 0.16,
            ),
            children: [
              TextSpan(
                text: 'Exp: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.error,
                ),
              ),
              TextSpan(
                text: deadlineText,
                style: TextStyle(
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

