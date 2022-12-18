import 'package:flutter/material.dart' hide Step;
import 'package:usapyon/step/step.dart';
import 'package:usapyon/step/tick_driven.dart';

class MoveStep extends Step implements TickDriven {
  Duration? startAnimation;
  double shiftCell = 0;
  Curve curve = Curves.easeInOutSine;
  final int maxShiftCell = 6;
  MoveStep(super.hCell, super.vCell, super.stageId);

  @override
  Widget place(
      double cellWidthPx, double cellHeightPx, double displayOffsetPx) {
    return Positioned(
      left: (hCell + shiftCell) * cellWidthPx,
      top: vCell * cellHeightPx - cellHeightPx + displayOffsetPx,
      child: Image.asset(
        "assets/move.png",
        width: cellWidthPx * 5,
        height: cellHeightPx,
        color: Colors.blue.shade900
      ),
    );
  }

  @override
  bool isEnabled() => true;

  @override
  void onTick(Duration elapsed) {
    if (startAnimation == null) {
      startAnimation = elapsed;
      return;
    }
    // 0.0 ~ 2.0
    var phase = ((elapsed - startAnimation!).inMilliseconds % 4000) / 2000;
    if (phase > 1.0) {
      phase = 2 - phase;
    }
    shiftCell = curve.transform(phase) * maxShiftCell;
  }
  
  @override
  bool checkHorizontalCollision(double playerPositionCell) {
    return hCell + shiftCell < playerPositionCell + 1.5 &&
              playerPositionCell - 1.5 < hCell + shiftCell + 5;
  }
}
