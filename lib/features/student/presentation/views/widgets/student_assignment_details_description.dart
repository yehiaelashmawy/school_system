import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class StudentAssignmentDetailsDescription extends StatelessWidget {
  final String description;

  const StudentAssignmentDetailsDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.description_outlined, color: AppColors.secondaryColor),
            const SizedBox(width: 8),
            Text(
              'Description',
              style: AppTextStyle.bold16.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: AppTextStyle.medium14.copyWith(
            color: AppColors.grey,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
