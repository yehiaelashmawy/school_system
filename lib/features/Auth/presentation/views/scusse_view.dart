import 'package:flutter/material.dart';
import 'package:school_system/features/Auth/presentation/views/widgets/scusse_view_body.dart';

class ScusseView extends StatelessWidget {
  const ScusseView({super.key});
  static const String routeName = 'ScusseView';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ScusseViewBody());
  }
}
