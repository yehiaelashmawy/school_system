import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/parent/presentation/views/widgets/child_card.dart';
import 'package:school_system/features/parent/presentation/views/widgets/parent_home_header.dart';
import 'package:school_system/features/parent/presentation/views/widgets/quick_action_card.dart';
import 'package:school_system/features/parent/presentation/views/widgets/recent_activity_item.dart';
import 'package:school_system/features/parent/presentation/views/widgets/upcoming_event_card.dart';

class ParentHomeViewBody extends StatelessWidget {
  const ParentHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ParentHomeHeader(
                userName: 'Sarah Johnson',
                profileImageUrl: 'assets/images/profile_photo.png',
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Academic Curator',
                      style: AppTextStyle.bold30.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Monitor your children\'s academic progress',
                      style: AppTextStyle.medium14.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    QuickActionCard(
                      title: 'Contact Teacher',
                      icon: Icons.chat_bubble_outline,
                      backgroundColor: AppColors.secondaryColor,
                      contentColor: Colors.white,
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    QuickActionCard(
                      title: 'Payments',
                      icon: Icons.payments_outlined,
                      backgroundColor: Colors.white,
                      contentColor: AppColors.darkBlue,
                      onTap: () {},
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Children'),
                    const SizedBox(height: 16),
                    const ChildCard(name: 'Leo Johnson', grade: 'Grade 10-A'),
                    const ChildCard(name: 'Mia Johnson', grade: 'Grade 6-C'),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Recent Activity'),
                    const SizedBox(height: 16),
                    RecentActivityItem(
                      title: 'Homework Submitted',
                      description: 'Monitor your children\'s academic progress',
                      time: '2 hours ago',
                      icon: Icons.check_circle_outline,
                      iconBgColor: const Color(0xFFDBEAFE),
                      iconColor: const Color(0xFF2563EB),
                    ),
                    RecentActivityItem(
                      title: 'New Announcement',
                      description: 'Monitor your children\'s academic progress',
                      time: 'Yesterday',
                      icon: Icons.campaign_outlined,
                      iconBgColor: const Color(0xFFFFEDD5),
                      iconColor: const Color(0xFFEA580C),
                    ),
                    RecentActivityItem(
                      title: 'Message from Teacher',
                      description: 'Monitor your children\'s academic progress',
                      time: 'Oct 18',
                      icon: Icons.chat_bubble_outline,
                      iconBgColor: const Color(0xFFF3E8FF),
                      iconColor: const Color(0xFF9333EA),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Upcoming Events'),
                    const SizedBox(height: 16),
                    const UpcomingEventCard(
                      month: 'OCT',
                      day: '25',
                      title: 'Math Exam',
                      details: 'Grade 10 - Room 402',
                    ),
                    const UpcomingEventCard(
                      month: 'NOV',
                      day: '02',
                      title: 'Parent-Teacher Meeting',
                      details: 'Virtual • 4:00 PM',
                      dateBgColor: Color(0xFFFFE4E6),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.bold20.copyWith(color: AppColors.darkBlue),
    );
  }
}
