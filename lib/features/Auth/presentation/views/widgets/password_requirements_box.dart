import 'package:school_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/utils/size_config.dart';

class PasswordRequirementModel {
  final String text;
  final bool isValid;

  const PasswordRequirementModel({required this.text, required this.isValid});
}

class PasswordRequirementsBox extends StatelessWidget {
  const PasswordRequirementsBox({super.key, required this.requirements});

  final List<PasswordRequirementModel> requirements;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Column(
        children: requirements.asMap().entries.map((entry) {
          int idx = entry.key;
          PasswordRequirementModel req = entry.value;
          return Column(
            children: [
              RequirementItem(text: req.text, isValid: req.isValid),
              if (idx < requirements.length - 1) const SizedBox(height: 12),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class RequirementItem extends StatelessWidget {
  const RequirementItem({super.key, required this.text, required this.isValid});

  final String text;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle_outline : Icons.circle_outlined,
          size: 18,
          color: isValid ? const Color(0xFF22C55E) : AppColors.lightGrey,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.medium18.copyWith(
              fontSize: SizeConfig.getResponsiveFontSize(context, fontSize: 14),
              color: isValid
                  ? AppColors.grey
                  : AppColors.lightGrey,
            ),
          ),
        ),
      ],
    );
  }
}
