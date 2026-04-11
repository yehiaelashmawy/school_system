import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class StudentAssignmentTeacherInstructions extends StatelessWidget {
  final String teacherName;
  final String teacherInstructions;

  const StudentAssignmentTeacherInstructions({
    super.key,
    required this.teacherName,
    required this.teacherInstructions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.co_present_outlined, color: AppColors.secondaryColor),
            const SizedBox(width: 8),
            Text(
              'Teacher\'s Instructions',
              style: AppTextStyle.bold16.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightGrey,
              ),
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teacherName,
                    style: AppTextStyle.bold14.copyWith(
                      color: AppColors.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: AppColors.primaryColor.withValues(alpha: 0.3),
                          width: 3,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
                    child: Text(
                      '"$teacherInstructions"',
                      style: AppTextStyle.medium12.copyWith(
                        color: AppColors.grey,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
