import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/widgets/custom_snack_bar.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';
import 'package:school_system/features/teacher/presentation/manager/start_attendance_cubit/start_attendance_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/start_attendance_cubit/start_attendance_state.dart';
import 'package:school_system/features/teacher/presentation/views/generate_qr_code_view.dart';
import 'package:school_system/features/teacher/presentation/views/manual_attendance_view.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/attendance_lesson_selector.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/attendance_method_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AttendanceMethodViewBody extends StatefulWidget {
  final TeacherClassModel teacherClass;
  final String? lessonId;

  const AttendanceMethodViewBody({
    super.key,
    required this.teacherClass,
    this.lessonId,
  });

  @override
  State<AttendanceMethodViewBody> createState() =>
      _AttendanceMethodViewBodyState();
}

class _AttendanceMethodViewBodyState extends State<AttendanceMethodViewBody> {
  String? _selectedLessonOid;

  @override
  void initState() {
    super.initState();
    _selectedLessonOid = widget.lessonId;
    // If no lessonId passed, and we have lessons, select the first one by default
    final lessons = _classLessons;
    if (_selectedLessonOid == null && lessons.isNotEmpty) {
      _selectedLessonOid = lessons.first.oid;
    }
  }

  List<TeacherLessonModel> get _classLessons {
    final students = widget.teacherClass.students;
    final map = <String, TeacherLessonModel>{};
    for (final student in students) {
      for (final lesson in student.details.lessons) {
        final key = lesson.oid.isNotEmpty
            ? lesson.oid
            : '${lesson.title}-${lesson.date}';
        map.putIfAbsent(key, () => lesson);
      }
    }
    final lessons = map.values.where((lesson) {
      final status = lesson.status.toLowerCase();
      return status != 'expired' && status != 'completed';
    }).toList();
    // Sort by date descending
    lessons.sort((a, b) {
      final da = DateTime.tryParse(a.date);
      final db = DateTime.tryParse(b.date);
      if (da == null || db == null) return 0;
      return db.compareTo(da);
    });
    return lessons;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StartAttendanceCubit, StartAttendanceState>(
      listener: (context, state) {
        if (state is StartAttendanceSuccess) {
          if (state.session.method == 2) {
            // QR Code
            Navigator.pushNamed(
              context,
              GenerateQrCodeView.routeName,
              arguments: state.session,
            );
          } else {
            // Default to Manual (method 1)
            Navigator.pushNamed(
              context,
              ManualAttendanceView.routeName,
              arguments: ManualAttendanceViewArgs(
                teacherClass: widget.teacherClass,
                session: state.session,
              ),
            );
          }
        } else if (state is StartAttendanceFailure) {
          CustomSnackBar.showError(context, state.failure.errorMessage);
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is StartAttendanceLoading,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            children: [
              AttendanceLessonSelector(
                lessons: _classLessons,
                selectedLessonOid: _selectedLessonOid,
                onLessonSelected: (oid) {
                  setState(() {
                    _selectedLessonOid = oid;
                  });
                },
              ),
              const SizedBox(height: 32),
              Text(
                'SESSION MANAGEMENT',
                style: AppTextStyle.bold12.copyWith(
                  color: AppColors.grey,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Take Attendance',
                style: AppTextStyle.bold18.copyWith(color: AppColors.black),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: AppTextStyle.medium14.copyWith(
                    color: AppColors.grey,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'Select a preferred method to verify student presence for ',
                    ),
                    TextSpan(
                      text:
                          '${widget.teacherClass.name} - ${widget.teacherClass.level}',
                      style: AppTextStyle.medium14.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AttendanceMethodCard(
                icon: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xffDDE4FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.edit_calendar,
                    color: Color(0xff065AD8),
                  ),
                ),
                title: 'Manual Attendance',
                subtitle:
                    'Personally mark students present or absent from the class roster.',
                actionText: 'SELECT METHOD',
                onTap: () {
                  if (_selectedLessonOid == null) {
                    CustomSnackBar.showError(
                      context,
                      'Please select a lesson first',
                    );
                    return;
                  }
                  context.read<StartAttendanceCubit>().startSession(
                        classOid: widget.teacherClass.oid,
                        method: 1, // Manual
                        lessonOid: _selectedLessonOid,
                      );
                },
              ),
              AttendanceMethodCard(
                icon: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.qr_code, color: Colors.white),
                ),
                title: 'Generate QR Code',
                subtitle:
                    'Display a dynamic code on the screen for students to scan with their devices.',
                actionText: 'QUICK LAUNCH',
                actionIcon: Icons.bolt,
                isPrimary: true,
                onTap: () {
                  if (_selectedLessonOid == null) {
                    CustomSnackBar.showError(
                      context,
                      'Please select a lesson first',
                    );
                    return;
                  }
                  context.read<StartAttendanceCubit>().startSession(
                        classOid: widget.teacherClass.oid,
                        method: 2, // QR Code
                        lessonOid: _selectedLessonOid,
                      );
                },
              ),
              AttendanceMethodCard(
                icon: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.peach,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.pin, color: Color(0xff78350F)),
                ),
                title: 'Generate Code',
                subtitle:
                    'Create a unique 6-digit numeric key for students to enter manually.',
                actionText: 'SELECT METHOD',
                onTap: () {
                  Navigator.pushNamed(context, '/entry_code_view');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
