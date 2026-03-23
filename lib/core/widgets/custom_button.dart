import 'package:school_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.shadows,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final List<BoxShadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: ShapeDecoration(
          color: backgroundColor ?? const Color(0xFF0F52BD),
          shape: RoundedRectangleBorder(
            side: borderColor != null
                ? BorderSide(width: 1, color: borderColor!)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(24),
          ),
          shadows: shadows,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? AppColors.white,
              fontSize: 16,

              fontWeight: borderColor != null
                  ? FontWeight.w500
                  : FontWeight.w700,
              height: 1.50,
            ),
          ),
        ),
      ),
    );
  }
}
