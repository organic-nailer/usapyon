


import 'package:flutter/material.dart';
import 'package:usapyon/logic/pyon_player.dart';

abstract class RigidBody {
  /// 外殻
  abstract final Rect shellRectCell;
  abstract final Rect shellFootRectCell;

  void onCollision(PyonPlayer player, Duration elapsed);

  static bool checkCollision(RigidBody a, RigidBody b) {
    return a.shellRectCell.overlaps(b.shellRectCell);
  }

  static bool checkFootCollision(RigidBody base, RigidBody above) {
    return base.shellRectCell.overlaps(above.shellFootRectCell);
  }
}
