import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_text_field.dart';

class ProfileFieldSection extends StatelessWidget {
  const ProfileFieldSection({
    super.key,
    required this.label,
    required this.controller,
    required this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final IconData suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.semiBold14.copyWith(
            color: const Color(0xff475569), // Slate 600
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          hintText: '',
          suffixIcon: Icon(
            suffixIcon,
            color: const Color(0xff94A3B8),
            size: 20,
          ),
        ),
      ],
    );
  }
}
