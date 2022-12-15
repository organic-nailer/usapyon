import 'package:flutter/material.dart';

class StrokedText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color strokeColor;
  final Color innerColor;
  const StrokedText({super.key, required this.text, this.fontSize, required this.strokeColor, required this.innerColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: innerColor,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = strokeColor,
          ),
        )
      ],
    );
  }
}
