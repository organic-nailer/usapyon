import 'package:flutter/material.dart' hide Step;
import 'package:usapyon/step/item_on_step.dart';
import 'package:usapyon/logic/pyon_player.dart';

class ItemCarrot extends ItemOnStep {
  const ItemCarrot(super.hCell, super.vCell, super.stageId);

  @override
  void onTrample(PyonPlayer player, Duration elapsed) {
    player.startShooting(elapsed, 4000);
  }

  @override
  Widget place(double cellWidthPx, double cellHeightPx, double displayOffsetPx) {
    return Positioned(
      left: (hCell + 1) * cellWidthPx,
      top: (vCell - 4) * cellHeightPx + displayOffsetPx,
      child: Image.asset(
        "assets/carrot.png",
        width: cellWidthPx * 3,
        height: cellHeightPx * 3
      ),
    );
  }
}