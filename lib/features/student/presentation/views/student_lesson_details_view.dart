import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/student/data/repos/student_lessons_repo.dart';
import 'package:school_system/features/student/presentation/manager/student_lesson_detail_cubit/student_lesson_detail_cubit.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_lesson_details_view_body.dart';

class StudentLessonDetailsView extends StatelessWidget {
  static const String routeName = 'student_lesson_details_view';
  final String lessonId;

  const StudentLessonDetailsView({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          StudentLessonDetailCubit(StudentLessonsRepo(ApiService()))
            ..fetchLesson(lessonId),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Lesson Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const StudentLessonDetailsViewBody(),
      ),
    );
  }
}
