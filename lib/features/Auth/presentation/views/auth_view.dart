import 'package:flutter/material.dart';
import 'package:school_system/features/Auth/presentation/views/widgets/auth_view_body.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});
  static const routeName = 'authView';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF6F7F8),
      body: AuthViewBody(),
    );
  }
}
