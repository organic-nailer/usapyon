import 'package:flutter/material.dart' hide Step;
import 'package:usapyon/step/item_floating.dart';
import 'package:usapyon/logic/pyon_player.dart';

class ItemBalloon extends ItemFloating {
  const ItemBalloon(super.hCell, super.vCell, super.stageId);

  @override
  void onCollision(PyonPlayer player, Duration elapsed) {
    player.startFloating(elapsed, 3000);
  }

  @override
  Rect get shellRectCell => Rect.fromLTWH(hCell.toDouble(), vCell - 3, 2, 3);

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