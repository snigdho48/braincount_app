import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/task_model.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Responsive.sp(12)),
            padding: EdgeInsets.all(Responsive.sp(14)),
            decoration: BoxDecoration(
              color: const Color(0xFF365138), // Green background as per Figma
              borderRadius: BorderRadius.circular(Responsive.sp(10)),
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
                  color: AppColors.textWhite,
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
                      color: AppColors.textWhite,
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
                                color: AppColors.textWhite,
                                height: 1.25,
                                letterSpacing: 0.18,
                              ),
                            ),
                            SizedBox(height: Responsive.sp(4)),
                            Text(
                              'Submitted Status: ${task.submittedStatus ?? 'Good'}',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(9),
                                color: AppColors.textWhite,
                                height: 1.25,
                                letterSpacing: 0.18,
                              ),
                            ),
                            SizedBox(height: Responsive.sp(4)),
                            Text(
                              'View: ${task.views}',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(9),
                                color: AppColors.textWhite,
                                height: 1.25,
                                letterSpacing: 0.18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Arrow icon
                      Transform.rotate(
                        angle: -1.579, // 268.584 degrees in radians
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: Responsive.sp(12),
                          color: AppColors.textWhite,
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
      right: Responsive.sp(15),
      bottom: Responsive.sp(14),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.sp(6),
          vertical: Responsive.sp(3),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Responsive.sp(12)),
          border: Border.all(color: const Color(0xFFFF2929).withOpacity(0.3)),
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
                  color: const Color(0xFFFF2929),
                ),
              ),
              TextSpan(
                text: deadlineText,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

