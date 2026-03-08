import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/widgets/custom_app_bar.dart';
import 'package:school_system/core/widgets/custom_button.dart';
import 'package:school_system/core/widgets/custom_text_field.dart';
import 'package:school_system/features/Auth/presentation/views/scusse_view.dart';
import 'package:school_system/features/Auth/presentation/views/widgets/custom_back_to_login.dart';
import 'package:school_system/features/Auth/presentation/views/widgets/password_requirements_box.dart';
import 'package:svg_flutter/svg.dart';

class ResetPasswordViewBody extends StatelessWidget {
  const ResetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    const CustomAppBar(title: 'Reset Password'),
                    const Divider(thickness: 0, color: AppColors.lightGrey),
                    const SizedBox(height: 24),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFE0E7FF),
                        shape: CircleBorder(),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/reset_password.svg',
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Create New Password',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bold24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your new password must be different from previously used passwords to keep your account secure.',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'New Password',
                        style: AppTextStyle.semiBold14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const CustomTextField(
                      hintText: 'Enter new password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Confirm New Password',
                        style: AppTextStyle.semiBold14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const CustomTextField(
                      hintText: 'Re-enter new password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    const PasswordRequirementsBox(
                      requirements: [
                        PasswordRequirementModel(
                          text: 'At least 8 characters long',
                          isValid: true,
                        ),
                        PasswordRequirementModel(
                          text: 'Must include a symbol or number',
                          isValid: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    CustomButton(
                      text: 'Reset Password',
                      onPressed: () {
                        Navigator.pushNamed(context, ScusseView.routeName);
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Remember your password? ',
                          style: AppTextStyle.regular14.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        const CustomBackToLogin(showArrow: false),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
