import 'package:flutter/material.dart';
import 'package:school_system/features/student/presentation/views/widgets/student_home_view_body.dart';

class StudentHomeView extends StatelessWidget {
  const StudentHomeView({super.key});
  static const String routeName = 'student_home_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: StudentHomeViewBody());
  }
}
