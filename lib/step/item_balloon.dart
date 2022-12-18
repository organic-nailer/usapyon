import 'package:flutter/material.dart' hide Step;
import 'package:usapyon/step/item_floating.dart';
import 'package:usapyon/pyon_player.dart';

class ItemBalloon extends ItemFloating {
  const ItemBalloon(super.hCell, super.vCell, super.stageId);

  @override
  void onTrample(PyonPlayer player, Duration elapsed) {
    player.startFloating(elapsed, 3000);
  }

  @override
  Widget place(double cellWidthPx, double cellHeightPx, double displayOffsetPx) {
    return Positioned(
      left: hCell * cellWidthPx,
      top: (vCell - 3) * cellHeightPx + displayOffsetPx,
      child: Image.asset(
        "assets/balloon.png",
        width: cellWidthPx * 2,
        height: cellHeightPx * 3
      ),
    );
  }
}