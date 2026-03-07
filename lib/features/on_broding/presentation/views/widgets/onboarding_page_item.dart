import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/on_broding/presentation/views/widgets/onberding_page_model.dart';

class OnBoardingPageItem extends StatelessWidget {
  const OnBoardingPageItem({super.key, required this.pageModel});

  final OnBoardingPageModel pageModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.asset(pageModel.image, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          pageModel.title,
          textAlign: TextAlign.center,
          style: AppTextStyle.bold30.copyWith(color: AppColors.darkBlue),
        ),
        const SizedBox(height: 16),
        Text(
          pageModel.description,
          textAlign: TextAlign.center,
          style: AppTextStyle.regular18.copyWith(color: AppColors.grey),
        ),
      ],
    );
  }
}
