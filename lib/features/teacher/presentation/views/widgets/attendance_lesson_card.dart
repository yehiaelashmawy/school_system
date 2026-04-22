import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';

class AttendanceLessonCard extends StatelessWidget {
  final TeacherLessonModel lesson;
  final bool isSelected;
  final VoidCallback onTap;

  const AttendanceLessonCard({
    super.key,
    required this.lesson,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.secondaryColor : const Color(0xffE2E8F0),
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.secondaryColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lesson.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.bold14.copyWith(
                color: isSelected ? Colors.white : AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              lesson.date.split('T').first,
              style: AppTextStyle.medium12.copyWith(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.8)
                    : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
