import 'package:flutter/material.dart' hide Step;
import 'package:usapyon/logic/pyon_player.dart';
import 'package:usapyon/step/step.dart';
import 'package:usapyon/step/tick_driven.dart';


class RockStep extends Step implements TickDriven {
  Duration? startAnimation;
  bool removed = false;
  double brokenRate = 0.0;
  Duration? startBroken;
  RockStep(super.hCell, super.vCell, super.stageId);

  @override
  void onCollision(PyonPlayer player, Duration elapsed) {
    removed = true;
    super.onCollision(player, elapsed);
  }

  @override
  Widget place(
      double cellWidthPx, double cellHeightPx, double displayOffsetPx) {
    return Positioned(
      left: hCell * cellWidthPx,
      top: vCell * cellHeightPx - cellHeightPx + displayOffsetPx,
      child: Opacity(
        opacity: 1 - brokenRate,
        child: Image.asset(
          brokenRate == 0 ? "assets/rock.jpg" : "assets/rock_broken.png",
          width: cellWidthPx * 5,
          height: cellHeightPx
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