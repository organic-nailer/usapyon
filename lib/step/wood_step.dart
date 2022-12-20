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
      child: Image.asset("assets/wood.jpg",
          width: cellWidthPx * 5, height: cellHeightPx),
    );
  }
}
