import 'package:flutter/material.dart';

class ConnectorsPainter extends CustomPainter {
  final int childCount;
  final Color color;

  ConnectorsPainter({required this.childCount, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (childCount == 0) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final centerX = size.width / 2;
    final top = 0.0;
    final midY = size.height * 0.35;
    final bottomY = size.height;

    canvas.drawLine(Offset(centerX, top), Offset(centerX, midY), paint);

    if (childCount > 1) {
      final firstChildX = size.width / (childCount * 2);
      final lastChildX = size.width - firstChildX;
      canvas.drawLine(
        Offset(firstChildX, midY),
        Offset(lastChildX, midY),
        paint,
      );
    }

    for (int i = 0; i < childCount; i++) {
      final childX = (i + 0.5) * size.width / childCount;
      canvas.drawLine(Offset(childX, midY), Offset(childX, bottomY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant ConnectorsPainter oldDelegate) {
    return oldDelegate.childCount != childCount || oldDelegate.color != color;
  }
}