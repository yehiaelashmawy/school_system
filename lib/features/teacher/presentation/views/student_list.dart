import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/exams_list_body.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_list_body.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/lessons_list_body.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/students_list_body.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/take_attendance_card.dart';
import 'package:school_system/features/teacher/presentation/views/attendance_report_view.dart';
import 'package:school_system/features/teacher/presentation/views/attendance_method_view.dart';

class StudentList extends StatefulWidget {
  final String className;
  final TeacherClassModel? teacherClass;
  const StudentList({
    super.key,
    this.className = 'Grade 10-A - Mathematics',
    this.teacherClass,
  });
  static const String routeName = '/student_list';

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  static const int _examsTabIndex = 3;

  bool get _isExamsTab => _tabController.index == _examsTabIndex;

  List<TeacherLessonModel> get _classLessons {
    final students = widget.teacherClass?.students ?? const <TeacherStudentModel>[];
    final map = <String, TeacherLessonModel>{};
    for (final student in students) {
      for (final lesson in student.details.lessons) {
        final key = lesson.oid.isNotEmpty
            ? lesson.oid
            : '${lesson.title}-${lesson.date}';
        map.putIfAbsent(key, () => lesson);
      }
    }
    final lessons = map.values.toList();
    lessons.sort((a, b) {
      final aDate = DateTime.tryParse(a.date);
      final bDate = DateTime.tryParse(b.date);
      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return 1;
      if (bDate == null) return -1;
      return bDate.compareTo(aDate);
    });
    return lessons;
  }

  List<TeacherHomeworkModel> get _classHomeworks {
    final students = widget.teacherClass?.students ?? const <TeacherStudentModel>[];
    final map = <String, TeacherHomeworkModel>{};
    for (final student in students) {
      for (final homework in student.details.homeworks) {
        final key = homework.oid.isNotEmpty
            ? homework.oid
            : '${homework.title}-${homework.dueDate}';
        map.putIfAbsent(key, () => homework);
      }
    }
    final homeworks = map.values.toList();
    homeworks.sort((a, b) {
      final aDate = DateTime.tryParse(a.dueDate);
      final bDate = DateTime.tryParse(b.dueDate);
      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return 1;
      if (bDate == null) return -1;
      return aDate.compareTo(bDate);
    });
    return homeworks;
  }

  List<TeacherExamModel> get _classExams {
    final students = widget.teacherClass?.students ?? const <TeacherStudentModel>[];
    final map = <String, TeacherExamModel>{};
    for (final student in students) {
      for (final exam in student.details.exams) {
        final key = exam.oid.isNotEmpty ? exam.oid : '${exam.name}-${exam.date}';
        map.putIfAbsent(key, () => exam);
      }
    }
    final exams = map.values.toList();
    exams.sort((a, b) {
      final aDate = DateTime.tryParse(a.date);
      final bDate = DateTime.tryParse(b.date);
      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return 1;
      if (bDate == null) return -1;
      return aDate.compareTo(bDate);
    });
    return exams;
  }

  TeacherAttendanceModel get _classAttendance {
    final students = widget.teacherClass?.students ?? const <TeacherStudentModel>[];
    int present = 0;
    int absent = 0;
    int late = 0;
    double percentSum = 0;
    int percentCount = 0;

    for (final student in students) {
      final attendance = student.details.attendance;
      present += attendance.presentCount;
      absent += attendance.absentCount;
      late += attendance.lateCount;
      percentSum += attendance.attendancePercentage;
      percentCount += 1;
    }

    final avgPercent = percentCount == 0 ? 0.0 : (percentSum / percentCount).toDouble();
    return TeacherAttendanceModel(
      presentCount: present,
      absentCount: absent,
      lateCount: late,
      attendancePercentage: avgPercent,
    );
  }

  Color get _attendanceStatusColor {
    final pct = _classAttendance.attendancePercentage;
    if (pct >= 80) return AppColors.secondaryColor;
    if (pct >= 60) return AppColors.primaryColor;
    return Colors.red;
  }

  String get _attendanceStatusText {
    return 'AVG ATTENDANCE: ${_classAttendance.attendancePercentage.toStringAsFixed(1)}%';
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.teacherClass?.name ?? widget.className,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Academic Year 2023/24',
              style: TextStyle(color: AppColors.grey, fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.black),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.grey,
          indicatorColor: AppColors.primaryColor,
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          indicatorWeight: 3,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(text: 'Students'),
            Tab(text: 'Lessons'),
            Tab(text: 'Homework'),
            Tab(text: 'Exams'),
            Tab(text: 'Attendance'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StudentsListBody(students: widget.teacherClass?.students ?? const []),
          LessonsListBody(lessons: _classLessons),
          HomeworkListBody(homeworks: _classHomeworks),
          ExamsListBody(exams: _classExams),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            children: [
              TakeAttendanceCard(
                imagePath: 'assets/images/lesson1.png',
                statusText: _attendanceStatusText,
                statusColor: _attendanceStatusColor,
                grade: widget.teacherClass?.name ?? widget.className,
                subject:
                    'Present: ${_classAttendance.presentCount} • Absent: ${_classAttendance.absentCount} • Late: ${_classAttendance.lateCount}',
                studentsCount: widget.teacherClass?.studentsCount ?? 0,
                onViewReports: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed(AttendanceReportView.routeName);
                },
                onTakeAttendance: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed(AttendanceMethodView.routeName);
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: AnimatedScale(
        scale: _isExamsTab ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: FloatingActionButton(
          onPressed: _isExamsTab
              ? () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed('/add_new_exam');
                }
              : null,
          backgroundColor: AppColors.secondaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
