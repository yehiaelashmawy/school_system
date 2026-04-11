import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_assignment_details_view_body.dart';

class StudentAssignmentDetailsArgs {
  final String subjectName;
  final String title;
  final String dueTime;
  final String points;
  final String dateDay;
  final String dateMonth;
  final String description;
  final String teacherName;
  final String teacherInstructions;

  StudentAssignmentDetailsArgs({
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
}

class StudentAssignmentDetailsView extends StatelessWidget {
  static const String routeName = 'student_assignment_details_view';

  // Dynamic parameters for the view
  final String subjectName;
  final String title;
  final String dueTime;
  final String points;
  final String dateDay;
  final String dateMonth;
  final String description;
  final String teacherName;
  final String teacherInstructions;

  const StudentAssignmentDetailsView({
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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Assignment Details',
          style: AppTextStyle.bold16.copyWith(
            color: AppColors.black,
            fontSize: 18,
          ),
        ),
      ),
      body: StudentAssignmentDetailsViewBody(
        subjectName: subjectName,
        title: title,
        dueTime: dueTime,
        points: points,
        dateDay: dateDay,
        dateMonth: dateMonth,
        description: description,
        teacherName: teacherName,
        teacherInstructions: teacherInstructions,
      ),
    );
  }
}
