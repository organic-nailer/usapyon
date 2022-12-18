import 'package:usapyon/logic/pyon_player.dart';
import 'package:usapyon/step/step.dart';

class ItemOnStep extends Step {
  const ItemOnStep(super.hCell, super.vCell, super.stageId);

  @override
  bool isEnabled() => true;

  @override
  bool checkCollision(PyonPlayer player) {
    return vCell - 3 < player.verticalPositionCell 
      && vCell - 1 > player.verticalPositionCell
      && checkHorizontalCollision(player.horizontalPositionCell) 
      && player.verticalVelocityCell > 10;
  }

  @override
  bool checkHorizontalCollision(double playerPositionCell) {
    return hCell+1 < playerPositionCell + 1.5 &&
    playerPositionCell - 1.5 < hCell+1 + 3;
  }
}
