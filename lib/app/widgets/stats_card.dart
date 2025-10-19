import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class StatsCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const StatsCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.sp(12)),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(Responsive.radiusLg),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: Responsive.sp(1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.sp(8)),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(Responsive.radiusMd),
            ),
            child: FaIcon(
              icon,
              color: color,
              size: Responsive.sp(20),
            ),
          ),
          SizedBox(height: Responsive.smVertical),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.textGrey,
                fontSize: Responsive.fontSize(10),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: Responsive.sp(4)),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.textWhite,
                fontSize: Responsive.fontSize(16),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}


