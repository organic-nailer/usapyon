import 'package:flutter/material.dart';
import 'package:usapyon/logic/pyon_player.dart';
import 'package:usapyon/step/rigid_body.dart';
import 'package:usapyon/step/stage_component.dart';

///足場の上にあるアイテム
///# 配置
///
///★の位置が座標
///
///```
///　┌───┐
///　│　　　│
///　│　　　│
///★┴───┘
///```
abstract class ItemOnStep extends StageComponent {
  const ItemOnStep(super.hCell, super.vCell, super.stageId);

  @override
  Rect get shellFootRectCell => throw UnimplementedError();

  @override
  bool checkPlayerCollision(PyonPlayer player) {
    return player.verticalVelocityCell > 10 &&
        RigidBody.checkFootCollision(this, player);
  }
}
