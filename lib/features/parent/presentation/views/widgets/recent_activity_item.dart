import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class RecentActivityItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const RecentActivityItem({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });

  factory RecentActivityItem.fromActivity({
    required String activity,
    required String timeAgo,
    required String status,
  }) {
    IconData icon;
    Color bgColor;
    Color color;
    String description = status;

    switch (activity.toLowerCase()) {
      case 'submitted homework':
        icon = Icons.check_circle_outline;
        bgColor = const Color(0xFFDCFCE7);
        color = const Color(0xFF16A34A);
        break;
      case 'new announcement':
        icon = Icons.campaign_outlined;
        bgColor = const Color(0xFFFFEDD5);
        color = const Color(0xFFEA580C);
        break;
      case 'message from teacher':
        icon = Icons.chat_bubble_outline;
        bgColor = const Color(0xFFF3E8FF);
        color = const Color(0xFF9333EA);
        break;
      case 'exam result':
        icon = Icons.grade_outlined;
        bgColor = const Color(0xFFDBEAFE);
        color = const Color(0xFF2563EB);
        break;
      case 'attendance':
        icon = Icons.access_time;
        bgColor = const Color(0xFFFEF3C7);
        color = const Color(0xFFD97706);
        break;
      default:
        icon = Icons.notifications_outlined;
        bgColor = const Color(0xFFF1F5F9);
        color = const Color(0xFF64748B);
    }

    return RecentActivityItem(
      title: activity,
      description: description,
      time: timeAgo,
      icon: icon,
      iconBgColor: bgColor,
      iconColor: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.homeworkBlue.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bold14.copyWith(color: AppColors.darkBlue),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyle.regular12.copyWith(
                    color: AppColors.grey,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: AppTextStyle.medium12.copyWith(
                    color: AppColors.grey.withValues(alpha: 0.6),
                    fontSize: 10,
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