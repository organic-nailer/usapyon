import 'package:flutter/material.dart' hide Step;
import 'package:usapyon/pyon_player.dart';
import 'package:usapyon/step/step.dart';
import 'package:usapyon/step/tick_driven.dart';


class RockStep extends Step implements TickDriven {
  bool removed = false;
  double brokenRate = 0.0;
  Duration? startBroken;
  RockStep(super.hCell, super.vCell, super.stageId);

  @override
  void onTrample(PyonPlayer player, Duration elapsed) {
    removed = true;
    super.onTrample(player, elapsed);
  }

  @override
  Widget place(
      double cellWidthPx, double cellHeightPx, double displayOffsetPx) {
    return Positioned(
      left: hCell * cellWidthPx,
      top: vCell * cellHeightPx - cellHeightPx + displayOffsetPx,
      child: Container(
        width: cellWidthPx * 5,
        height: cellHeightPx,
        child: Text("($stageId:$hCell,$vCell)"),
        decoration: BoxDecoration(
          color: removed ? Colors.transparent : Colors.blueGrey,
          border: Border.all(
            color: Colors.red.withOpacity(brokenRate),
            width: 2,
          )
        ),
      ),
    );
  }

  @override
  bool isEnabled() => !removed;

  @override
  void onTick(Duration elapsed) {
    if (startBroken != null) {
      brokenRate = (elapsed - startBroken!).inMilliseconds / 500;
      if (brokenRate >= 1.0) {
        brokenRate = 1.0;
        startBroken = null;
      }
    } 
    else if(removed && brokenRate < 1.0) {
      startBroken = elapsed;
    }
  }
}