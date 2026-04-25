import 'package:flutter/material.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_text_field.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/field_label.dart';

class ExamGradingSection extends StatelessWidget {
  final TextEditingController totalMarksController;
  final TextEditingController passingMarksController;

  const ExamGradingSection({
    super.key,
    required this.totalMarksController,
    required this.passingMarksController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FieldLabel(label: 'Total Marks'),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: '100',
                controller: totalMarksController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FieldLabel(label: 'Passing Marks'),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: '33',
                controller: passingMarksController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
