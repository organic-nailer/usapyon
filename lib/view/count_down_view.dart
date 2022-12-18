import 'dart:async';

import 'package:flutter/material.dart';

class CountDownController {
  int countDownNumber = 5;

  final List<VoidCallback> _callbacks = [];
  VoidCallback? _zeroCallback;

  void addCountCallback(VoidCallback callback) {
    _callbacks.add(callback);
  }

  void addZeroCallback(VoidCallback callback) {
    _zeroCallback = callback;
  }

  void dispose() {
    _callbacks.clear();
    _zeroCallback = null;
  }

  void start() {
    Timer.periodic(const Duration(seconds: 1), (t) {
      if (countDownNumber <= 1) {
        t.cancel();
        _zeroCallback?.call();
      } else {
        countDownNumber--;
      }
      for (var c in _callbacks) {
        c.call();
      }
    });
  }

  String getText() => countDownNumber.toString();
}

class CountDownView extends StatefulWidget {
  final CountDownController controller;
  final bool? visible;
  const CountDownView({super.key, required this.controller, this.visible});

  @override
  State<StatefulWidget> createState() => CountDownViewState();
}

class CountDownViewState extends State<CountDownView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool internalVisibility = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    widget.controller.addCountCallback(() {
      final c = widget.controller.countDownNumber;
      setState(() {
        internalVisibility = c <= 3 && c > 0;
      });
      if (internalVisibility) {
        _controller.forward(from: 0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: internalVisibility && (widget.visible ?? false),
      child: ScaleTransition(
        scale: _controller.drive(
          CurveTween(curve: Curves.easeIn),
        ),
        child: Text(
          widget.controller.getText(),
          style: const TextStyle(fontSize: 400),
        ),
      ),
    );
  }
}
