import 'package:flutter/material.dart';
import 'package:school_system/core/helper/on_generate_route.dart';
import 'package:school_system/features/splash/presentation/views/splash_view.dart';

import 'package:school_system/core/utils/theme_manager.dart';

void main() {
  runApp(const SchoolSystemApp());
}

class SchoolSystemApp extends StatelessWidget {
  const SchoolSystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeNotifier,
      builder: (_, themeMode, __) {
        return MaterialApp(
          key: ValueKey(themeMode),
          themeMode: themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          onGenerateRoute: onGenerateRoute,
          initialRoute: SplashView.routeName,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
