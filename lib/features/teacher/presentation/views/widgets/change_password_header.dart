import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:svg_flutter/svg.dart';

class ChangePasswordHeader extends StatelessWidget {
  const ChangePasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: SvgPicture.asset('assets/images/reset_password.svg')),

        const SizedBox(height: 24),

        Text(
          'Secure Your Account',
          style: AppTextStyle.bold16.copyWith(
            color: AppColors.darkBlue,
            fontSize: 22,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Please enter your current password and choose a strong new one to protect your teacher profile.',
          style: AppTextStyle.regular14.copyWith(
            color: AppColors.grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
