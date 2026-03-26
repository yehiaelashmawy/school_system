import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;

  const NotificationModel({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
  });
}
