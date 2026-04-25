import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_text_field.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/field_label.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_classes_cubit/teacher_classes_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_classes_cubit/teacher_classes_state.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_subjects_cubit/teacher_subjects_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_subjects_cubit/teacher_subjects_state.dart';

class ExamDetailsSection extends StatefulWidget {
  final TextEditingController titleController;
  final ValueChanged<String?> onSubjectChanged;
  final ValueChanged<String?> onClassChanged;
  final ValueChanged<String?> onTypeChanged;

  const ExamDetailsSection({
    super.key,
    required this.titleController,
    required this.onSubjectChanged,
    required this.onClassChanged,
    required this.onTypeChanged,
  });

  @override
  State<ExamDetailsSection> createState() => _ExamDetailsSectionState();
}

class _ExamDetailsSectionState extends State<ExamDetailsSection> {
  String? _selectedSubject;
  String? _selectedClass;
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(label: 'Exam Title'),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: 'e.g., Mid-term Mathematics',
          controller: widget.titleController,
        ),
        const SizedBox(height: 16),
        const FieldLabel(label: 'Exam Type'),
        const SizedBox(height: 8),
        CustomDropdownField(
          hintText: 'Choose exam type',
          items: const ['Quiz', 'Midterm', 'Final', 'Practical'],
          value: _selectedType,
          onChanged: (val) {
            setState(() {
              _selectedType = val;
            });
            widget.onTypeChanged(val);
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldLabel(label: 'Subject'),
                  const SizedBox(height: 8),
                  BlocBuilder<TeacherSubjectsCubit, TeacherSubjectsState>(
                    builder: (context, subjectState) {
                      if (subjectState is TeacherSubjectsLoading) {
                        return Skeletonizer(
                          enabled: true,
                          child: CustomDropdownField(
                            hintText: 'Choose a subject',
                            items: const ['Mathematics'],
                            value: 'Mathematics',
                            onChanged: (_) {},
                          ),
                        );
                      } else if (subjectState is TeacherSubjectsFailure) {
                        return Text(
                          subjectState.error.errorMessage,
                          style: const TextStyle(color: Colors.red),
                        );
                      } else if (subjectState is TeacherSubjectsSuccess) {
                        final subjectNames = subjectState.subjects
                            .map((e) => e.name)
                            .toList();

                        if (_selectedSubject != null &&
                            !subjectNames.contains(_selectedSubject)) {
                          _selectedSubject = null;
                        }

                        return CustomDropdownField(
                          hintText: 'Choose a subject',
                          items: subjectNames,
                          value: _selectedSubject,
                          onChanged: (val) {
                            setState(() {
                              _selectedSubject = val;
                            });
                            final subject = subjectState.subjects.firstWhere(
                              (e) => e.name == val,
                            );
                            widget.onSubjectChanged(subject.oid);
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
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
                  BlocBuilder<TeacherClassesCubit, TeacherClassesState>(
                    builder: (context, classState) {
                      if (classState is TeacherClassesLoading) {
                        return Skeletonizer(
                          enabled: true,
                          child: CustomDropdownField(
                            hintText: 'Choose a class',
                            items: const ['Grade 10 - A'],
                            value: 'Grade 10 - A',
                            onChanged: (_) {},
                          ),
                        );
                      } else if (classState is TeacherClassesFailure) {
                        return Text(
                          classState.error.errorMessage,
                          style: const TextStyle(color: Colors.red),
                        );
                      } else if (classState is TeacherClassesSuccess) {
                        final classNames = classState.classes
                            .map((e) => e.name)
                            .toList();

                        if (_selectedClass != null &&
                            !classNames.contains(_selectedClass)) {
                          _selectedClass = null;
                        }

                        return CustomDropdownField(
                          hintText: 'Choose a class',
                          items: classNames,
                          value: _selectedClass,
                          onChanged: (val) {
                            setState(() {
                              _selectedClass = val;
                            });
                            final classModel = classState.classes.firstWhere(
                              (e) => e.name == val,
                            );
                            widget.onClassChanged(classModel.oid);
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
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
