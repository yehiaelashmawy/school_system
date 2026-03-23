import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class HomeworkDetailsDescription extends StatelessWidget {
  const HomeworkDetailsDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.description_outlined, color: AppColors.primaryColor, size: 20),
            const SizedBox(width: 8),
            Text(
              'Description',
              style: AppTextStyle.bold16.copyWith(color: AppColors.black),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Explore the fascinating world of the ancient Mesopotamian and Egyptian civilizations. Students will investigate the social structures, technological advancements, and cultural legacies that shaped these early societies and continue to influence the modern world.',
            style: AppTextStyle.regular14.copyWith(
              color: AppColors.grey,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
