import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/student/data/repos/student_homework_repo.dart';
import 'package:school_system/features/student/presentation/manager/student_homework_cubit/student_homework_cubit.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_assignments_tab.dart';

class StudentHomeworkView extends StatelessWidget {
  static const String routeName = 'student_homework_view';

  const StudentHomeworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeworkCubit(
        StudentHomeworkRepo(ApiService()),
      )..fetchHomeworks(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text(
            'Homework',
            style: AppTextStyle.bold16.copyWith(
              color: AppColors.black,
              fontSize: 18,
            ),
          ),
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: const StudentAssignmentsTab(),
          ),
        ),
      ),
    );
  }
}

