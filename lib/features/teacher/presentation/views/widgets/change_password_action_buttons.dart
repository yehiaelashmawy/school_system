import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class ChangePasswordActionButtons extends StatelessWidget {
  const ChangePasswordActionButtons({
    super.key,
    required this.onUpdatePassword,
  });

  final VoidCallback onUpdatePassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onUpdatePassword,
            icon: const Icon(Icons.key, color: Colors.white, size: 20),
            label: const Text(
              'Update Password',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
          ),
        ),

        const SizedBox(height: 24),

        Center(
          child: RichText(
            text: TextSpan(
              text: 'Forgot your password? ',
              style: AppTextStyle.regular14.copyWith(
                color: const Color(0xff94A3B8), // slate 400
                fontSize: 13,
              ),
              children: [
                TextSpan(
                  text: 'Contact Support',
                  style: AppTextStyle.semiBold14.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 13,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle contact support
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
