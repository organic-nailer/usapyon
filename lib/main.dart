import 'dart:math';

import 'package:flutter/material.dart' hide Step;
import 'package:flutter/scheduler.dart';
import 'package:usapyon/step/cloud_step.dart';
import 'package:usapyon/step/move_step.dart';
import 'package:usapyon/step/rock_step.dart';
import 'package:usapyon/step/step.dart';
import 'package:usapyon/step/tick_driven.dart';
import 'package:usapyon/step/wood_step.dart';

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
    // home: StartPage());
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
  List<Step> currentSteps = [];
  List<TickDriven> tickDrivenSteps = [];
  double playerHorizontalVelocityCell = 0;
  double playerHorizontalPositionCell = 12;
  double cameraShiftCell = 0;

  @override
  void initState() {
    super.initState();
    addStage(0);
    ticker = createTicker((elapsed) {
      if (prevTick != null) {
        setState(() {
          forwardGame(elapsed, elapsed - prevTick!);
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

  void addStage(int stageId) {
    final newSteps = generateRandomStage(stageId);
    currentSteps.addAll(newSteps);
    tickDrivenSteps.addAll(newSteps.whereType<TickDriven>());
  }

  void forwardGame(Duration elapsed, Duration tickTime) {
    playerVerticalPositionCell +=
        tickTime.inMilliseconds / 1000 * playerVelocityCell;
    playerHorizontalPositionCell +=
        tickTime.inMilliseconds / 1000 * playerHorizontalVelocityCell;
    if (playerHorizontalPositionCell >= 25.5 &&
        playerHorizontalVelocityCell > 0) {
      playerHorizontalPositionCell = -1.5;
    } else if (playerHorizontalPositionCell <= -1.5 &&
        playerHorizontalPositionCell < 0) {
      playerHorizontalPositionCell = 25.5;
    }

    cameraShiftCell += -playerVelocityCell * 0.005;
    cameraShiftCell += -cameraShiftCell * 0.03;

    playerVelocityCell = min(
        playerVelocityCell + tickTime.inMilliseconds / 1000 * gravityCell, 60);
    // print(playerPositionCell);
    if (playerVerticalPositionCell <= -(generatedStageId * 96 + 54)) {
      generatedStageId++;
      addStage(generatedStageId);
    }
    if (currentSteps.isNotEmpty) {
      int removeIndex = 0;
      while (
          currentSteps[removeIndex].vCell >= playerVerticalPositionCell + 20) {
        if (currentSteps[removeIndex] is TickDriven) {
          tickDrivenSteps.remove(currentSteps[removeIndex] as TickDriven);
        }
        removeIndex++;
      }
      currentSteps.removeRange(0, removeIndex);
      if (removeIndex > 0) print("Remove $removeIndex steps");
      for (int i = 0; i < currentSteps.length; i++) {
        if (!currentSteps[i].isEnabled()) continue;
        if (currentSteps[i].vCell + 1 < playerVerticalPositionCell) break;
        if (currentSteps[i].vCell - 1 < playerVerticalPositionCell) {
          if (currentSteps[i].checkHorizontalCollision(playerHorizontalPositionCell) &&
              playerVelocityCell > 10) {
            currentSteps[i].onTrample();
            playerVelocityCell = -60;
          }
        }
      }
    }
    for (final step in tickDrivenSteps) {
      step.onTick(elapsed);
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
                      children: currentSteps.map((e) => 
                        e.place(cellWidthPx, cellHeightPx, displayOffsetPx)
                      ).toList(),
                    ),
                  ),
                  Positioned(
                    left: cellWidthPx * (playerHorizontalPositionCell - 1.5),
                    top: cellHeightPx * (18 - cameraShiftCell),
                    child: Container(
                        width: cellWidthPx * 3,
                        height: cellHeightPx * 6,
                        color: Colors.red),
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
                    child: Text(
                        """${(-playerVerticalPositionCell / 10).toStringAsFixed(0)} m"""
                            .trim()),
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
  List<Step> generateRandomStage(int stageId) {
    print("Generate Stage $stageId");
    return List.generate(20, (index) {
      final r = Random();
      switch (r.nextInt(4)) {
        case 0:
          return WoodStep(
              r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
        case 1:
          return RockStep(
              r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
        case 2:
          return CloudStep(
              r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
        default:
          return MoveStep(
              r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
      }
    })
      ..sort((a, b) => b.vCell - a.vCell);
  }
}
