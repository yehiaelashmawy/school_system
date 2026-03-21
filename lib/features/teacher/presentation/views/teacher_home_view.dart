import 'package:flutter/material.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/teacher_home_view_body.dart';

class TeacherHomeView extends StatelessWidget {
  const TeacherHomeView({super.key});
  static const String routeName = 'teacher_home_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: TeacherHomeViewBody());
  }
}
