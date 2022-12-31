import 'package:flutter/material.dart';

class PyonButton extends StatefulWidget {
  final String text;
  final double height;
  final VoidCallback? onPressed;
  const PyonButton({super.key, required this.text, required this.height, this.onPressed});

  @override
  State<StatefulWidget> createState() => _PyonButtonState();
}

class _PyonButtonState extends State<PyonButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          shape: const BeveledRectangleBorder(
              side: BorderSide(color: Color(0x0052B6A5), width: 0),
              borderRadius: BorderRadius.all(Radius.elliptical(10, 20))),
          backgroundColor: const Color(0xFF41DFCE),
        ).copyWith(elevation: ButtonStyleButton.allOrNull(0)),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.height * 0.7,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = const Color(0xFFEFFDCE),
          ),
        ),
      ),
    );
  }
}
