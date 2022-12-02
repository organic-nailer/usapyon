import 'package:flutter/material.dart' hide Step;
import 'package:usapyon/step/step.dart';

class WoodStep extends Step {
  const WoodStep(super.hCell, super.vCell, super.stageId);

  @override
  Widget place(
      double cellWidthPx, double cellHeightPx, double displayOffsetPx) {
    return Positioned(
      left: hCell * cellWidthPx,
      top: vCell * cellHeightPx - cellHeightPx + displayOffsetPx,
      child: Container(
        width: cellWidthPx * 5,
        height: cellHeightPx,
        color: Colors.yellow,
        child: Text("($stageId:$hCell,$vCell)"),
      ),
    );
  }

  @override
  bool isEnabled() => true;
}