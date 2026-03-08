import 'package:flutter/material.dart';
import 'package:school_system/features/Auth/presentation/views/widgets/verification_view_body.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});
  static const routeName = 'verificationView';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: VerificationViewBody());
  }
}
