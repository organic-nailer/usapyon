import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundView extends StatelessWidget {
  final double width, height, centerCell;
  BackgroundView(
      {super.key,
      required this.width,
      required this.height,
      required this.centerCell}) {
    if (createdWidth != width.toInt() || createdHeight != height.toInt()) {
      backgroundImage = null;
    }
  }

  static Widget? backgroundImage;
  static int? createdWidth;
  static int? createdHeight;

  @override
  Widget build(BuildContext context) {
    if (backgroundImage == null) {
      backgroundImage = Container(
        width: width,
        height: height * 2,
        color: Colors.lightBlue,
        child: Stack(
          children: List.generate(10, (_) {
            final r = Random();
            final cloudWidth = width / 5;
            final x = r.nextInt((width * 0.8).toInt());
            final y = r.nextInt((height * 2 - width).toInt());
            return Positioned(
              left: x.toDouble(), top: y.toDouble(),
              child: Image.asset("assets/google_cloud.png", width: cloudWidth,),
            );
          })
        ),
      );
      createdWidth = width.toInt();
      createdHeight = height.toInt();
    }
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
