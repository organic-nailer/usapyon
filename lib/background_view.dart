import 'package:flutter/material.dart';

class BackgroundView extends StatelessWidget {
  final double width, height, centerCell;
  BackgroundView(
      {super.key,
      required this.width,
      required this.height,
      required this.centerCell});

  Widget? backgroundImage;
  Widget? backgroundImage2;

  @override
  Widget build(BuildContext context) {
    backgroundImage ??= Container(
      width: width,
      height: height * 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomLeft,
          colors: [
            const Color(0xffe4a972).withOpacity(0.6),
            const Color(0xff9941d8).withOpacity(0.6),
          ],
          stops: const [
            0.0,
            1.0,
          ],
        ),
      ),
    );
    return Stack(
      children: [
        Positioned(
          left: 0,
          // height*1.5 >= centerCell * 5 >= -height*2.5
          bottom: (centerCell * 5 + height * 2.5) % (height * 4) - height * 2.5,
          child: backgroundImage!,
        ),
        Positioned(
          left: 0,
          // height*1.5 >= centerCell * 5 >= -height*2.5
          bottom: (centerCell * 5 + height * 2.5 + height * 2) % (height * 4) -
              height * 2.5,
          child: backgroundImage!,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: centerCell * 5,
          child: Offstage(
            offstage: centerCell <= -50,
            child: Image.asset("assets/hiyoshi_sanctuary.png"),
          ),
        )
      ],
    );
  }
}
