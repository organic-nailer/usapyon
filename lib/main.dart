import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const GameView());
  }
}

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<StatefulWidget> createState() => GameViewState();
}

class GameViewState extends State<GameView> with TickerProviderStateMixin {
  late final Ticker ticker;
  Duration? prevTick;
  double playerVerticalPositionCell = 0;
  double playerVelocityCell = -60;
  final double gravityCell = 150; // 33.3;
  int generatedStageId = 0;
  List<WoodStep> currentSteps = [];
  double playerHorizontalVelocityCell = 0;
  double playerHorizontalPositionCell = 12;
  double cameraShiftCell = 0;

  @override
  void initState() {
    super.initState();
    currentSteps.addAll(generateRandomStage(0));
    ticker = createTicker((elapsed) {
      if (prevTick != null) {
        setState(() {
          forwardGame(elapsed - prevTick!);
        });
      }
      prevTick = elapsed;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void forwardGame(Duration tickTime) {
    playerVerticalPositionCell += tickTime.inMilliseconds / 1000 * playerVelocityCell;
    playerHorizontalPositionCell += tickTime.inMilliseconds / 1000 * playerHorizontalVelocityCell;
    if (playerHorizontalPositionCell >= 25.5 && playerHorizontalVelocityCell > 0) {
      playerHorizontalPositionCell = -1.5;
    }
    else if(playerHorizontalPositionCell <= -1.5 && playerHorizontalPositionCell < 0) {
      playerHorizontalPositionCell = 25.5;
    }

    cameraShiftCell += -playerVelocityCell * 0.005;
    cameraShiftCell += -cameraShiftCell * 0.03;

    playerVelocityCell = min(playerVelocityCell + tickTime.inMilliseconds / 1000 * gravityCell, 60);
    // print(playerPositionCell);
    if (playerVerticalPositionCell <= -(generatedStageId * 96 + 54)) {
      generatedStageId++;
      currentSteps.addAll(generateRandomStage(generatedStageId));
    }
    if (currentSteps.isNotEmpty) {
      int removeIndex = 0;
      while(currentSteps[removeIndex].vCell >= playerVerticalPositionCell + 20) {
        removeIndex++;
      }
      currentSteps.removeRange(0, removeIndex);
      if (removeIndex > 0) print("Remove $removeIndex steps");
      for (int i = 0; i < currentSteps.length; i++) {
        if (currentSteps[i].vCell + 1 < playerVerticalPositionCell) break;
        if (currentSteps[i].vCell - 1 < playerVerticalPositionCell) {
          if (currentSteps[i].hCell < playerHorizontalPositionCell + 1.5 &&
              playerHorizontalPositionCell - 1.5 < currentSteps[i].hCell + 5 &&
              playerVelocityCell > 10) {
            playerVelocityCell = -60;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 1 / 2.0,
          child: Container(
            color: Colors.green.shade50,
            child: LayoutBuilder(builder: (context, constraints) {
              final width = constraints.biggest.width;
              final height = constraints.biggest.height;
              final cellWidthPx = width / 24;
              final cellHeightPx = cellWidthPx;
              final centerCell = playerVerticalPositionCell + cameraShiftCell;
              final displayOffsetPx = height / 2 - centerCell * cellHeightPx;
              return Stack(
                children: [
                  Positioned.fill(
                    child: Stack(
                      children: currentSteps
                          .map((e) => Positioned(
                                left: e.hCell * cellWidthPx,
                                top: e.vCell * cellHeightPx -
                                    cellHeightPx +
                                    displayOffsetPx,
                                child: Container(
                                  width: cellWidthPx * 5,
                                  height: cellHeightPx,
                                  color: e.stageId % 2 == 0
                                      ? Colors.lightBlue
                                      : Colors.lightGreen,
                                  child: Text(
                                      "(${e.stageId}:${e.hCell},${e.vCell})"),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Positioned(
                    left: cellWidthPx * (playerHorizontalPositionCell - 1.5),
                    top: cellHeightPx * (18 - cameraShiftCell),
                    child: Container(
                      width: cellWidthPx * 3,
                      height: cellHeightPx * 6,
                      color: Colors.red
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Slider(
                      value: playerHorizontalVelocityCell,
                      onChanged: (value) {
                        setState(() {
                          playerHorizontalVelocityCell = value;
                        });
                      },
                      min: -80,
                      max: 80,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Text("""${(-playerVerticalPositionCell / 10).toStringAsFixed(0)} m""".trim()
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          playerVelocityCell = -60;
        },
        child: const Icon(Icons.upcoming),
      ),
    );
  }

  /// 横24、縦96マスのステージをランダムに生成
  /// 下にあるものが先になるようにしている
  List<WoodStep> generateRandomStage(int stageId) {
    print("Generate Stage $stageId");
    return List.generate(20, (index) {
      final r = Random();
      return WoodStep(r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
    })
      ..sort((a, b) => b.vCell - a.vCell);
  }
}

class WoodStep {
  final int hCell;
  final int vCell;
  final int stageId;
  const WoodStep(this.hCell, this.vCell, this.stageId);
}
