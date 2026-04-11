import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_lesson_material_card.dart';

class StudentAssignmentAttachedMaterials extends StatelessWidget {
  const StudentAssignmentAttachedMaterials({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attached Materials',
          style: AppTextStyle.bold16.copyWith(color: AppColors.darkBlue),
        ),
        const SizedBox(height: 16),
        StudentLessonMaterialCard(
          title: 'Calculus_Guide_v2.pdf',
          subtitle: '2.4 MB • PDF Document',
          leadingIcon: Icons.picture_as_pdf,
          leadingColor: const Color(0xffD92D20),
          leadingBackgroundColor: const Color(
            0xffD92D20,
          ).withValues(alpha: 0.1),
          onDownload: () {},
        ),
        StudentLessonMaterialCard(
          title: 'Gradient_Plot.png',
          subtitle: '840 KB • Image File',
          leadingIcon: Icons.image,
          leadingColor: AppColors.primaryColor,
          leadingBackgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
          onDownload: () {},
        ),
      ],
    );
  }
}
