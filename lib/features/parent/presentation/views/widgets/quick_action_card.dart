import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color contentColor;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.contentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: contentColor, size: 28),
            const SizedBox(width: 16),
            Text(
              title,
              style: AppTextStyle.bold16.copyWith(color: contentColor),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward, color: contentColor, size: 20),
          ],
        ),
      ),
    );
  }
}
