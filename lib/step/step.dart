import 'package:flutter/material.dart';
import 'package:usapyon/pyon_player.dart';

class Step {
  final int hCell;
  final int vCell;
  final int stageId;
  const Step(this.hCell, this.vCell, this.stageId);

  void onTrample(PyonPlayer player, Duration elapsed) {
    player.startTrample(elapsed);
  }

  Widget place(
          double cellWidthPx, double cellHeightPx, double displayOffsetPx) =>
      throw UnimplementedError();
  
  bool isEnabled() => throw UnimplementedError();

  bool checkCollision(PyonPlayer player) {
    return vCell - 1 < player.verticalPositionCell 
      && vCell + 0.5 > player.verticalPositionCell
      && checkHorizontalCollision(player.horizontalPositionCell) 
      && player.verticalVelocityCell > 10;
  }

  bool checkHorizontalCollision(double playerPositionCell) {
    return hCell < playerPositionCell + 1.5 &&
              playerPositionCell - 1.5 < hCell + 5;
  }
}