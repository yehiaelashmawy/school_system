import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class ChildCard extends StatelessWidget {
  final String name;
  final String grade;
  final double gpa;
  final double attendance;
  final int subjectsCount;
  final VoidCallback? onTap;

  const ChildCard({
    super.key,
    required this.name,
    required this.grade,
    this.gpa = 0,
    this.attendance = 0,
    this.subjectsCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 4,
                  color: AppColors.secondaryColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyle.bold16.copyWith(color: AppColors.darkBlue),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          grade,
                          style: AppTextStyle.medium12.copyWith(color: AppColors.grey),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildStat('GPA', gpa > 0 ? gpa.toStringAsFixed(1) : '-'),
                            const SizedBox(width: 16),
                            _buildStat('Attendance', attendance > 0 ? '${attendance.toInt()}%' : '-'),
                            const SizedBox(width: 16),
                            _buildStat('Subjects', subjectsCount > 0 ? subjectsCount.toString() : '-'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.chevron_right,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTextStyle.bold14.copyWith(color: AppColors.secondaryColor),
        ),
        Text(
          label,
          style: AppTextStyle.regular12.copyWith(color: AppColors.grey),
        ),
      ],
    );
  }
}