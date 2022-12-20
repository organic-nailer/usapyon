import 'package:flutter/material.dart';
import 'package:usapyon/logic/pyon_player.dart';
import 'package:usapyon/step/rigid_body.dart';
import 'package:usapyon/step/stage_component.dart';

/// 足場
///
///# 配置
///
///★の位置が座標
///
///```
///┌───┐
///│　　　│
///│　　　│
///★───┘
///```
abstract class Step extends StageComponent {
  const Step(super.hCell, super.vCell, super.stageId);

  // RigidBody
  @override
  void onCollision(PyonPlayer player, Duration elapsed) {
    player.startTrample(elapsed);
  }

  @override
  Rect get shellRectCell => Rect.fromLTWH(hCell.toDouble(), vCell - 1, 5, 1);
  @override
  Rect get shellFootRectCell => throw UnimplementedError();

  bool isEnabled() => true;

  @override
  bool checkPlayerCollision(PyonPlayer player) {
    return player.verticalVelocityCell > 10 &&
        RigidBody.checkFootCollision(this, player);
  }
}
