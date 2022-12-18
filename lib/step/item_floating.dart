import 'package:usapyon/logic/pyon_player.dart';
import 'package:usapyon/step/step.dart';

class ItemFloating extends Step {
  const ItemFloating(super.hCell, super.vCell, super.stageId);

  @override
  bool isEnabled() => true;

  @override
  bool checkCollision(PyonPlayer player) {
    return vCell - 3 < player.verticalPositionCell
      && vCell > player.verticalPositionCell - 6
      && checkHorizontalCollision(player.horizontalPositionCell);
  }

  @override
  bool checkHorizontalCollision(double playerPositionCell) {
    return hCell < playerPositionCell + 1.5 &&
    playerPositionCell - 1.5 < hCell + 2;
  }
}
