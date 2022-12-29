import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerObserver {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;

  StreamSubscription<AccelerometerEvent>? _accelerometerEvents;
  Stopwatch stopwatch = Stopwatch();
  double _lastTime = 0.0;

  void listen(Function onChange) {
    if (_accelerometerEvents != null) {
      _accelerometerEvents?.cancel();
      stopwatch.reset();
      _lastTime = 0.0;
    }
    stopwatch.start();

    _accelerometerEvents = accelerometerEvents.listen((AccelerometerEvent event) {
      final interval = stopwatch.elapsedMilliseconds / 1000 - _lastTime;
      print(1 / interval);
      x = event.x;
      y = event.y;
      z = event.z;
      onChange();
      _lastTime = stopwatch.elapsedMilliseconds / 1000;
    });
  }

  void resetPosition() {
    x = 0.0;
    y = 0.0;
    z = 0.0;
  }

  void dispose() {
    _accelerometerEvents?.cancel();
    stopwatch.stop();
    _lastTime = 0.0;
  }

  @override
  String toString() {
    return 'AccelerometerObserver{x: $x, y: $y, z: $z}';
  }
}