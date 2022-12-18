import 'package:flutter/material.dart' hide Step;
import 'package:usapyon/pyon_player.dart';
import 'package:usapyon/step/step.dart';
import 'package:usapyon/step/tick_driven.dart';

enum CloudStepState {
  appear,
  disappearing,
  disappeared,
  appearing;
}

class CloudStep extends Step implements TickDriven {
  Duration? startAnimation;
  double opacity = 1.0;
  CloudStepState _state = CloudStepState.appear;
  CloudStep(super.hCell, super.vCell, super.stageId);

  @override
  void onTrample(PyonPlayer player, Duration elapsed) {
    assert(_state == CloudStepState.appear);
    _state = CloudStepState.disappearing;
    super.onTrample(player, elapsed);
  }

  @override
  Widget place(
      double cellWidthPx, double cellHeightPx, double displayOffsetPx) {
    return Positioned(
      left: hCell * cellWidthPx,
      top: vCell * cellHeightPx - cellHeightPx + displayOffsetPx,
      child: Opacity(
        opacity: opacity,
        child: Image.asset(
          "assets/cloud.png",
          width: cellWidthPx * 5,
          height: cellHeightPx
        ),
      ),
    );
  }

  @override
  bool isEnabled() => _state == CloudStepState.appear;

  @override
  void onTick(Duration elapsed) {
    if (startAnimation != null) {
      if (_state == CloudStepState.disappearing) {
        opacity = 1 - (elapsed - startAnimation!).inMilliseconds / 500;
        if (opacity <= 0.0) {
          opacity = 0;
          startAnimation = elapsed;
          _state = CloudStepState.disappeared;
        }
      }
      else if (_state == CloudStepState.appearing) {
        opacity = (elapsed - startAnimation!).inMilliseconds / 500;
        if (opacity >= 1.0) {
          opacity = 1;
          startAnimation = null;
          _state = CloudStepState.appear;
        }
      }
      else {
        assert(_state == CloudStepState.disappeared);
        if((elapsed - startAnimation!).inMilliseconds >= 1000) {
          _state = CloudStepState.appearing;
          startAnimation = elapsed;
        }
      }
    }
    else if(_state == CloudStepState.disappearing 
         || _state == CloudStepState.appearing) {
      startAnimation = elapsed;
    }
  }
}
