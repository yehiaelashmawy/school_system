import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/utils/size_config.dart';
import 'package:svg_flutter/svg.dart';

class CustomButtomLogo extends StatelessWidget {
  const CustomButtomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/images/blue_logo.svg'),
        const SizedBox(width: 8),
        Text(
          'EduSmart',
          style: AppTextStyle.bold24.copyWith(
            fontSize: SizeConfig.getResponsiveFontSize(context, fontSize: 24),
          ),
        ),
      ],
    );
  }
}
