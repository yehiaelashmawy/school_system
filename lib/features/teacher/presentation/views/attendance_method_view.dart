import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/attendance_method_view_body.dart';

class AttendanceMethodView extends StatelessWidget {
  static const String routeName = '/attendance_method_view';

  const AttendanceMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select Attendance Method',
          style: AppTextStyle.bold16.copyWith(
            color: AppColors.darkBlue,
            fontSize: 18,
          ),
        ),
      ),
      body: const AttendanceMethodViewBody(),
    );
  }
}
