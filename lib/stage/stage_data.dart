import 'dart:math';

import 'package:usapyon/page/stage_preview_page.dart';
import 'package:usapyon/step/cloud_step.dart';
import 'package:usapyon/step/item_balloon.dart';
import 'package:usapyon/step/item_carrot.dart';
import 'package:usapyon/step/item_spring.dart';
import 'package:usapyon/step/item_spring_red.dart';
import 'package:usapyon/step/move_step.dart';
import 'package:usapyon/step/rock_step.dart';
import 'package:usapyon/step/stage_component.dart';
import 'package:usapyon/step/wood_step.dart';

List<StageComponent> getPredefinedStage(int stageId) {
  if (stageId <= 1) return [];
  if (stageId == 2) return convertStage(stage0, stageId);

  final stageCreate = Random().nextInt(12);
  print("Get Stage $stageCreate (stageId:$stageId)");
  switch (stageCreate) {
    case 0:
      return convertStage(stage1, stageId);
    case 1:
      return convertStage(stage2, stageId);
    case 2:
      return convertStage(stage3, stageId);
    case 3:
      return convertStage(stage4, stageId);
    case 4:
      return convertStage(stage5, stageId);
    case 5:
      return convertStage(stage6, stageId);
    case 6:
      return convertStage(stage7, stageId);
    case 7:
      return convertStage(stage8, stageId);
    case 8:
      return convertStage(stage9, stageId);
    case 9:
      return convertStage(stage10, stageId);
    case 10:
      return convertStage(stage11, stageId);
    default:
      return convertStage(stage12, stageId);
  }
}

List<StageComponent> convertStage(List<PreviewStageData> preview, int stageId) {
  final vOffset = 96 + stageId * 96;
  final result = preview.map((item) {
    switch (item.item) {
      case PreviewStageItem.woodStep:
        return WoodStep(item.left, item.top + 1 - vOffset, stageId);
      case PreviewStageItem.cloudStep:
        return CloudStep(item.left, item.top + 1 - vOffset, stageId);
      case PreviewStageItem.rockStep:
        return RockStep(item.left, item.top + 1 - vOffset, stageId);
      case PreviewStageItem.moveStep:
        return MoveStep(item.left, item.top + 1 - vOffset, stageId);
      case PreviewStageItem.itemBalloon:
        return ItemBalloon(item.left, item.top + 3 - vOffset, stageId);
      case PreviewStageItem.itemCarrot:
        return ItemCarrot(item.left, item.top - vOffset, stageId);
      case PreviewStageItem.itemSpring:
        return ItemSpring(item.left, item.top - vOffset, stageId);
      case PreviewStageItem.itemSpringRed:
        return ItemSpringRed(item.left, item.top - vOffset, stageId);
    }
  }).toList();
  return result..sort((a, b) => b.vCell - a.vCell);
}

final List<PreviewStageData> stage0 = [
  const PreviewStageData(PreviewStageItem.moveStep, 1, 6),
  const PreviewStageData(PreviewStageItem.cloudStep, 3, 10),
  const PreviewStageData(PreviewStageItem.woodStep, 7, 3),
  const PreviewStageData(PreviewStageItem.woodStep, 7, 1),
  const PreviewStageData(PreviewStageItem.itemSpring, 7, 1),
  const PreviewStageData(PreviewStageItem.moveStep, 14, 8),
  const PreviewStageData(PreviewStageItem.cloudStep, 18, 18),
  const PreviewStageData(PreviewStageItem.woodStep, 19, 0),
  const PreviewStageData(PreviewStageItem.moveStep, 24, 12),
  const PreviewStageData(PreviewStageItem.rockStep, 27, 17),
  const PreviewStageData(PreviewStageItem.woodStep, 30, 1),
  const PreviewStageData(PreviewStageItem.woodStep, 33, 4),
  const PreviewStageData(PreviewStageItem.woodStep, 39, 3),
  const PreviewStageData(PreviewStageItem.woodStep, 45, 0),
  const PreviewStageData(PreviewStageItem.woodStep, 54, 3),
  const PreviewStageData(PreviewStageItem.rockStep, 59, 13),
  const PreviewStageData(PreviewStageItem.woodStep, 60, 11),
  const PreviewStageData(PreviewStageItem.moveStep, 62, 4),
  const PreviewStageData(PreviewStageItem.woodStep, 63, 9),
  const PreviewStageData(PreviewStageItem.cloudStep, 74, 18),
  const PreviewStageData(PreviewStageItem.woodStep, 75, 7),
  const PreviewStageData(PreviewStageItem.woodStep, 78, 8),
  const PreviewStageData(PreviewStageItem.woodStep, 79, 1),
  const PreviewStageData(PreviewStageItem.itemSpring, 79, 1),
  const PreviewStageData(PreviewStageItem.woodStep, 86, 16),
  const PreviewStageData(PreviewStageItem.moveStep, 92, 2),
  const PreviewStageData(PreviewStageItem.woodStep, 95, 9),
];

final List<PreviewStageData> stage1 = [
  const PreviewStageData(PreviewStageItem.woodStep, 2, 15),
  const PreviewStageData(PreviewStageItem.woodStep, 6, 10),
  const PreviewStageData(PreviewStageItem.moveStep, 19, 3),
  const PreviewStageData(PreviewStageItem.cloudStep, 22, 11),
  const PreviewStageData(PreviewStageItem.moveStep, 27, 10),
  const PreviewStageData(PreviewStageItem.cloudStep, 33, 19),
  const PreviewStageData(PreviewStageItem.rockStep, 40, 11),
  const PreviewStageData(PreviewStageItem.woodStep, 45, 12),
  const PreviewStageData(PreviewStageItem.itemCarrot, 45, 12),
  const PreviewStageData(PreviewStageItem.cloudStep, 48, 6),
  const PreviewStageData(PreviewStageItem.rockStep, 55, 13),
  const PreviewStageData(PreviewStageItem.rockStep, 57, 14),
  const PreviewStageData(PreviewStageItem.moveStep, 64, 12),
  const PreviewStageData(PreviewStageItem.moveStep, 73, 0),
  const PreviewStageData(PreviewStageItem.moveStep, 80, 18),
  const PreviewStageData(PreviewStageItem.moveStep, 84, 5),
  const PreviewStageData(PreviewStageItem.rockStep, 95, 17),
];

final List<PreviewStageData> stage2 = [
  const PreviewStageData(PreviewStageItem.woodStep, 3, 9),
  const PreviewStageData(PreviewStageItem.cloudStep, 4, 1),
  const PreviewStageData(PreviewStageItem.woodStep, 10, 15),
  const PreviewStageData(PreviewStageItem.woodStep, 19, 6),
  const PreviewStageData(PreviewStageItem.rockStep, 23, 2),
  const PreviewStageData(PreviewStageItem.woodStep, 24, 5),
  const PreviewStageData(PreviewStageItem.rockStep, 36, 9),
  const PreviewStageData(PreviewStageItem.rockStep, 40, 15),
  const PreviewStageData(PreviewStageItem.woodStep, 45, 1),
  const PreviewStageData(PreviewStageItem.itemSpring, 45, 1),
  const PreviewStageData(PreviewStageItem.woodStep, 50, 11),
  const PreviewStageData(PreviewStageItem.cloudStep, 55, 1),
  const PreviewStageData(PreviewStageItem.woodStep, 62, 17),
  const PreviewStageData(PreviewStageItem.moveStep, 63, 2),
  const PreviewStageData(PreviewStageItem.woodStep, 66, 14),
  const PreviewStageData(PreviewStageItem.cloudStep, 67, 10),
  const PreviewStageData(PreviewStageItem.woodStep, 70, 10),
  const PreviewStageData(PreviewStageItem.itemCarrot, 70, 10),
  const PreviewStageData(PreviewStageItem.cloudStep, 79, 5),
  const PreviewStageData(PreviewStageItem.cloudStep, 86, 2),
  const PreviewStageData(PreviewStageItem.woodStep, 91, 17),
  const PreviewStageData(PreviewStageItem.rockStep, 95, 5),
];

final List<PreviewStageData> stage3 = [
  const PreviewStageData(PreviewStageItem.woodStep, 0, 0),
  const PreviewStageData(PreviewStageItem.woodStep, 5, 4),
  const PreviewStageData(PreviewStageItem.rockStep, 10, 7),
  const PreviewStageData(PreviewStageItem.cloudStep, 17, 3),
  const PreviewStageData(PreviewStageItem.cloudStep, 23, 15),
  const PreviewStageData(PreviewStageItem.woodStep, 28, 6),
  const PreviewStageData(PreviewStageItem.rockStep, 33, 7),
  const PreviewStageData(PreviewStageItem.woodStep, 38, 2),
  const PreviewStageData(PreviewStageItem.rockStep, 40, 19),
  const PreviewStageData(PreviewStageItem.cloudStep, 45, 3),
  const PreviewStageData(PreviewStageItem.woodStep, 45, 9),
  const PreviewStageData(PreviewStageItem.moveStep, 51, 2),
  const PreviewStageData(PreviewStageItem.cloudStep, 51, 15),
  const PreviewStageData(PreviewStageItem.woodStep, 53, 18),
  const PreviewStageData(PreviewStageItem.itemSpring, 53, 18),
  const PreviewStageData(PreviewStageItem.rockStep, 55, 1),
  const PreviewStageData(PreviewStageItem.moveStep, 61, 8),
  const PreviewStageData(PreviewStageItem.cloudStep, 63, 2),
  const PreviewStageData(PreviewStageItem.rockStep, 65, 15),
  const PreviewStageData(PreviewStageItem.rockStep, 78, 2),
  const PreviewStageData(PreviewStageItem.woodStep, 79, 17),
  const PreviewStageData(PreviewStageItem.rockStep, 85, 10),
  const PreviewStageData(PreviewStageItem.moveStep, 92, 3),
];

final List<PreviewStageData> stage4 = [
  const PreviewStageData(PreviewStageItem.rockStep, 2, 13),
  const PreviewStageData(PreviewStageItem.woodStep, 6, 16),
  const PreviewStageData(PreviewStageItem.itemSpringRed, 6, 16),
  const PreviewStageData(PreviewStageItem.woodStep, 8, 5),
  const PreviewStageData(PreviewStageItem.rockStep, 11, 8),
  const PreviewStageData(PreviewStageItem.woodStep, 16, 12),
  const PreviewStageData(PreviewStageItem.cloudStep, 22, 18),
  const PreviewStageData(PreviewStageItem.woodStep, 25, 16),
  const PreviewStageData(PreviewStageItem.moveStep, 25, 12),
  const PreviewStageData(PreviewStageItem.cloudStep, 32, 1),
  const PreviewStageData(PreviewStageItem.rockStep, 36, 17),
  const PreviewStageData(PreviewStageItem.woodStep, 48, 5),
  const PreviewStageData(PreviewStageItem.moveStep, 56, 3),
  const PreviewStageData(PreviewStageItem.woodStep, 64, 19),
  const PreviewStageData(PreviewStageItem.rockStep, 67, 18),
  const PreviewStageData(PreviewStageItem.rockStep, 70, 8),
  const PreviewStageData(PreviewStageItem.woodStep, 78, 13),
  const PreviewStageData(PreviewStageItem.woodStep, 82, 2),
  const PreviewStageData(PreviewStageItem.itemSpring, 82, 2),
  const PreviewStageData(PreviewStageItem.woodStep, 89, 3),
  const PreviewStageData(PreviewStageItem.rockStep, 92, 14),
];

final List<PreviewStageData> stage5 = [
  const PreviewStageData(PreviewStageItem.woodStep, 0, 12),
  const PreviewStageData(PreviewStageItem.itemSpringRed, 0, 12),
  const PreviewStageData(PreviewStageItem.woodStep, 4, 4),
  const PreviewStageData(PreviewStageItem.cloudStep, 8, 11),
  const PreviewStageData(PreviewStageItem.woodStep, 13, 16),
  const PreviewStageData(PreviewStageItem.itemCarrot, 13, 16),
  const PreviewStageData(PreviewStageItem.woodStep, 14, 12),
  const PreviewStageData(PreviewStageItem.rockStep, 16, 5),
  const PreviewStageData(PreviewStageItem.woodStep, 21, 11),
  const PreviewStageData(PreviewStageItem.moveStep, 28, 4),
  const PreviewStageData(PreviewStageItem.woodStep, 30, 15),
  const PreviewStageData(PreviewStageItem.moveStep, 36, 13),
  const PreviewStageData(PreviewStageItem.rockStep, 48, 6),
  const PreviewStageData(PreviewStageItem.moveStep, 53, 3),
  const PreviewStageData(PreviewStageItem.cloudStep, 54, 19),
  const PreviewStageData(PreviewStageItem.rockStep, 56, 6),
  const PreviewStageData(PreviewStageItem.woodStep, 59, 11),
  const PreviewStageData(PreviewStageItem.cloudStep, 63, 19),
  const PreviewStageData(PreviewStageItem.moveStep, 68, 0),
  const PreviewStageData(PreviewStageItem.woodStep, 72, 9),
  const PreviewStageData(PreviewStageItem.rockStep, 85, 19),
  const PreviewStageData(PreviewStageItem.woodStep, 87, 4),
  const PreviewStageData(PreviewStageItem.woodStep, 90, 4),
  const PreviewStageData(PreviewStageItem.woodStep, 92, 4),
  const PreviewStageData(PreviewStageItem.woodStep, 94, 4),
];

final List<PreviewStageData> stage6 = [
  const PreviewStageData(PreviewStageItem.woodStep, 1, 1),
  const PreviewStageData(PreviewStageItem.woodStep, 7, 16),
  const PreviewStageData(PreviewStageItem.woodStep, 11, 9),
  const PreviewStageData(PreviewStageItem.cloudStep, 14, 10),
  const PreviewStageData(PreviewStageItem.woodStep, 19, 7),
  const PreviewStageData(PreviewStageItem.woodStep, 26, 12),
  const PreviewStageData(PreviewStageItem.rockStep, 28, 6),
  const PreviewStageData(PreviewStageItem.woodStep, 33, 8),
  const PreviewStageData(PreviewStageItem.cloudStep, 44, 19),
  const PreviewStageData(PreviewStageItem.moveStep, 44, 0),
  const PreviewStageData(PreviewStageItem.cloudStep, 50, 13),
  const PreviewStageData(PreviewStageItem.woodStep, 55, 16),
  const PreviewStageData(PreviewStageItem.woodStep, 59, 12),
  const PreviewStageData(PreviewStageItem.rockStep, 60, 1),
  const PreviewStageData(PreviewStageItem.cloudStep, 70, 13),
  const PreviewStageData(PreviewStageItem.woodStep, 81, 0),
  const PreviewStageData(PreviewStageItem.itemSpring, 81, 0),
  const PreviewStageData(PreviewStageItem.moveStep, 83, 16),
  const PreviewStageData(PreviewStageItem.rockStep, 85, 10),
  const PreviewStageData(PreviewStageItem.rockStep, 88, 6),
  const PreviewStageData(PreviewStageItem.woodStep, 92, 3),
  const PreviewStageData(PreviewStageItem.rockStep, 95, 18),
];

final List<PreviewStageData> stage7 = [
  const PreviewStageData(PreviewStageItem.rockStep, 3, 10),
  const PreviewStageData(PreviewStageItem.moveStep, 3, 15),
  const PreviewStageData(PreviewStageItem.rockStep, 11, 6),
  const PreviewStageData(PreviewStageItem.rockStep, 26, 2),
  const PreviewStageData(PreviewStageItem.woodStep, 27, 16),
  const PreviewStageData(PreviewStageItem.moveStep, 28, 12),
  const PreviewStageData(PreviewStageItem.moveStep, 34, 7),
  const PreviewStageData(PreviewStageItem.moveStep, 35, 16),
  const PreviewStageData(PreviewStageItem.woodStep, 38, 5),
  const PreviewStageData(PreviewStageItem.itemSpringRed, 38, 5),
  const PreviewStageData(PreviewStageItem.cloudStep, 40, 12),
  const PreviewStageData(PreviewStageItem.woodStep, 41, 7),
  const PreviewStageData(PreviewStageItem.moveStep, 43, 13),
  const PreviewStageData(PreviewStageItem.woodStep, 51, 19),
  const PreviewStageData(PreviewStageItem.rockStep, 56, 1),
  const PreviewStageData(PreviewStageItem.rockStep, 65, 13),
  const PreviewStageData(PreviewStageItem.woodStep, 71, 10),
  const PreviewStageData(PreviewStageItem.itemBalloon, 74, 6),
  const PreviewStageData(PreviewStageItem.woodStep, 74, 19),
  const PreviewStageData(PreviewStageItem.rockStep, 80, 11),
  const PreviewStageData(PreviewStageItem.cloudStep, 81, 18),
  const PreviewStageData(PreviewStageItem.woodStep, 89, 3),
  const PreviewStageData(PreviewStageItem.woodStep, 92, 17),
];

final List<PreviewStageData> stage8 = [
  const PreviewStageData(PreviewStageItem.woodStep, 4, 0),
  const PreviewStageData(PreviewStageItem.moveStep, 10, 15),
  const PreviewStageData(PreviewStageItem.cloudStep, 16, 15),
  const PreviewStageData(PreviewStageItem.moveStep, 19, 9),
  const PreviewStageData(PreviewStageItem.cloudStep, 25, 2),
  const PreviewStageData(PreviewStageItem.woodStep, 34, 15),
  const PreviewStageData(PreviewStageItem.moveStep, 35, 6),
  const PreviewStageData(PreviewStageItem.cloudStep, 40, 13),
  const PreviewStageData(PreviewStageItem.rockStep, 40, 3),
  const PreviewStageData(PreviewStageItem.woodStep, 53, 9),
  const PreviewStageData(PreviewStageItem.moveStep, 56, 13),
  const PreviewStageData(PreviewStageItem.woodStep, 57, 1),
  const PreviewStageData(PreviewStageItem.cloudStep, 63, 10),
  const PreviewStageData(PreviewStageItem.woodStep, 69, 18),
  const PreviewStageData(PreviewStageItem.rockStep, 74, 15),
  const PreviewStageData(PreviewStageItem.woodStep, 75, 1),
  const PreviewStageData(PreviewStageItem.moveStep, 88, 10),
  const PreviewStageData(PreviewStageItem.rockStep, 94, 9),
];

final List<PreviewStageData> stage9 = [
  const PreviewStageData(PreviewStageItem.cloudStep, 6, 8),
  const PreviewStageData(PreviewStageItem.woodStep, 7, 15),
  const PreviewStageData(PreviewStageItem.cloudStep, 9, 14),
  const PreviewStageData(PreviewStageItem.woodStep, 11, 5),
  const PreviewStageData(PreviewStageItem.moveStep, 16, 5),
  const PreviewStageData(PreviewStageItem.cloudStep, 18, 16),
  const PreviewStageData(PreviewStageItem.woodStep, 27, 10),
  const PreviewStageData(PreviewStageItem.woodStep, 35, 19),
  const PreviewStageData(PreviewStageItem.moveStep, 40, 16),
  const PreviewStageData(PreviewStageItem.rockStep, 43, 1),
  const PreviewStageData(PreviewStageItem.moveStep, 53, 3),
  const PreviewStageData(PreviewStageItem.woodStep, 54, 19),
  const PreviewStageData(PreviewStageItem.woodStep, 65, 14),
  const PreviewStageData(PreviewStageItem.woodStep, 72, 1),
  const PreviewStageData(PreviewStageItem.rockStep, 80, 13),
  const PreviewStageData(PreviewStageItem.woodStep, 86, 11),
  const PreviewStageData(PreviewStageItem.woodStep, 90, 8),
];

final List<PreviewStageData> stage10 = [
  const PreviewStageData(PreviewStageItem.cloudStep, 1, 14),
  const PreviewStageData(PreviewStageItem.woodStep, 7, 2),
  const PreviewStageData(PreviewStageItem.woodStep, 7, 19),
  const PreviewStageData(PreviewStageItem.woodStep, 9, 9),
  const PreviewStageData(PreviewStageItem.woodStep, 13, 15),
  const PreviewStageData(PreviewStageItem.rockStep, 20, 0),
  const PreviewStageData(PreviewStageItem.rockStep, 29, 19),
  const PreviewStageData(PreviewStageItem.rockStep, 35, 19),
  const PreviewStageData(PreviewStageItem.woodStep, 38, 9),
  const PreviewStageData(PreviewStageItem.woodStep, 44, 15),
  const PreviewStageData(PreviewStageItem.rockStep, 45, 9),
  const PreviewStageData(PreviewStageItem.woodStep, 50, 17),
  const PreviewStageData(PreviewStageItem.moveStep, 51, 6),
  const PreviewStageData(PreviewStageItem.woodStep, 55, 2),
  const PreviewStageData(PreviewStageItem.moveStep, 60, 11),
  const PreviewStageData(PreviewStageItem.woodStep, 63, 8),
  const PreviewStageData(PreviewStageItem.woodStep, 65, 7),
  const PreviewStageData(PreviewStageItem.woodStep, 67, 19),
  const PreviewStageData(PreviewStageItem.rockStep, 70, 11),
  const PreviewStageData(PreviewStageItem.woodStep, 73, 3),
  const PreviewStageData(PreviewStageItem.rockStep, 75, 16),
  const PreviewStageData(PreviewStageItem.cloudStep, 82, 11),
  const PreviewStageData(PreviewStageItem.woodStep, 87, 12),
  const PreviewStageData(PreviewStageItem.itemSpring, 87, 12),
  const PreviewStageData(PreviewStageItem.moveStep, 93, 14),
];

final List<PreviewStageData> stage11 = [
  const PreviewStageData(PreviewStageItem.woodStep, 0, 0),
  const PreviewStageData(PreviewStageItem.woodStep, 11, 19),
  const PreviewStageData(PreviewStageItem.woodStep, 23, 0),
  const PreviewStageData(PreviewStageItem.woodStep, 35, 19),
  const PreviewStageData(PreviewStageItem.woodStep, 47, 0),
  const PreviewStageData(PreviewStageItem.woodStep, 59, 19),
  const PreviewStageData(PreviewStageItem.woodStep, 71, 0),
  const PreviewStageData(PreviewStageItem.woodStep, 83, 19),
  const PreviewStageData(PreviewStageItem.woodStep, 95, 0),
];

final List<PreviewStageData> stage12 = [
  const PreviewStageData(PreviewStageItem.woodStep, 0, 0),
  const PreviewStageData(PreviewStageItem.moveStep, 11, 19),
  const PreviewStageData(PreviewStageItem.moveStep, 23, -3),
  const PreviewStageData(PreviewStageItem.woodStep, 35, 19),
  const PreviewStageData(PreviewStageItem.woodStep, 47, 0),
  const PreviewStageData(PreviewStageItem.moveStep, 59, 19),
  const PreviewStageData(PreviewStageItem.woodStep, 71, 0),
  const PreviewStageData(PreviewStageItem.moveStep, 83, 19),
  const PreviewStageData(PreviewStageItem.woodStep, 95, 0),
];
