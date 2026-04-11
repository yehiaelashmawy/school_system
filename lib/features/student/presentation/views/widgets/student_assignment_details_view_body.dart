import 'package:flutter/material.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_assignment_attached_materials.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_assignment_details_description.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_assignment_details_header.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_assignment_submission_box.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_assignment_teacher_instructions.dart';

class StudentAssignmentDetailsViewBody extends StatelessWidget {
  final String subjectName;
  final String title;
  final String dueTime;
  final String points;
  final String dateDay;
  final String dateMonth;
  final String description;
  final String teacherName;
  final String teacherInstructions;

  const StudentAssignmentDetailsViewBody({
    super.key,
    required this.subjectName,
    required this.title,
    required this.dueTime,
    required this.points,
    required this.dateDay,
    required this.dateMonth,
    required this.description,
    required this.teacherName,
    required this.teacherInstructions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        StudentAssignmentDetailsHeader(
          subjectName: subjectName,
          title: title,
          dueTime: dueTime,
          points: points,
          dateDay: dateDay,
          dateMonth: dateMonth,
        ),
        const SizedBox(height: 32),
        StudentAssignmentDetailsDescription(description: description),
        const SizedBox(height: 24),
        StudentAssignmentTeacherInstructions(
          teacherName: teacherName,
          teacherInstructions: teacherInstructions,
        ),
        const SizedBox(height: 32),
        const StudentAssignmentAttachedMaterials(),
        const SizedBox(height: 24),
        const StudentAssignmentSubmissionBox(),
        const SizedBox(height: 32),
      ],
    );
  }
}
