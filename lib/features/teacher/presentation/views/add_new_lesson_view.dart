import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/data/repos/add_lesson_repo.dart';
import 'package:school_system/features/teacher/data/repos/teacher_classes_repo.dart';
import 'package:school_system/features/teacher/data/repos/teacher_subjects_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/add_lesson_cubit/add_lesson_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_classes_cubit/teacher_classes_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_subjects_cubit/teacher_subjects_cubit.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/add_new_lesson_view_body.dart';

class AddNewLessonView extends StatelessWidget {
  const AddNewLessonView({super.key});
  static const String routeName = '/add_new_lesson';

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
          'Add New Lesson',
          style: AppTextStyle.bold16.copyWith(
            color: AppColors.darkBlue,
            fontSize: 18, // slightly larger
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TeacherClassesCubit(
              TeacherClassesRepo(ApiService()),
            )..fetchClasses(),
          ),
          BlocProvider(
            create: (context) => TeacherSubjectsCubit(
              TeacherSubjectsRepo(ApiService()),
            )..fetchSubjects(),
          ),
          BlocProvider(
            create: (context) =>
                AddLessonCubit(AddLessonRepo(ApiService())),
          ),
        ],
        child: const AddNewLessonViewBody(),
      ),
    );
  }
}

