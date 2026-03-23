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
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final List<BoxShadow>? shadows;
  final IconData? icon;

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: textColor ?? AppColors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
              ],
              Text(
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
            ],
          ),
        ),
      ),
    );
  }
}
