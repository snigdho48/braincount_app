import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/theme_service.dart';

class PendingTaskCard extends StatelessWidget {
  final TaskModel task;
  final int index;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onDetails;

  const PendingTaskCard({
    super.key,
    required this.task,
    required this.index,
    required this.isExpanded,
    required this.onTap,
    this.onAccept,
    this.onReject,
    this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
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
                    ? AppColors.primary.withOpacity(0.5) 
                    : AppColors.primary.withOpacity(0.2),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                                  color: AppColors.cardBackground,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Responsive.sp(6)),
                                  child: task.imageUrl.isNotEmpty && task.imageUrl.startsWith('data:image')
                                      ? Image.network(
                                          task.imageUrl,
                                          width: Responsive.sp(66),
                                          height: Responsive.sp(42),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/figma_exports/50f61fdb67813faee19ba296bbb09fda88e00dfd.png',
                                              width: Responsive.sp(66),
                                              height: Responsive.sp(42),
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                      : task.imageUrl.isNotEmpty
                                          ? Image.network(
                                              task.imageUrl,
                                              width: Responsive.sp(66),
                                              height: Responsive.sp(42),
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/figma_exports/50f61fdb67813faee19ba296bbb09fda88e00dfd.png',
                                                  width: Responsive.sp(66),
                                                  height: Responsive.sp(42),
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            )
                                          : Image.asset(
                                              'assets/figma_exports/50f61fdb67813faee19ba296bbb09fda88e00dfd.png',
                                              width: Responsive.sp(66),
                                              height: Responsive.sp(42),
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
                                      'Location: ${task.location}',
                                      style: TextStyle(
                                        fontSize: Responsive.fontSize(9),
                                        color: AppColors.primaryText,
                                        height: 1.25,
                                        letterSpacing: 0.18,
                                      ),
                                    ),
                                    SizedBox(height: Responsive.sp(4)),
                                    Text(
                                      'Reward: ${task.reward.toStringAsFixed(2)} BDT',
                                      style: TextStyle(
                                        fontSize: Responsive.fontSize(9),
                                        color: AppColors.success,
                                        fontWeight: FontWeight.w600,
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
                                angle: 0,
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
        
        // Accept/Reject/Details buttons (only shown when expanded)
        if (isExpanded) ...[
          SizedBox(height: Responsive.sp(12)),
          Row(
            children: [
              // Accept Button
              Expanded(
                child: GestureDetector(
                  onTap: onAccept,
                  child: Container(
                    height: Responsive.sp(30),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(Responsive.sp(8)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.success.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(14),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(width: Responsive.sp(8)),
              
              // Reject Button
              Expanded(
                child: GestureDetector(
                  onTap: onReject,
                  child: Container(
                    height: Responsive.sp(30),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(Responsive.sp(8)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.error.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Reject',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(14),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(width: Responsive.sp(8)),
              
              // Details Button
              Expanded(
                child: GestureDetector(
                  onTap: onDetails,
                  child: Container(
                    height: Responsive.sp(30),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(Responsive.sp(8)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(14),
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
        ],
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
      bottom: isExpanded
          ? Responsive.sp(70)  // Higher when buttons are visible
          : Responsive.sp(28),
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

