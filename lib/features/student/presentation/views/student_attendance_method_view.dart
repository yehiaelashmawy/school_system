import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_attendance_method_card.dart';

class StudentAttendanceMethodView extends StatelessWidget {
  static const String routeName = 'student_attendance_method_view';

  final String subject;

  const StudentAttendanceMethodView({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Choose Attendance Method',
          style: AppTextStyle.bold16.copyWith(
            color: AppColors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CURRENT SESSION',
                style: AppTextStyle.bold12.copyWith(
                  color: AppColors.grey,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subject,
                style: AppTextStyle.bold24.copyWith(
                  color: AppColors.black,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Section 201',
                      style: AppTextStyle.bold12.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: AppColors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Today, 10:30 AM',
                        style: AppTextStyle.medium12.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Scan QR Code Card
              StudentAttendanceMethodCard(
                iconWidget: const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 28,
                ),
                iconBackgroundColor: AppColors.secondaryColor,
                title: 'Scan QR Code',
                description:
                    'Instantly check-in by scanning the digital code displayed in class.',
                actionText: 'Open Camera',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'student_scan_qr_view',
                    arguments: subject,
                  );
                },
              ),

              const SizedBox(height: 20),

              // Choose Code Card
              StudentAttendanceMethodCard(
                iconWidget: Text(
                  '123',
                  style: AppTextStyle.bold16.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                iconBackgroundColor: AppColors.secondaryColor,
                iconContainerColor: AppColors.lightGrey.withValues(alpha: 0.3),
                title: 'Choose Code',
                description:
                    'Enter the unique 6-digit session pin provided by your instructor.',
                actionText: 'Enter Manually',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'student_select_code_view',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
