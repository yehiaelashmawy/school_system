import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/helper/shared_prefs_helper.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/data/repos/teacher_timetable_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_weekly_schedule_cubit/teacher_weekly_schedule_cubit.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/teacher_weekly_schedule_view_body.dart';

class TeacherWeeklyScheduleView extends StatelessWidget {
  const TeacherWeeklyScheduleView({super.key});
  static const String routeName = 'teacher_weekly_schedule_view';

  @override
  Widget build(BuildContext context) {
    final teacherIdentifier =
        (SharedPrefsHelper.teacherOid?.trim().isNotEmpty ?? false)
        ? SharedPrefsHelper.teacherOid!.trim()
        : (SharedPrefsHelper.userId ?? '');

    return BlocProvider(
      create: (context) =>
          TeacherWeeklyScheduleCubit(TeacherTimetableRepo(ApiService()))
            ..fetchWeeklySchedule(teacherIdentifier),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Teacher Weekly Schedule',
            style: AppTextStyle.bold16.copyWith(
              color: AppColors.darkBlue,
              fontSize: 18,
            ),
          ),
        ),
        body: const TeacherWeeklyScheduleViewBody(),
      ),
    );
  }
}
