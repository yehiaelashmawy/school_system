import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class StudentAttendanceMethodCard extends StatelessWidget {
  final Widget iconWidget;
  final Color iconBackgroundColor;
  final Color? iconContainerColor;
  final String title;
  final String description;
  final String actionText;
  final VoidCallback onTap;

  const StudentAttendanceMethodCard({
    super.key,
    required this.iconWidget,
    required this.iconBackgroundColor,
    this.iconContainerColor,
    required this.title,
    required this.description,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconContainerColor ?? iconBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: iconContainerColor != null
                  ? Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: iconBackgroundColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: iconWidget,
                    )
                  : iconWidget,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTextStyle.bold16.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyle.medium12.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  actionText,
                  style: AppTextStyle.bold14.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.secondaryColor,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
