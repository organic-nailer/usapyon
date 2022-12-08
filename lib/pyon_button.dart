import 'package:flutter/material.dart';

class PyonButton extends StatefulWidget {
  const PyonButton({super.key});

  @override
  State<StatefulWidget> createState() => _PyonButtonState();
}

class _PyonButtonState extends State<PyonButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const BeveledRectangleBorder(
              side: BorderSide(color: Color(0x0052B6A5), width: 0),
              borderRadius: BorderRadius.all(Radius.elliptical(10, 20))),
          backgroundColor: const Color(0xFF41DFCE),
        ).copyWith(elevation: ButtonStyleButton.allOrNull(0)),
        child: Text(
          "スタート",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
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
