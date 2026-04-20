import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_text_field.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/exam_attachments_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/exam_details_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/exam_grading_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/exam_schedule_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/section_header.dart';

class AddNewExamViewBody extends StatelessWidget {
  const AddNewExamViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(icon: Icons.description_outlined, title: 'Exam Details'),
          const SizedBox(height: 16),
          const ExamDetailsSection(),
          const SizedBox(height: 24),

          const SectionHeader(icon: Icons.calendar_today_outlined, title: 'Schedule'),
          const SizedBox(height: 16),
          const ExamScheduleSection(),
          const SizedBox(height: 24),

          const SectionHeader(icon: Icons.star_outline_rounded, title: 'Grading'),
          const SizedBox(height: 16),
          const ExamGradingSection(),
          const SizedBox(height: 24),

          const SectionHeader(icon: Icons.info_outline_rounded, title: 'Exam Instructions'),
          const SizedBox(height: 16),
          const CustomTextField(
            hintText: 'Enter instructions for students...',
            maxLines: 4,
          ),
          const SizedBox(height: 24),

          const SectionHeader(icon: Icons.attachment_outlined, title: 'Attachments'),
          const SizedBox(height: 16),
          const ExamAttachmentsSection(),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exam scheduled successfully')),
                );
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.send_outlined, color: AppColors.white, size: 20),
              label: Text(
                'Schedule Exam',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
