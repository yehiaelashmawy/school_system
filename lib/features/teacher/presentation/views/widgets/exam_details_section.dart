import 'package:flutter/material.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_text_field.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/field_label.dart';

class ExamDetailsSection extends StatefulWidget {
  const ExamDetailsSection({super.key});

  @override
  State<ExamDetailsSection> createState() => _ExamDetailsSectionState();
}

class _ExamDetailsSectionState extends State<ExamDetailsSection> {
  String? _selectedSubject;
  String? _selectedClass;

  final List<String> _subjects = [
    'Mathematics',
    'Science',
    'Physics',
    'Chemistry',
    'English',
  ];

  final List<String> _classes = [
    'Grade 10 - A',
    'Grade 10 - B',
    'Grade 11 - A',
    'Grade 12 - A',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(label: 'Exam Title'),
        const SizedBox(height: 8),
        const CustomTextField(hintText: 'e.g., Mid-term Mathematics'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldLabel(label: 'Subject'),
                  const SizedBox(height: 8),
                  CustomDropdownField(
                    hintText: 'Mathematics',
                    items: _subjects,
                    value: _selectedSubject,
                    onChanged: (val) => setState(() => _selectedSubject = val),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldLabel(label: 'Class/Section'),
                  const SizedBox(height: 8),
                  CustomDropdownField(
                    hintText: 'Grade 10 - A',
                    items: _classes,
                    value: _selectedClass,
                    onChanged: (val) => setState(() => _selectedClass = val),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
