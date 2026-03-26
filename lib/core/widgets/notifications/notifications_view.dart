import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/widgets/custom_app_bar.dart';
import 'notifications_view_body.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});
  static const String routeName = 'notifications_view';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: const [
              CustomAppBar(title: 'Notifications', showBackButton: false),
              SizedBox(height: 16),
              Expanded(child: NotificationsViewBody()),
            ],
          ),
        ),
      ),
    );
  }
}
