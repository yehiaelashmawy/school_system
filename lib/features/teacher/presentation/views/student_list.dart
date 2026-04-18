import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/exams_list_body.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_list_body.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/lessons_list_body.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/students_list_body.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/take_attendance_card.dart';
import 'package:school_system/features/teacher/presentation/views/attendance_report_view.dart';
import 'package:school_system/features/teacher/presentation/views/attendance_method_view.dart';

class StudentList extends StatefulWidget {
  final String className;
  const StudentList({super.key, this.className = 'Grade 10-A - Mathematics'});
  static const String routeName = '/student_list';

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  static const int _examsTabIndex = 3;

  bool get _isExamsTab => _tabController.index == _examsTabIndex;

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
              widget.className,
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
          const StudentsListBody(),
          const LessonsListBody(),
          const HomeworkListBody(),
          const ExamsListBody(),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            children: [
              TakeAttendanceCard(
                imagePath: 'assets/images/lesson1.png',
                statusText: 'NEXT SESSION: 09:00 AM',
                statusColor: AppColors.primaryColor,
                grade: 'Grade 10-A',
                subject: 'Mathematics',
                studentsCount: 24,
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
