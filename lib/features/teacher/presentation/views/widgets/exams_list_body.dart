import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/exam_item_card.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/exams_toggle_bar.dart';

class ExamsListBody extends StatefulWidget {
  const ExamsListBody({super.key});

  @override
  State<ExamsListBody> createState() => _ExamsListBodyState();
}

class _ExamsListBodyState extends State<ExamsListBody> {
  bool _isUpcomingExams = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Toggle Buttons
          ExamsToggleBar(
            isUpcomingExams: _isUpcomingExams,
            onToggle: (value) {
              setState(() {
                _isUpcomingExams = value;
              });
            },
          ),
          const SizedBox(height: 16),
          // Expanded List View
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                ExamItemCard(
                  title: 'Midterm Examination',
                  date: 'Oct 24, 2023',
                  time: '09:00 AM',
                  subject: 'Mathematics',
                  grade: 'Grade 10-B',
                  status: 'CONFIRMED',
                  statusColor: AppColors.secondaryColor,
                  isDraft: false,
                ),
                const SizedBox(height: 16),
                ExamItemCard(
                  title: 'Physics Quiz: Thermodynamics',
                  date: 'Oct 28, 2023',
                  time: '11:30 AM',
                  subject: 'Science',
                  grade: 'Grade 11-A',
                  status: 'DRAFT',
                  statusColor: AppColors.grey,
                  isDraft: true,
                ),
                const SizedBox(height: 16),
                ExamItemCard(
                  title: 'Advanced Calculus Final',
                  date: 'Nov 05, 2023',
                  time: '08:00 AM',
                  subject: 'Advanced Math',
                  grade: 'Grade 12',
                  status: 'CONFIRMED',
                  statusColor: AppColors.secondaryColor,
                  isDraft: false,
                ),
                const SizedBox(
                  height: 80,
                ), // Padding for the floating action button
              ],
            ),
          ),
        ],
      ),
    );
  }
}
