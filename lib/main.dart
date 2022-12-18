import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart' hide Step;
import 'package:flutter/scheduler.dart';
import 'package:usapyon/area_restrict_view.dart';
import 'package:usapyon/background_view.dart';
import 'package:usapyon/game_state.dart';
import 'package:usapyon/pyon_player.dart';
import 'package:usapyon/result_page.dart';
import 'package:usapyon/step/cloud_step.dart';
import 'package:usapyon/step/item_balloon.dart';
import 'package:usapyon/step/item_carrot.dart';
import 'package:usapyon/step/item_on_step.dart';
import 'package:usapyon/step/item_spring.dart';
import 'package:usapyon/step/item_spring_red.dart';
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
  int generatedStageId = 0;
  List<Step> currentSteps = [];
  List<TickDriven> tickDrivenSteps = [];
  double cameraShiftCell = -22;
  double minVerticalPositionCell = 0;

  final PyonPlayer _player = PyonPlayer();

  GameState _gameState = GameState.beforeStart;
  int countDownNumber = 0;

  @override
  void initState() {
    super.initState();
    tickDrivenSteps.add(_player);
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

    assert(_gameState == GameState.beforeStart);

    countDownNumber = 5;
    _gameState = GameState.countDown;
    Timer.periodic(const Duration(seconds: 1), (t) {
      if (countDownNumber <= 1) {
        t.cancel();
        _gameState = GameState.inGame;
        startGame();
        return;
      } else {
        setState(() {
          countDownNumber--;
        });
      }
    });

    // ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void startGame() {
    ticker.start();
  }

  void finishGame() {
    _gameState = GameState.finished;
    _player.finish();
    ticker.stop(canceled: true);
    Timer.run(() {
      Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => const ResultPage(1000),
      ));
    });
  }

  void addStage(int stageId) {
    final newSteps = generateRandomStage(stageId);
    currentSteps.addAll(newSteps);
    tickDrivenSteps.addAll(newSteps.whereType<TickDriven>());
  }

  void forwardGame(Duration elapsed, Duration tickTime) {
    _player.forward(tickTime);
    if (_gameState == GameState.gameOver) {
      cameraShiftCell -= 0.3;
      if (cameraShiftCell <= -27) {
        cameraShiftCell = -27;
        finishGame();
      }
      return;
    }
    minVerticalPositionCell =
        min(minVerticalPositionCell, _player.verticalPositionCell);
    if (_player.verticalPositionCell > minVerticalPositionCell + 40 + 2) {
      _gameState = GameState.gameOver;
    }

    cameraShiftCell += -_player.verticalVelocityCell * 0.005;
    cameraShiftCell += -cameraShiftCell * 0.03;

    // print(playerPositionCell);
    if (_player.verticalPositionCell <= -(generatedStageId * 96 + 54)) {
      generatedStageId++;
      addStage(generatedStageId);
    }
    if (currentSteps.isNotEmpty) {
      // プレイヤーから一定距離下にいった足場を削除する
      int removeIndex = 0;
      while (currentSteps[removeIndex].vCell >=
          _player.verticalPositionCell + 40) {
        if (currentSteps[removeIndex] is TickDriven) {
          tickDrivenSteps.remove(currentSteps[removeIndex] as TickDriven);
        }
        removeIndex++;
      }
      currentSteps.removeRange(0, removeIndex);
      if (removeIndex > 0) print("Remove $removeIndex steps");

      // 足場の当たり判定
      for (int i = 0; i < currentSteps.length; i++) {
        if (!currentSteps[i].isEnabled()) continue;
        if (currentSteps[i].vCell + 6 < _player.verticalPositionCell) break;
        if (currentSteps[i].checkCollision(_player)) {
          currentSteps[i].onTrample(_player, elapsed);
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
      body: AreaRestrictView(
        child: LayoutBuilder(builder: (context, constraints) {
          final width = constraints.biggest.width;
          final height = constraints.biggest.height;
          final cellWidthPx = width / 24;
          final cellHeightPx = cellWidthPx;
          final centerCell = _player.verticalPositionCell + cameraShiftCell;
          final displayOffsetPx = height / 2 - centerCell * cellHeightPx;
          return Stack(
            children: [
              Positioned.fill(
                  child: BackgroundView(
                      width: width,
                      height: height,
                      centerCell: _player.verticalPositionCell)),
              Positioned.fill(
                child: Stack(
                  children: currentSteps
                      .map((e) => e.place(
                          cellWidthPx, cellHeightPx, displayOffsetPx))
                      .toList(),
                ),
              ),
              Positioned(
                left: cellWidthPx * (_player.horizontalPositionCell - 1.5),
                top: cellHeightPx * (18 - cameraShiftCell),
                child: _player.place(cellWidthPx, cellHeightPx)
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Slider(
                  value: _player.horizontalVelocityCell,
                  onChanged: (value) {
                    setState(() {
                      _player.updateHorizontalVelocity(value);
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
                    """${(-_player.verticalPositionCell / 10).toStringAsFixed(0)} m"""
                        .trim()),
              ),
              Align(
                child: Visibility(
                    visible: _gameState == GameState.countDown && countDownNumber <= 3,
                    child: Text(
                      countDownNumber.toString(),
                      style: const TextStyle(fontSize: 200),
                    )),
              )
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _player.verticalVelocityCell = -60;
          // _player.startShooting(prevTick!, 2 * 1000);
        },
        child: const Icon(Icons.upcoming),
      ),
    );
  }

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
            switch(r.nextInt(3)) {
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
          return MoveStep(r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
        default:
          return MoveStep(
              r.nextInt(24), -r.nextInt(96) - stageId * 96, stageId);
      }
    });
    result.addAll(items);
    return result..sort((a, b) => b.vCell - a.vCell);
  }
}
