import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.showArrow = true,
  });

  final VoidCallback onPressed;
  final String text;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTextStyle.bold18.copyWith(color: AppColors.white),
            ),
            if (showArrow) ...[
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: AppColors.white, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}
