import 'package:flutter/material.dart';

class Step {
  final int hCell;
  final int vCell;
  final int stageId;
  const Step(this.hCell, this.vCell, this.stageId);

  void onTrample() {
    // print("ふまれたよ！");
  }

  Widget place(
          double cellWidthPx, double cellHeightPx, double displayOffsetPx) =>
      throw UnimplementedError();
  
  bool isEnabled() => throw UnimplementedError();

  bool checkHorizontalCollision(double playerPositionCell) {
    return hCell < playerPositionCell + 1.5 &&
              playerPositionCell - 1.5 < hCell + 5;
  }
}