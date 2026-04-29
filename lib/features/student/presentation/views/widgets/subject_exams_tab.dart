import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/student/data/models/student_my_subjects_model.dart';
import 'package:school_system/features/student/presentation/views/student_exam_details_view.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_exam_item_card.dart';
import 'package:school_system/features/student/presentation/views/widgets/subject_empty_state.dart';

class SubjectExamsTab extends StatelessWidget {
  final List<StudentMyExam> exams;
  final bool isLoading;

  const SubjectExamsTab({
    super.key,
    required this.exams,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Skeletonizer(
        enabled: true,
        child: Column(
          children: List.generate(
            2,
            (_) => StudentExamItemCard(
              iconData: Icons.calendar_today_outlined,
              iconColor: AppColors.primaryColor,
              iconBackgroundColor: AppColors.primaryColor.withValues(
                alpha: 0.1,
              ),
              badgeText: 'UPCOMING',
              badgeTextColor: AppColors.primaryColor,
              badgeBackgroundColor: AppColors.primaryColor.withValues(
                alpha: 0.1,
              ),
              title: 'Loading Exam Title',
              subtitle: 'Loading exam details...',
              bottomLabel: 'STATUS',
              bottomValue: 'Upcoming',
              bottomValueColor: AppColors.darkBlue,
              isPrimaryButton: true,
              onViewDetails: () {},
            ),
          ),
        ),
      );
    }

    if (exams.isEmpty) {
      return const SubjectEmptyState(
        icon: Icons.quiz_outlined,
        message: 'No exams scheduled for this subject yet.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: exams.map((exam) => _buildCard(context, exam)).toList(),
    );
  }

  Widget _buildCard(BuildContext context, StudentMyExam exam) {
    final isGraded = exam.myScore != null;
    final isCompleted = exam.status.toLowerCase() == 'completed' || isGraded;

    final IconData iconData;
    final Color iconColor;
    final Color iconBg;
    final String badgeText;
    final Color badgeTextColor;
    final Color badgeBg;
    final String bottomLabel;
    final String bottomValue;
    final Color bottomValueColor;
    final bool isPrimary;

    if (isGraded) {
      iconData = Icons.check_circle_outline;
      iconColor = AppColors.secondaryColor;
      iconBg = AppColors.primaryColor.withValues(alpha: 0.12);
      badgeText = 'GRADED';
      badgeTextColor = AppColors.secondaryColor;
      badgeBg = AppColors.primaryColor.withValues(alpha: 0.12);
      bottomLabel = 'FINAL GRADE';
      bottomValue = '${exam.myScore?.toStringAsFixed(0)}/${exam.maxScore}';
      bottomValueColor = AppColors.secondaryColor;
      isPrimary = false;
    } else if (isCompleted) {
      iconData = Icons.history;
      iconColor = const Color(0xffB42318);
      iconBg = const Color(0xffB42318).withValues(alpha: 0.1);
      badgeText = 'COMPLETED';
      badgeTextColor = Colors.white;
      badgeBg = const Color(0xff7A271A);
      bottomLabel = 'STATUS';
      bottomValue = 'Awaiting Grade';
      bottomValueColor = AppColors.darkBlue;
      isPrimary = false;
    } else {
      iconData = Icons.calendar_today_outlined;
      iconColor = AppColors.primaryColor;
      iconBg = AppColors.primaryColor.withValues(alpha: 0.1);
      badgeText = exam.formattedDate.isNotEmpty
          ? exam.formattedDate
          : 'UPCOMING';
      badgeTextColor = Colors.white;
      badgeBg = AppColors.secondaryColor;
      bottomLabel = 'STATUS';
      bottomValue = exam.status.isNotEmpty ? exam.status : 'Scheduled';
      bottomValueColor = AppColors.darkBlue;
      isPrimary = true;
    }

    return StudentExamItemCard(
      iconData: iconData,
      iconColor: iconColor,
      iconBackgroundColor: iconBg,
      badgeText: badgeText,
      badgeTextColor: badgeTextColor,
      badgeBackgroundColor: badgeBg,
      title: exam.name,
      subtitle: exam.formattedDate.isNotEmpty
          ? 'Scheduled: ${exam.formattedDate}'
          : 'Date not set',
      bottomLabel: bottomLabel,
      bottomValue: bottomValue,
      bottomValueColor: bottomValueColor,
      isPrimaryButton: isPrimary,
      onViewDetails: () {
        Navigator.pushNamed(
          context,
          StudentExamDetailsView.routeName,
          arguments: StudentExamDetailsArgs(
            status: exam.status,
            title: exam.name,
            date: exam.formattedDate,
            time: '',
            duration: '',
            room: '',
            instructions: const [],
          ),
        );
      },
    );
  }
}
