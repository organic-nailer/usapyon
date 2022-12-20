import 'package:flutter/material.dart';
import 'package:usapyon/logic/pyon_player.dart';

import 'package:usapyon/step/rigid_body.dart';

abstract class StageComponent implements RigidBody {
  final int hCell, vCell, stageId;
  const StageComponent(this.hCell,this.vCell,this.stageId);

  Widget place(double cellWidthPx, double cellHeightPx, double displayOffsetPx);

  bool checkPlayerCollision(PyonPlayer player);
}
