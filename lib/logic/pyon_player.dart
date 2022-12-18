import 'dart:math';

import 'package:flutter/material.dart';
import 'package:usapyon/logic/player_state.dart';
import 'package:usapyon/step/tick_driven.dart';

class PyonPlayer implements TickDriven {
  static const double gravityCell = 150; // 33.3;
  static const String imgSmileCenterBalloon =
      "assets/rabbit_smile_center_balloon.png";
  static const String imgSmileCenter = "assets/rabbit_smile_center.png";
  static const String imgSmileClose = "assets/rabbit_smile_close.png";
  static const String imgSmileOpenBalloon =
      "assets/rabbit_smile_open_balloon.png";
  static const String imgSmileOpen = "assets/rabbit_smile_open.png";
  static const String imgStraightCenterBalloon =
      "assets/rabbit_straight_center_balloon.png";
  static const String imgStraightCenter = "assets/rabbit_straight_center.png";
  static const String imgStraightClose = "assets/rabbit_straight_close.png";
  static const String imgStraightOpenBalloon =
      "assets/rabbit_straight_open_balloon.png";
  static const String imgStraightOpen = "assets/rabbit_straight_open.png";
  static const String imgTroubledClose = "assets/rabbit_troubled_close.png";
  double verticalPositionCell = 0;
  double horizontalPositionCell = 12;
  double verticalVelocityCell = -60;
  double horizontalVelocityCell = 0;

  PlayerState state = PlayerState.jumping;
  Duration? startTransition;
  int transitionMillisec = 0;
  String image = imgStraightClose;
  double rotationRad = 0;

  Widget place(double cellWidthPx, double cellHeightPx) {
    return Transform.rotate(
      angle: rotationRad,
      child:
          Image.asset(image, width: cellWidthPx * 3, height: cellHeightPx * 6),
    );
  }

  void startTrample(Duration start) {
    verticalVelocityCell = -60;
    startTransition = start;
    state = PlayerState.trample;
    image = imgStraightCenter;
    rotationRad = 0;
  }

  void startShooting(Duration start, int time) {
    verticalVelocityCell = -90;
    startTransition = start;
    transitionMillisec = time;
    state = PlayerState.shooting;
    image = imgSmileCenter;
    rotationRad = 0;
  }

  void startRotation(Duration start, int time) {
    verticalVelocityCell = -120;
    startTransition = start;
    transitionMillisec = time;
    state = PlayerState.rotation;
    rotationRad = 0;
  }

  void startFloating(Duration start, int time) {
    verticalVelocityCell = -60;
    startTransition = start;
    transitionMillisec = time;
    state = PlayerState.floating;
    image = imgSmileCenterBalloon;
    rotationRad = 0;
    updateHorizontalVelocity(horizontalVelocityCell);
  }

  void updateHorizontalVelocity(double newValue) {
    if (state == PlayerState.floating) {
      horizontalVelocityCell = newValue > 0 ? 20 : -20;
    } else {
      horizontalVelocityCell = newValue;
    }
  }

  void finish() {
    image = imgTroubledClose;
  }

  void _patapata(double phase, {bool rot = true, bool balloon = false}) {
    assert(phase >= 0.0 && phase <= 1.0);
    phase = phase <= 0.5 ? phase * 2 : (1 - phase) * 2;
    if (rot) {
      rotationRad = pi / 6 * phase - pi / 12;
    }

    final colorPhase = phase <= 0.5 ? phase * 2 : (1 - phase) * 2;
    if (colorPhase <= 0.4) {
      image = balloon ? imgSmileCenterBalloon : imgSmileCenter;
    } else if (colorPhase <= 0.8) {
      image = balloon ? imgSmileOpenBalloon : imgSmileOpen;
    } else {
      image = balloon ? imgSmileCenterBalloon : imgSmileCenter;
    }
  }

  void forward(Duration tickTime) {
    // 垂直位置の更新
    verticalPositionCell +=
        tickTime.inMilliseconds / 1000 * verticalVelocityCell;
    // 水平位置の更新
    horizontalPositionCell +=
        tickTime.inMilliseconds / 1000 * horizontalVelocityCell;
    if (horizontalPositionCell >= 25.5 && horizontalVelocityCell > 0) {
      horizontalPositionCell = -1.5;
    } else if (horizontalPositionCell <= -1.5 && horizontalPositionCell < 0) {
      horizontalPositionCell = 25.5;
    }

    // 垂直速度の更新
    if (state != PlayerState.shooting && state != PlayerState.floating) {
      verticalVelocityCell = min(
          verticalVelocityCell + tickTime.inMilliseconds / 1000 * gravityCell,
          60);
    }
  }

  @override
  void onTick(Duration elapsed) {
    if (startTransition != null) {
      if (state == PlayerState.trample) {
        final t = (elapsed - startTransition!).inMilliseconds;
        if (t < 100) {
          image = imgStraightCenter;
        } else if (t < 200) {
          image = imgStraightOpen;
        } else if (t < 300) {
          image = imgStraightCenter;
        } else {
          state = PlayerState.jumping;
          startTransition = null;
          image = imgStraightClose;
        }
      } else if (state == PlayerState.shooting) {
        final t = (elapsed - startTransition!).inMilliseconds;
        if (t < transitionMillisec) {
          _patapata((t % 500) / 500);
        } else {
          state = PlayerState.jumping;
          startTransition = null;
          image = imgStraightClose;
          rotationRad = 0;
        }
      } else if (state == PlayerState.rotation) {
        final t = (elapsed - startTransition!).inMilliseconds;
        if (t < transitionMillisec) {
          final phase = (t % transitionMillisec) / transitionMillisec;
          rotationRad = 2 * pi * phase;
        } else {
          state = PlayerState.jumping;
          startTransition = null;
          image = imgStraightClose;
          rotationRad = 0;
        }
      } else if (state == PlayerState.floating) {
        final t = (elapsed - startTransition!).inMilliseconds;
        if (t < transitionMillisec) {
          _patapata((t % 500) / 500, rot: false, balloon: true);
          if (horizontalVelocityCell > 0) {
            rotationRad = pi / 12;
          } else {
            rotationRad = -pi / 12;
          }
        } else {
          state = PlayerState.jumping;
          startTransition = null;
          image = imgStraightClose;
          rotationRad = 0;
        }
      }
    }
  }
}
