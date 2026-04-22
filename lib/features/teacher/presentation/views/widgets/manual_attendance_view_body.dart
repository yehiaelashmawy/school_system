import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/attendance_stats_row.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/student_attendance_card.dart';

class StudentData {
  final String name;
  final String subtitle;
  final String imagePath;
  final bool hasHonorRoll;
  AttendanceStatus status;

  StudentData({
    required this.name,
    required this.subtitle,
    required this.imagePath,
    this.hasHonorRoll = false,
    this.status = AttendanceStatus.none,
  });
}

class ManualAttendanceViewBody extends StatefulWidget {
  final TeacherClassModel teacherClass;

  const ManualAttendanceViewBody({super.key, required this.teacherClass});

  @override
  State<ManualAttendanceViewBody> createState() =>
      _ManualAttendanceViewBodyState();
}

class _ManualAttendanceViewBodyState extends State<ManualAttendanceViewBody> {
  late final List<StudentData> students;

  @override
  void initState() {
    super.initState();
    students = widget.teacherClass.students.asMap().entries.map((entry) {
      final index = entry.key;
      final s = entry.value;
      return StudentData(
        name: s.fullName,
        subtitle: 'Roll No. ${(index + 1).toString().padLeft(3, '0')}',
        imagePath: s.avatar,
      );
    }).toList();
  }

  int get enrolledCount => students.length;
  int get absentCount =>
      students.where((s) => s.status == AttendanceStatus.absent).length;

  @override
  Widget build(BuildContext context) {
    final teacherClass = widget.teacherClass;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      children: [
        Text(
          '${teacherClass.level.toUpperCase()} • ${teacherClass.name.toUpperCase()}',
          style: AppTextStyle.bold12.copyWith(
            color: AppColors.grey,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Attendance Check',
          style: AppTextStyle.bold24.copyWith(
            color: AppColors.black,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${teacherClass.studentsCount} Students Enrolled',
          style: AppTextStyle.medium14.copyWith(color: AppColors.grey),
        ),
        const SizedBox(height: 24),
        AttendanceStatsRow(
          enrolledCount: enrolledCount,
          absentCount: absentCount,
        ),
        const SizedBox(height: 24),
        ...List.generate(students.length, (index) {
          final student = students[index];
          return StudentAttendanceCard(
            name: student.name,
            subtitle: student.subtitle,
            imagePath: student.imagePath,
            hasHonorRoll: student.hasHonorRoll,
            status: student.status,
            onStatusChanged: (newStatus) {
              setState(() {
                student.status = newStatus;
              });
            },
          );
        }),
      ],
    );
  }
}
