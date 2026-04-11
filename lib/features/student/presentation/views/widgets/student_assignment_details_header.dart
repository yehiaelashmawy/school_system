import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class StudentAssignmentDetailsHeader extends StatelessWidget {
  final String subjectName;
  final String title;
  final String dueTime;
  final String points;
  final String dateDay;
  final String dateMonth;

  const StudentAssignmentDetailsHeader({
    super.key,
    required this.subjectName,
    required this.title,
    required this.dueTime,
    required this.points,
    required this.dateDay,
    required this.dateMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  subjectName.toUpperCase(),
                  style: AppTextStyle.bold12.copyWith(
                    color: AppColors.darkBlue,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: AppTextStyle.bold24.copyWith(
                  color: AppColors.darkBlue,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Due: $dueTime',
                      style: AppTextStyle.medium12.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.stars,
                    size: 16,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$points Points',
                    style: AppTextStyle.medium12.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dateDay,
                style: AppTextStyle.bold24.copyWith(
                  color: const Color(0xffD92D20),
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dateMonth,
                style: AppTextStyle.bold12.copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
