import 'dart:math';

import 'package:flutter/material.dart';
import 'package:usapyon/stage/stage_data.dart';
import 'package:usapyon/view/area_restrict_view.dart';

enum PreviewStageItem {
  cloudStep,
  itemBalloon,
  itemCarrot,
  itemSpringRed,
  itemSpring,
  moveStep,
  rockStep,
  woodStep,
}

class PreviewStageData {
  final PreviewStageItem item;
  final int top;
  final int left;
  const PreviewStageData(this.item, this.top, this.left);

  String getDartString() {
    return "const PreviewStageData(PreviewStageItem.${item.name}, $top, $left),";
  }

  Positioned place(double cellPx) {
    switch (item) {
      // ステップは左上が座標
      case PreviewStageItem.cloudStep:
        return Positioned(
          top: top * cellPx,
          left: left * cellPx,
          child: Image.asset(
            "assets/cloud.png",
            width: cellPx * 5,
            height: cellPx,
          ),
        );
      case PreviewStageItem.woodStep:
        return Positioned(
          top: top * cellPx,
          left: left * cellPx,
          child: Image.asset(
            "assets/wood.jpg",
            width: cellPx * 5,
            height: cellPx,
          ),
        );
      case PreviewStageItem.rockStep:
        return Positioned(
          top: top * cellPx,
          left: left * cellPx,
          child: Image.asset(
            "assets/rock.jpg",
            width: cellPx * 5,
            height: cellPx,
          ),
        );
      case PreviewStageItem.moveStep:
        return Positioned(
            top: top * cellPx,
            left: left * cellPx,
            child: SizedBox(
              width: cellPx * 10,
              height: cellPx,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ColoredBox(color: Colors.blue.shade500),
                  ),
                  Image.asset(
                    "assets/move.jpg",
                    width: cellPx * 5,
                    height: cellPx,
                  ),
                ],
              ),
            ));
      // アイテムは左下or乗っている台と同じ位置
      case PreviewStageItem.itemBalloon:
        return Positioned(
          top: (top - 3) * cellPx,
          left: left * cellPx,
          child: Image.asset(
            "assets/balloon.png",
            width: cellPx * 2,
            height: cellPx * 3,
          ),
        );
      case PreviewStageItem.itemCarrot:
        return Positioned(
          top: (top - 3) * cellPx,
          left: (left + 1) * cellPx,
          child: Image.asset(
            "assets/carrot.png",
            width: cellPx * 3,
            height: cellPx * 3,
          ),
        );
      case PreviewStageItem.itemSpring:
        return Positioned(
          top: (top - 2) * cellPx,
          left: (left + 1) * cellPx,
          child: Image.asset(
            "assets/spring.png",
            width: cellPx * 3,
            height: cellPx * 2,
          ),
        );
      case PreviewStageItem.itemSpringRed:
        return Positioned(
          top: (top - 2) * cellPx,
          left: (left + 1) * cellPx,
          child: Image.asset(
            "assets/spring_red.png",
            width: cellPx * 3,
            height: cellPx * 2,
          ),
        );
    }
  }
}

class StagePreviewPage extends StatelessWidget {
  final List<PreviewStageData> stage = [
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

  StagePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AreaRestrictView(
        child: SingleChildScrollView(
          child: AspectRatio(
              aspectRatio: 24 / 96,
              child: ColoredBox(
                color: Colors.lightBlue.shade200,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.biggest.width;
                    final height = constraints.biggest.height;
                    final cellPx = width / 24;
                    return Stack(
                      children: [
                        ...List.generate(
                            48,
                            (index) => Positioned(
                                  left: 0,
                                  right: 0,
                                  top: index * 2 * cellPx,
                                  child: Container(
                                    color: Colors.black12,
                                    width: width,
                                    height: cellPx,
                                    child: Text("${index * 2}"),
                                  ),
                                )),
                        ...List.generate(
                            12,
                            (index) => Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: index * 2 * cellPx,
                                  child: Container(
                                    color: Colors.black12,
                                    width: cellPx,
                                    height: height,
                                    child: Text("${index * 2}"),
                                  ),
                                )),
                        ...stage.map((e) => e.place(cellPx))
                      ],
                    );
                  },
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newStage = generateRandomStage();
          print(newStage.map((e) => e.getDartString()).join("\n"));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<PreviewStageData> generateRandomStage() {
    final items = <PreviewStageData>[];
    final result = List.generate(25, (index) {
      final r = Random();
      switch (r.nextInt(5)) {
        case 0:
          {
            final s = PreviewStageData(
                PreviewStageItem.woodStep, r.nextInt(96), r.nextInt(20));
            switch (r.nextInt(3)) {
              case 0:
                items.add(PreviewStageData(
                    PreviewStageItem.itemCarrot, s.top, s.left));
                break;
              case 1:
                items.add(PreviewStageData(
                    PreviewStageItem.itemSpring, s.top, s.left));
                break;
              case 2:
                items.add(PreviewStageData(
                    PreviewStageItem.itemSpringRed, s.top, s.left));
                break;
            }
            return s;
          }
        case 1:
          return PreviewStageData(
              PreviewStageItem.rockStep, r.nextInt(96), r.nextInt(20));
        case 2:
          return PreviewStageData(
              PreviewStageItem.cloudStep, r.nextInt(96), r.nextInt(20));
        case 3:
          if (r.nextInt(10) == 1) {
            return PreviewStageData(
                PreviewStageItem.itemBalloon, r.nextInt(96), r.nextInt(22));
          }
          return PreviewStageData(
              PreviewStageItem.moveStep, r.nextInt(96), r.nextInt(17));
        default:
          return PreviewStageData(
              PreviewStageItem.woodStep, r.nextInt(96), r.nextInt(20));
      }
    });
    result.addAll(items);
    return result..sort((a, b) => a.top - b.top);
  }
}
