import 'dart:async';

import 'package:orientation_web/orientation_web.dart';

class AccelerometerObserver {
  double alpha = 0.0;
  double gamma = 0.0;
  double beta = 0.0;

  StreamSubscription<OrientationEvent>? _accelerometerEvents;
  Stopwatch stopwatch = Stopwatch();
  double _lastTime = 0.0;

  void listen(Function onChange) {
    if (_accelerometerEvents != null) {
      _accelerometerEvents?.cancel();
      stopwatch.reset();
      _lastTime = 0.0;
    }
    stopwatch.start();

    _accelerometerEvents = orientationEvents.listen((OrientationEvent event) {
      final interval = stopwatch.elapsedMilliseconds / 1000 - _lastTime;
      print(1 / interval);
      alpha = event.alpha;
      gamma = event.gamma;
      beta = event.beta;
      onChange();
      _lastTime = stopwatch.elapsedMilliseconds / 1000;
    });
  }

  void dispose() {
    _accelerometerEvents?.cancel();
    stopwatch.stop();
    _lastTime = 0.0;
  }

  @override
  String toString() {
    return 'AccelerometerObserver{alpha: ${alpha.toStringAsFixed(3)}, gamma: ${gamma.toStringAsFixed(3)}, beta: ${beta.toStringAsFixed(3)}}';
  }
}