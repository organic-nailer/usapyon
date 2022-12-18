import 'dart:math';

import 'package:usapyon/step/cloud_step.dart';
import 'package:usapyon/step/item_balloon.dart';
import 'package:usapyon/step/item_carrot.dart';
import 'package:usapyon/step/item_on_step.dart';
import 'package:usapyon/step/item_spring.dart';
import 'package:usapyon/step/item_spring_red.dart';
import 'package:usapyon/step/move_step.dart';
import 'package:usapyon/step/rock_step.dart';
import 'package:usapyon/step/step.dart';
import 'package:usapyon/step/wood_step.dart';

/// 横24、縦96マスのステージをランダムに生成
  /// 下にあるものが先になるようにしている
List<Step> generateRandomStage(int stageId) {
  print("Generate Stage $stageId");
  final items = <ItemOnStep>[];
  final result = List.generate(25, (index) {
    final r = Random();
    switch (r.nextInt(5)) {
      case 0:
        {
          final s =
              WoodStep(r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
          switch (r.nextInt(3)) {
            case 0:
              items.add(ItemCarrot(s.hCell, s.vCell, stageId));
              break;
            case 1:
              items.add(ItemSpring(s.hCell, s.vCell, stageId));
              break;
            case 2:
              items.add(ItemSpringRed(s.hCell, s.vCell, stageId));
              break;
          }
          return s;
        }
      case 1:
        return RockStep(
            r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
      case 2:
        return CloudStep(
            r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
      case 3:
        if (r.nextInt(10) == 1) {
          return ItemBalloon(
              r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
        }
        return MoveStep(
            r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
      default:
        return MoveStep(
            r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
    }
  });
  result.addAll(items);
  return result..sort((a, b) => b.vCell - a.vCell);
}