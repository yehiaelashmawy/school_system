import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';
import 'package:school_system/features/teacher/presentation/manager/homework_details_cubit/homework_details_cubit.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_details_description.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_details_header.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_details_instructions.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_details_references.dart';

class HomeworkDetailsViewBody extends StatelessWidget {
  const HomeworkDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeworkDetailsCubit, HomeworkDetailsState>(
      builder: (context, state) {
        if (state is HomeworkDetailsFailure) {
          return Center(
            child: Text(
              state.errorMessage,
              style: AppTextStyle.bold16.copyWith(color: Colors.red),
            ),
          );
        }

        final isLoading = state is HomeworkDetailsLoading || state is HomeworkDetailsInitial;
        final homework = state is HomeworkDetailsSuccess ? state.homework : null;

        final dummyHomework = const TeacherHomeworkModel(
          oid: '',
          title: 'Loading Homework Title...',
          dueDate: '2023-10-25T23:59:00',
          status: 'ACTIVE',
          submittedCount: 0,
          totalStudents: 0,
          description: 'Loading description...',
          instructions: 'Loading instructions...',
          materials: [],
        );

        final displayHomework = homework ?? dummyHomework;

        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            color: AppColors.backgroundColor,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (homework != null || isLoading) ...[
                  HomeworkDetailsHeader(homework: displayHomework),
                  const SizedBox(height: 24),
                  HomeworkDetailsDescription(description: displayHomework.description ?? ''),
                  const SizedBox(height: 24),
                  HomeworkDetailsInstructions(instructions: displayHomework.instructions ?? ''),
                  const SizedBox(height: 24),
                  HomeworkDetailsReferences(materials: displayHomework.materials ?? []),
                  const SizedBox(height: 32),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
