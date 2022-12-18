import 'package:flutter/material.dart' hide Step;
import 'package:usapyon/step/item_on_step.dart';
import 'package:usapyon/logic/pyon_player.dart';

class ItemSpringRed extends ItemOnStep {
  const ItemSpringRed(super.hCell, super.vCell, super.stageId);

  @override
  void onTrample(PyonPlayer player, Duration elapsed) {
    player.startShooting(elapsed, 1000);
  }

  @override
  Widget place(double cellWidthPx, double cellHeightPx, double displayOffsetPx) {
    return Positioned(
      left: (hCell + 1) * cellWidthPx,
      top: (vCell - 3) * cellHeightPx + displayOffsetPx,
      child: Image.asset(
        "assets/spring_red.png",
        width: cellWidthPx * 3,
        height: cellHeightPx * 2,
        color: Colors.red
      ),
    );
  }
}