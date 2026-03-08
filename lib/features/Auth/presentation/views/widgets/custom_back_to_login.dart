import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class CustomBackToLogin extends StatelessWidget {
  const CustomBackToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.arrow_back, size: 20, color: AppColors.primaryColor),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'Back to Login',
            style: AppTextStyle.semiBold14.copyWith(color: Color(0xFF0F52BD)),
          ),
        ),
      ],
    );
  }
}
