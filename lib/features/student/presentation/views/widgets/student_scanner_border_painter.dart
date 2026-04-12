import 'package:flutter/material.dart';

class StudentScannerBorderPainter extends CustomPainter {
  final Color color;

  StudentScannerBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final length = size.width * 0.15;
    final r = 16.0; // corner radius

    // Top Left
    final pathTL = Path()
      ..moveTo(0, length)
      ..lineTo(0, r)
      ..quadraticBezierTo(0, 0, r, 0)
      ..lineTo(length, 0);
    canvas.drawPath(pathTL, paint);

    // Top Right
    final pathTR = Path()
      ..moveTo(size.width - length, 0)
      ..lineTo(size.width - r, 0)
      ..quadraticBezierTo(size.width, 0, size.width, r)
      ..lineTo(size.width, length);
    canvas.drawPath(pathTR, paint);

    // Bottom Right
    final pathBR = Path()
      ..moveTo(size.width, size.height - length)
      ..lineTo(size.width, size.height - r)
      ..quadraticBezierTo(size.width, size.height, size.width - r, size.height)
      ..lineTo(size.width - length, size.height);
    canvas.drawPath(pathBR, paint);

    // Bottom Left
    final pathBL = Path()
      ..moveTo(length, size.height)
      ..lineTo(r, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - r)
      ..lineTo(0, size.height - length);
    canvas.drawPath(pathBL, paint);
  }

  @override
  bool shouldRepaint(covariant StudentScannerBorderPainter oldDelegate) => color != oldDelegate.color;
}
