import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/utils/size_config.dart';
import 'package:school_system/core/utils/theme_manager.dart';

class ChatAppBarTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const ChatAppBarTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xffCDE1D6),
          child: Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.bold16.copyWith(
                color: ThemeManager.isDarkMode ? Colors.white : AppColors.darkBlue,
                fontSize: SizeConfig.getResponsiveFontSize(context, fontSize: 16),
              ),
            ),
            Text(
              subtitle,
              style: AppTextStyle.semiBold14.copyWith(
                color: const Color(0xFF10B981), // Green color
                fontSize: SizeConfig.getResponsiveFontSize(context, fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
