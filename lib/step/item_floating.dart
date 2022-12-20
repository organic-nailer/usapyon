import 'dart:ui';

import 'package:usapyon/logic/pyon_player.dart';
import 'package:usapyon/step/rigid_body.dart';
import 'package:usapyon/step/stage_component.dart';
import 'package:usapyon/step/step.dart';

abstract class ItemFloating extends StageComponent {
  const ItemFloating(super.hCell, super.vCell, super.stageId);

  @override
  Rect get shellFootRectCell => throw UnimplementedError();


  @override
  bool checkPlayerCollision(PyonPlayer player) {
    return RigidBody.checkCollision(this, player);
  }
}
