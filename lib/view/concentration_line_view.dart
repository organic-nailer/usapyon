import 'dart:math';

import 'package:flutter/material.dart';

class ConcentrationLineView extends StatelessWidget {
  final int split;
  final Color color;
  const ConcentrationLineView({super.key, required this.split, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConcentrationPainter(split, color),
    );
  }
}

class ConcentrationPainter extends CustomPainter {
  final int split;
  final Color color;
  ConcentrationPainter(this.split, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width/2, size.height/2);
    final double radius = center.distance * 2;
    final int splitNum = split;
    final double anglePerLineRad = 2 * pi / splitNum;
    
    final paint = Paint()..color = color;
    
    canvas.clipRect(Offset.zero & size);
    
    for (int i = 0; i < splitNum; i += 2) {
      final path = Path();
      path.moveTo(center.dx, center.dy);
      path.lineTo(
        cos(anglePerLineRad * i) * radius + center.dx,
        sin(anglePerLineRad * i) * radius + center.dy
      );
      path.lineTo(
        cos(anglePerLineRad * (i+1)) * radius + center.dx,
        sin(anglePerLineRad * (i+1)) * radius + center.dy
      );
      path.close();
      // canvas.drawPath(path, paint);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}