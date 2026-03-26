import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'notification_item.dart';
import 'notification_model.dart';
import 'package:school_system/core/utils/theme_manager.dart';
import 'package:school_system/core/utils/size_config.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.grey,
          labelStyle: AppTextStyle.bold16,
          unselectedLabelStyle: AppTextStyle.semiBold16,
          indicatorColor: AppColors.primaryColor,
          indicatorWeight: 3,
          dividerColor: ThemeManager.isDarkMode ? AppColors.lightGrey : const Color(0xffE2E8F0),
          tabs: const [
            Tab(text: 'Alerts'),
            Tab(text: 'Announcements'),
          ],
        ),
        const Expanded(
          child: TabBarView(
            children: [
              AlertsTab(),
              Center(child: Text('Announcements')),
            ],
          ),
        ),
      ],
    );
  }
}

class AlertsTab extends StatelessWidget {
  const AlertsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            Text(
              'TODAY',
              style: AppTextStyle.bold14.copyWith(
                color: AppColors.darkBlue,
                fontSize: SizeConfig.getResponsiveFontSize(context, fontSize: 14),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
        const NotificationItem(
          notification: NotificationModel(
            title: 'Exam Reminder: Math Midterm',
            subtitle: 'Scheduled for tomorrow at 9:00 AM for Grade 10-B.',
            timeAgo: '2H\nAGO',
            icon: Icons.calendar_today_outlined,
            iconColor: Color(0xff3D7EE3),
            iconBackgroundColor: Color(0xffE6F0FD),
          ),
        ),
        const NotificationItem(
          notification: NotificationModel(
            title: 'New Submissions',
            subtitle: '15 students from History 101 submitted their essays.',
            timeAgo: '4H AGO',
            icon: Icons.assignment_turned_in_outlined,
            iconColor: Color(0xff10B981),
            iconBackgroundColor: Color(0xffE7F8F2),
          ),
        ),
        const SizedBox(height: 16),
            Text(
              'YESTERDAY',
              style: AppTextStyle.bold14.copyWith(
                color: AppColors.darkBlue,
                fontSize: SizeConfig.getResponsiveFontSize(context, fontSize: 14),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
        const NotificationItem(
          notification: NotificationModel(
            title: 'System Maintenance',
            subtitle: 'Portal will be down for maintenance this Sunday from 2 AM to 4 AM.',
            timeAgo: '1D AGO',
            icon: Icons.update,
            iconColor: Color(0xffF59E0B),
            iconBackgroundColor: Color(0xffFEF3C7),
          ),
        ),
            const NotificationItem(
              notification: NotificationModel(
                title: 'Grades Finalized',
                subtitle: 'The grading period for Q3 has been officially closed.',
                timeAgo: '1D AGO',
                icon: Icons.star_border,
                iconColor: Color(0xff3D7EE3),
                iconBackgroundColor: Color(0xffE6F0FD),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
