import 'package:flutter/material.dart' hide Step;
import 'package:usapyon/step/item_on_step.dart';
import 'package:usapyon/logic/pyon_player.dart';

class ItemSpringRed extends ItemOnStep {
  const ItemSpringRed(super.hCell, super.vCell, super.stageId);

  @override
  void onCollision(PyonPlayer player, Duration elapsed) {
    player.startShooting(elapsed, 1000);
  }

  @override
  Rect get shellRectCell => Rect.fromLTWH(hCell.toDouble() + 1, vCell - 2, 3, 2);

  @override
  Widget place(double cellWidthPx, double cellHeightPx, double displayOffsetPx) {
    return Positioned(
      left: (hCell + 1) * cellWidthPx,
      top: (vCell - 2) * cellHeightPx + displayOffsetPx,
      child: Image.asset(
        "assets/spring_red.png",
        width: cellWidthPx * 3,
        height: cellHeightPx * 2,
        color: Colors.red
      ),
    );
  }
}