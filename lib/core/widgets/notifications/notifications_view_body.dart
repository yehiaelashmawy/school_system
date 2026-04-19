import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/widgets/notifications/manager/notifications_cubit.dart';
import 'package:school_system/core/widgets/notifications/manager/notifications_state.dart';
import 'package:school_system/core/widgets/notifications/notification_model.dart';
import 'notification_item.dart';
import 'package:school_system/core/utils/theme_manager.dart';

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
          dividerColor: ThemeManager.isDarkMode
              ? AppColors.lightGrey
              : const Color(0xffE2E8F0),
          tabs: const [
            Tab(text: 'Alerts'),
            Tab(text: 'Announcements'),
          ],
        ),
        const Expanded(
          child: TabBarView(
            children: [
              NotificationsListTab(isAlerts: true),
              NotificationsListTab(isAlerts: false),
            ],
          ),
        ),
      ],
    );
  }
}

class NotificationsListTab extends StatelessWidget {
  final bool isAlerts;

  const NotificationsListTab({super.key, required this.isAlerts});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if (state is NotificationsLoading) {
          final skeletonNotifications = List.generate(
            6,
            (index) => NotificationModel(
              oid: 'skeleton-$index',
              title: 'Class Update Notification',
              message: 'A new class activity has been assigned for this week.',
              type: isAlerts ? 'Warning' : 'Info',
              priority: 'Medium',
              isRead: false,
              iconStr: 'calendar',
              colorHex: '#3D7EE3',
              timeAgo: '1h ago',
            ),
          );
          return Skeletonizer(
            enabled: true,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  itemCount: skeletonNotifications.length,
                  itemBuilder: (context, index) {
                    return NotificationItem(
                      notification: skeletonNotifications[index],
                    );
                  },
                ),
              ),
            ),
          );
        } else if (state is NotificationsFailure) {
          return Center(
            child: Text(
              state.errMessage,
              style: AppTextStyle.bold16.copyWith(color: Colors.red),
            ),
          );
        } else if (state is NotificationsSuccess) {
          final filteredList = state.notifications.where((n) {
            return isAlerts ? n.type != 'Info' : n.type == 'Info';
          }).toList();

          if (filteredList.isEmpty) {
            return Center(
              child: Text(
                'No new notifications',
                style: AppTextStyle.semiBold16.copyWith(color: AppColors.grey),
              ),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return NotificationItem(notification: filteredList[index]);
                },
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
