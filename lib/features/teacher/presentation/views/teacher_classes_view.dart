import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/data/repos/teacher_classes_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_classes_cubit/teacher_classes_cubit.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/classes_view_body.dart';

class TeacherClassesView extends StatelessWidget {
  const TeacherClassesView({super.key});
  static const String routeName = '/teacher_classes_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocProvider(
        create: (context) => TeacherClassesCubit(
          TeacherClassesRepo(ApiService()),
        )..fetchClasses(),
        child: const ClassesViewBody(),
      ),
    );
  }
}
