import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xff3b82f6)),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTextStyle.bold16.copyWith(color: AppColors.darkBlue),
        ),
      ],
    );
  }
}
