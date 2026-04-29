import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:school_system/features/student/data/models/student_my_subjects_model.dart';
import 'package:school_system/features/student/presentation/views/student_assignment_details_view.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_assignment_item_card.dart';
import 'package:school_system/features/student/presentation/views/widgets/subject_empty_state.dart';

class SubjectHomeworksTab extends StatelessWidget {
  final List<StudentMyHomework> homeworks;
  final String subjectName;
  final bool isLoading;

  const SubjectHomeworksTab({
    super.key,
    required this.homeworks,
    required this.subjectName,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Skeletonizer(
        enabled: true,
        child: Column(
          children: List.generate(
            2,
            (_) => StudentAssignmentItemCard(
              status: AssignmentStatus.notSubmitted,
              title: 'Loading Assignment Title',
              submittedDate: 'Loading Date',
              isDueSoon: false,
              onViewDetails: () {},
            ),
          ),
        ),
      );
    }

    if (homeworks.isEmpty) {
      return const SubjectEmptyState(
        icon: Icons.assignment_outlined,
        message: 'No assignments for this subject yet.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: homeworks.map((hw) => _buildCard(context, hw)).toList(),
    );
  }

  Widget _buildCard(BuildContext context, StudentMyHomework hw) {
    AssignmentStatus status = AssignmentStatus.notSubmitted;
    if (hw.myGrade != null || hw.status.toLowerCase() == 'graded') {
      status = AssignmentStatus.graded;
    }

    final dateStr = hw.dueDate != null
        ? DateFormat('MMM dd, yyyy').format(hw.dueDate!)
        : '';
    final dueTime = hw.dueDate != null
        ? DateFormat('hh:mm a').format(hw.dueDate!)
        : '';
    final dateDay =
        hw.dueDate != null ? DateFormat('dd').format(hw.dueDate!) : '';
    final dateMonth = hw.dueDate != null
        ? DateFormat('MMM').format(hw.dueDate!).toUpperCase()
        : '';

    void navigateToDetails() {
      Navigator.pushNamed(
        context,
        StudentAssignmentDetailsView.routeName,
        arguments: StudentAssignmentDetailsArgs(
          subjectName: subjectName.toUpperCase(),
          title: hw.title,
          dueTime: dueTime,
          points: hw.totalMarks.toString(),
          dateDay: dateDay,
          dateMonth: dateMonth,
          description: '',
          teacherName: '',
          teacherInstructions: '',
        ),
      );
    }

    return StudentAssignmentItemCard(
      status: status,
      title: hw.title,
      submittedDate: hw.isOverdue
          ? 'Late (Due $dateStr)'
          : (dateStr.isNotEmpty ? 'Due $dateStr' : 'No due date'),
      isDueSoon: hw.isOverdue,
      grade: hw.myGrade?.toString(),
      totalGrade: hw.totalMarks.toString(),
      feedback: hw.feedback,
      onViewDetails: navigateToDetails,
      onSubmitWork: navigateToDetails,
    );
  }
}
