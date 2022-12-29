library orientation_web;

import 'dart:async';
import 'dart:html';
import 'package:js/js.dart';

@JS("requestDeviceOrientationEventPermission")
external void requestDeviceOrientationEventPermission();

StreamController<OrientationEvent>? _orientationStreamController;
late Stream<OrientationEvent> _orientationResultStream;
Stream<OrientationEvent> get orientationEvents {
  if (_orientationStreamController == null) {
    _orientationStreamController = StreamController<OrientationEvent>();

    window.addEventListener("deviceorientation", (event) {
      event as DeviceOrientationEvent;
      _orientationStreamController!.add(OrientationEvent(
        event.alpha as double, 
        event.gamma as double, 
        event.beta as double
      ));
    }, true);

    _orientationResultStream = _orientationStreamController!.stream.asBroadcastStream();
  }
  return _orientationResultStream;
}

///
///
/// # params
/// - alpha: rotation around z-axis
/// - gamma: left to right
/// - beta: front back motion
class OrientationEvent {
  final double alpha, gamma, beta;
  const OrientationEvent(this.alpha, this.gamma, this.beta);
}
