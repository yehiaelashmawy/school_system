import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_details_description.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_details_header.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_details_instructions.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_details_references.dart';

class HomeworkDetailsViewBody extends StatelessWidget {
  const HomeworkDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          HomeworkDetailsHeader(),
          SizedBox(height: 24),
          HomeworkDetailsDescription(),
          SizedBox(height: 24),
          HomeworkDetailsInstructions(),
          SizedBox(height: 24),
          HomeworkDetailsReferences(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
