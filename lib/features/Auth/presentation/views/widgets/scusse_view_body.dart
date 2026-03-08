import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/widgets/custom_button.dart';
import 'package:school_system/features/Auth/presentation/views/login_view.dart';
import 'package:svg_flutter/svg.dart';

class ScusseViewBody extends StatelessWidget {
  const ScusseViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 132),
              Text(
                'Success',
                style: AppTextStyle.bold24.copyWith(color: AppColors.darkBlue),
              ),
              const SizedBox(height: 48),

              Container(
                width: 128,
                height: 128,
                decoration: const ShapeDecoration(
                  color: Color(0xFFE6F7EF),
                  shape: CircleBorder(),
                ),
                child: SvgPicture.asset('assets/images/success.svg'),
              ),
              const SizedBox(height: 50),
              Text(
                'Password Reset Successful!',
                textAlign: TextAlign.center,
                style: AppTextStyle.bold24.copyWith(color: AppColors.darkBlue),
              ),
              const SizedBox(height: 12),
              Text(
                'Your password has been updated. You can now log in with your new credentials.',
                textAlign: TextAlign.center,
                style: AppTextStyle.regular16.copyWith(color: AppColors.grey),
              ),
              const SizedBox(height: 50),
              CustomButton(
                text: 'Back to Login',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginView.routeName,
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
