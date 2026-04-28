import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class ParentHomeHeader extends StatelessWidget {
  final String userName;
  final String profileImageUrl;

  const ParentHomeHeader({
    super.key,
    required this.userName,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(profileImageUrl),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: AppTextStyle.regular12.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                userName,
                style: AppTextStyle.bold16.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
