import 'package:flutter/material.dart';

import 'package:school_system/core/utils/theme_manager.dart';

abstract class AppColors {
  static Color get primaryColor => const Color(0xff3D7EE3);
  static Color get secondaryColor => const Color(0xff0F52BD);
  static Color get backgroundColor => ThemeManager.isDarkMode
      ? const Color(0xff0F172A)
      : const Color(0xffF6F7F8);
  static Color get darkBlue =>
      ThemeManager.isDarkMode ? Colors.white : const Color(0xff06162D);
  static Color get grey => ThemeManager.isDarkMode
      ? const Color(0xff94A3B8)
      : const Color(0xff475569);
  static Color get lightGrey => ThemeManager.isDarkMode
      ? const Color(0xff334155)
      : const Color(0xffCBD5E1);
  static Color get peach => ThemeManager.isDarkMode
      ? const Color(0xff78350F)
      : const Color(0xffFCE7D4);

  static Color get white =>
      ThemeManager.isDarkMode ? const Color(0xff1E293B) : Colors.white;
  static Color get black =>
      ThemeManager.isDarkMode ? Colors.white : Colors.black;
}
