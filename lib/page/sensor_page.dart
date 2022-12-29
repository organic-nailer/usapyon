import 'dart:math';

import 'package:flutter/material.dart';
import 'package:usapyon/logic/accelerometer_observer.dart';
import 'package:usapyon/logic/gyroscope_observer.dart';
import 'package:usapyon/page/game_page.dart';
import 'package:usapyon/view/area_restrict_view.dart';
import 'package:usapyon/view/banner_view.dart';
import 'package:usapyon/view/concentration_line_view.dart';
import 'package:usapyon/view/pyon_button.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  State<StatefulWidget> createState() => SensorPageState();
}

class SensorPageState extends State<SensorPage> {
  final AccelerometerObserver accelerometerObserver = AccelerometerObserver();
  // final GyroscopeObserver gyroscopeObserver = GyroscopeObserver();

  double ax = 0;
  double ay = 0;
  double az = 0;

  double pitchAngle = 0;

  @override
  void initState() {
    super.initState();
    accelerometerObserver.listen(() {
      setState(() {
        ax = accelerometerObserver.x;
        ay = accelerometerObserver.y;
        az = accelerometerObserver.z;
        // nc = (0,1,0) × (ax,ay,az) = (az,0,-ax)
        // pitch_angle = 90deg - (0,0,1) * nc = 90deg - (-ax) / sqrt(az^2+ax^2)
        // (0,0,1) * (ax,ay,az) = (az) / sqrt(ax^2+ay^2+az^2)
        pitchAngle = -ax / sqrt(ax*ax + az*az) * 180 / pi;
      });
    });
  }

  @override
  void dispose() {
    accelerometerObserver.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text("$ax,$ay,$az\n${pitchAngle.toStringAsFixed(1)}"),
      )
    );
  }
}
