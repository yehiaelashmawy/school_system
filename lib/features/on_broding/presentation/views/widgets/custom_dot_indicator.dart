import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';

class CustomDotIndicator extends StatelessWidget {
  const CustomDotIndicator({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: isActive ? 32 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
