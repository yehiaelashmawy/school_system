import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/data/repos/add_homework_repo.dart';
import 'package:school_system/features/teacher/data/repos/teacher_classes_repo.dart';
import 'package:school_system/features/teacher/data/repos/teacher_subjects_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/add_homework_cubit/add_homework_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_classes_cubit/teacher_classes_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_subjects_cubit/teacher_subjects_cubit.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/add_homework_view_body.dart';

class AddHomeworkView extends StatelessWidget {
  const AddHomeworkView({super.key});

  static const String routeName = 'add_homework_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Homework',
          style: AppTextStyle.bold16.copyWith(
            color: AppColors.darkBlue,
            fontSize: 18,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                TeacherClassesCubit(TeacherClassesRepo(ApiService()))
                  ..fetchClasses(),
          ),
          BlocProvider(
            create: (context) =>
                TeacherSubjectsCubit(TeacherSubjectsRepo(ApiService()))
                  ..fetchSubjects(),
          ),
          BlocProvider(
            create: (context) =>
                AddHomeworkCubit(AddHomeworkRepo(ApiService())),
          ),
        ],
        child: const AddHomeworkViewBody(),
      ),
    );
  }
}
