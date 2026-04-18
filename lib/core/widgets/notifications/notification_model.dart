import 'package:flutter/material.dart';

class NotificationModel {
  final String oid;
  final String title;
  final String message;
  final String type;
  final String priority;
  final bool isRead;
  final String? sentAt;
  final String? actionUrl;
  final String iconStr;
  final String colorHex;
  final String timeAgo;

  const NotificationModel({
    required this.oid,
    required this.title,
    required this.message,
    required this.type,
    required this.priority,
    required this.isRead,
    this.sentAt,
    this.actionUrl,
    required this.iconStr,
    required this.colorHex,
    required this.timeAgo,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      oid: json['oid'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      priority: json['priority'] ?? '',
      isRead: json['isRead'] ?? false,
      sentAt: json['sentAt'],
      actionUrl: json['actionUrl'],
      iconStr: json['icon'] ?? '',
      colorHex: json['color'] ?? '#3D7EE3', // default color
      timeAgo: json['timeAgo'] ?? '',
    );
  }

  // Helpers for UI
  Color get iconColor {
    String hex = colorHex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    try {
      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return const Color(0xff3D7EE3); // fallback
    }
  }

  Color get iconBackgroundColor {
    return iconColor.withValues(alpha: 0.15); // soft background
  }

  IconData get iconData {
    if (iconStr.contains('exclamation-triangle') || type == 'Warning') {
      return Icons.warning_amber_rounded;
    } else if (iconStr.contains('user-plus')) {
      return Icons.person_add_alt_1_outlined;
    } else if (iconStr.contains('calendar')) {
      return Icons.calendar_today_outlined;
    } else if (iconStr.contains('star')) {
      return Icons.star_border;
    } else if (iconStr.contains('assignment')) {
      return Icons.assignment_turned_in_outlined;
    }
    return Icons.notifications_none_outlined; // Default fallback
  }
}
