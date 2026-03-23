import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class HomeworkDetailsInstructions extends StatelessWidget {
  const HomeworkDetailsInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list_alt, color: AppColors.primaryColor, size: 20),
            const SizedBox(width: 8),
            Text(
              'Instructions',
              style: AppTextStyle.bold16.copyWith(color: AppColors.black),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildInstructionItem(
                1,
                'Choose one primary civilization to focus your research on (Mesopotamia, Egypt, or Indus Valley).',
              ),
              const SizedBox(height: 16),
              _buildInstructionItem(
                2,
                'Identify at least three major architectural achievements and their significance.',
              ),
              const SizedBox(height: 16),
              _buildInstructionItem(
                3,
                'Draft a 1000-word essay following the MLA citation guidelines provided in the reference files.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionItem(int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.regular14.copyWith(
              color: AppColors.grey,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
