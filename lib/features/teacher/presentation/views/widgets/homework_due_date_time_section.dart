import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_text_field.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/field_label.dart';

class HomeworkDueDateTimeSection extends StatelessWidget {
  const HomeworkDueDateTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FieldLabel(label: 'Due Date'),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: 'mm/dd/yyyy',
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FieldLabel(label: 'Due Time'),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: '--:-- --',
                suffixIcon: Icon(
                  Icons.access_time,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
