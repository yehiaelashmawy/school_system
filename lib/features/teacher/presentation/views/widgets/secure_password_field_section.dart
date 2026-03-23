import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_text_field.dart';

class SecurePasswordFieldSection extends StatelessWidget {
  const SecurePasswordFieldSection({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
    required this.validator,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.semiBold14.copyWith(
            color: const Color(0xff475569), // Slate 600
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          obscureText: obscureText,
          validator: validator,
          suffixIcon: IconButton(
            icon: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: const Color(0xff94A3B8),
              size: 20,
            ),
            onPressed: onToggleVisibility,
            splashRadius: 20,
          ),
        ),
      ],
    );
  }
}
