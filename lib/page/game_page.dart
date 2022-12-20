import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart' hide Step;
import 'package:flutter/scheduler.dart';
import 'package:usapyon/logic/generate_random_stage.dart';
import 'package:usapyon/view/area_restrict_view.dart';
import 'package:usapyon/view/background_view.dart';
import 'package:usapyon/logic/game_state.dart';
import 'package:usapyon/logic/pyon_player.dart';
import 'package:usapyon/page/result_page.dart';
import 'package:usapyon/step/step.dart';
import 'package:usapyon/step/tick_driven.dart';
import 'package:usapyon/view/count_down_view.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => GamePageState();
}

class GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late final Ticker ticker;
  Duration? prevTick;
  int generatedStageId = 0;
  List<Step> currentSteps = [];
  List<TickDriven> tickDrivenSteps = [];
  double cameraShiftCell = -22;
  double minVerticalPositionCell = 0;

  final PyonPlayer _player = PyonPlayer();

  GameState _gameState = GameState.beforeStart;
  late final CountDownController _countDownController;

  @override
  void initState() {
    super.initState();
    _countDownController = CountDownController();
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

    assert(_gameState == GameState.beforeStart);

    _gameState = GameState.countDown;
    _countDownController.start();
    _countDownController.addZeroCallback(() {
      _gameState = GameState.inGame;
      startGame();
    });
  }

  @override
  void dispose() {
    ticker.dispose();
    _countDownController.dispose();
    super.dispose();
  }

  void startGame() {
    ticker.start();
  }

  void finishGame() {
    _player.finish();
    ticker.stop(canceled: true);
    _gameState = GameState.finished;
    Timer.run(() {
      Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) =>
            ResultPage((-minVerticalPositionCell / 10)),
      ));
    });
  }

  void addStage(int stageId) {
    final newSteps = generateRandomStage(stageId);
    currentSteps.addAll(newSteps);
    tickDrivenSteps.addAll(newSteps.whereType<TickDriven>());
  }

  void forwardGame(Duration elapsed, Duration tickTime) {
    assert(_gameState == GameState.inGame || _gameState == GameState.gameOver);
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
              //---------------------------------------------- 背景
              Positioned.fill(
                  child: BackgroundView(
                      width: width,
                      height: height,
                      centerCell: _player.verticalPositionCell)),

              //---------------------------------------------- ステージ
              Positioned.fill(
                child: Stack(
                  children: currentSteps
                      .map((e) =>
                          e.place(cellWidthPx, cellHeightPx, displayOffsetPx))
                      .toList(),
                ),
              ),

              //---------------------------------------------- プレイヤー
              Positioned(
                  left: cellWidthPx * (_player.horizontalPositionCell - 1.5),
                  top: cellHeightPx * (18 - cameraShiftCell),
                  child: _player.place(cellWidthPx, cellHeightPx)),

              //---------------------------------------------- 操作用スライダー
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

              //---------------------------------------------- メートル表示
              Positioned(
                right: 8,
                top: 8,
                child: Text(
                  minVerticalPositionCell == 0
                      ? "0 m"
                      : "${(-minVerticalPositionCell / 10).toStringAsFixed(0)} m",
                  style: const TextStyle(fontSize: 40),
                ),
              ),

              //---------------------------------------------- カウントダウン
              Align(
                  child: CountDownView(
                controller: _countDownController,
                visible: _gameState == GameState.countDown,
              ))
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
}
