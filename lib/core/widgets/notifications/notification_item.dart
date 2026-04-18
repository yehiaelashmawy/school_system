import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/utils/theme_manager.dart';
import 'package:school_system/core/utils/size_config.dart';
import 'notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeManager.isDarkMode ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeManager.isDarkMode
              ? AppColors.lightGrey
              : const Color(0xffE2E8F0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: notification.iconBackgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              notification.iconData,
              color: notification.iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: AppTextStyle.bold16.copyWith(
                          color: AppColors.darkBlue,
                          fontSize: SizeConfig.getResponsiveFontSize(
                            context,
                            fontSize: 16,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      notification.timeAgo,
                      style: AppTextStyle.regular12.copyWith(
                        color: AppColors.grey,
                        fontSize: SizeConfig.getResponsiveFontSize(
                          context,
                          fontSize: 10,
                        ),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification.message,
                        style: AppTextStyle.regular14.copyWith(
                          color: AppColors.grey,
                          fontSize: SizeConfig.getResponsiveFontSize(
                            context,
                            fontSize: 14,
                          ),
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.delete_outline,
                      color: Colors.red.withValues(alpha: 0.5),
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
