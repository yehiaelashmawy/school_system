import 'package:flutter/material.dart';
import 'package:school_system/features/parent/presentation/views/widgets/parent_home_view_body.dart';

class ParentHomeView extends StatelessWidget {
  const ParentHomeView({super.key});
  static const String routeName = 'parent_home_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ParentHomeViewBody());
  }
}
