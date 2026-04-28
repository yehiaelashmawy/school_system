import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class UpcomingEventCard extends StatelessWidget {
  final String month;
  final String day;
  final String title;
  final String details;
  final Color dateBgColor;

  const UpcomingEventCard({
    super.key,
    required this.month,
    required this.day,
    required this.title,
    required this.details,
    this.dateBgColor = const Color(0xFFE0E7FF),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: dateBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  month,
                  style: AppTextStyle.bold12.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 10,
                  ),
                ),
                Text(
                  day,
                  style: AppTextStyle.bold18.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
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
                  details,
                  style: AppTextStyle.medium12.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: AppColors.grey.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}
