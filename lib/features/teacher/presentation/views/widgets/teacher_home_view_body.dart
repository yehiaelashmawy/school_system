import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/school_announcements_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/teacher_action_buttons.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/teacher_custom_app_bar.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/todays_classes_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/upcoming_exams_section.dart';

class TeacherHomeViewBody extends StatelessWidget {
  const TeacherHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Forces the safe area status bar to be white
      child: SafeArea(
        bottom: false,
        child: Container(
          color: AppColors.backgroundColor, // Restores grey background for body
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: const TeacherCustomAppBar(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TeacherActionButtons(),
                      SizedBox(height: 32),
                      TodaysClassesSection(),
                      SizedBox(height: 32),
                      SchoolAnnouncementsSection(),
                      SizedBox(height: 32),
                      UpcomingExamsSection(),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
