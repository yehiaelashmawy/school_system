import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/widgets/custom_app_bar.dart';
import 'package:school_system/core/widgets/custom_button.dart';
import 'package:school_system/core/widgets/custom_text_field.dart';
import 'package:school_system/features/Auth/presentation/views/widgets/custom_back_to_login.dart';
import 'package:school_system/features/Auth/presentation/views/widgets/custom_buttom_logo.dart';
import 'package:svg_flutter/svg.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(title: 'Forgot Password'),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFE2E8F0),
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/images/reset_password.svg'),
                      const SizedBox(height: 56),
                      Text(
                        'Reset your password',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bold24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your email or phone number to receive a reset link',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.regular16,
                      ),
                      const SizedBox(height: 32),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email or Phone',
                          style: AppTextStyle.semiBold16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const CustomTextField(hintText: 'name@email.com'),
                      const SizedBox(height: 24),
                      const CustomButton(text: 'Send Reset Code'),
                      const SizedBox(height: 28),
                      CustomBackToLogin(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),
              CustomButtomLogo(),
              const SizedBox(height: 8),
              Text(
                'Professional Learning Platform',
                style: AppTextStyle.regular14,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
