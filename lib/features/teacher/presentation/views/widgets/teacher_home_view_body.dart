import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/helper/shared_prefs_helper.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/data/repos/announcements_repo.dart';
import 'package:school_system/features/teacher/data/repos/profile_repo.dart';
import 'package:school_system/features/teacher/data/repos/teacher_exams_repo.dart';
import 'package:school_system/features/teacher/data/repos/teacher_timetable_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/announcements_cubit/announcements_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_exams_cubit/teacher_exams_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_timetable_cubit/teacher_timetable_cubit.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/school_announcements_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/teacher_action_buttons.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/teacher_custom_app_bar.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/todays_classes_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/upcoming_exams_section.dart';

class TeacherHomeViewBody extends StatelessWidget {
  const TeacherHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final teacherIdentifier =
        (SharedPrefsHelper.teacherOid?.trim().isNotEmpty ?? false)
        ? SharedPrefsHelper.teacherOid!.trim()
        : (SharedPrefsHelper.userId ?? '');

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AnnouncementsCubit(AnnouncementsRepo(ApiService()))
                ..fetchHighPriorityAnnouncements(take: 2),
        ),
        BlocProvider(
          create: (context) =>
              TeacherExamsCubit(TeacherExamsRepo(ApiService()))..fetchExams(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(ProfileRepo())..fetchProfile(),
        ),
        BlocProvider(
          create: (context) =>
              TeacherTimetableCubit(TeacherTimetableRepo(ApiService()))
                ..fetchTodayClasses(teacherIdentifier),
        ),
      ],
      child: Container(
        color: AppColors.white,
        child: SafeArea(
          bottom: false,
          child: Container(
            color: AppColors.backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.white,
                    child: const TeacherCustomAppBar(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 24.0,
                    ),
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
      ),
    );
  }
}
