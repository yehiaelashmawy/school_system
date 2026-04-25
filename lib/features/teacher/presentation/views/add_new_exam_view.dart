import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/data/repos/teacher_classes_repo.dart';
import 'package:school_system/features/teacher/data/repos/teacher_subjects_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_classes_cubit/teacher_classes_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_subjects_cubit/teacher_subjects_cubit.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/add_new_exam_view_body.dart';

import 'package:school_system/features/teacher/presentation/manager/add_exam_cubit/add_exam_cubit.dart';
import 'package:school_system/features/teacher/data/repos/teacher_exams_repo.dart';

class AddNewExamView extends StatelessWidget {
  const AddNewExamView({super.key});
  static const String routeName = '/add_new_exam';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff0F52BD)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add New Exam',
          style: AppTextStyle.bold16.copyWith(
            color: const Color(0xff0F2042),
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exam saved as draft')),
              );
              Navigator.pop(context, true);
            },
            child: Text(
              'Drafts',
              style: AppTextStyle.medium14.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
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
            create: (context) => AddExamCubit(TeacherExamsRepo(ApiService())),
          ),
        ],
        // Use builder to obtain a new BuildContext that has access to providers.
        child: const AddNewExamViewBody(),
      ),
    );
  }
}
