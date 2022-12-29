import 'package:flutter/material.dart';
import 'package:usapyon/page/game_page.dart';
import 'package:usapyon/page/sensor_page.dart';
import 'package:usapyon/page/stage_preview_page.dart';
import 'package:usapyon/page/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '帰ってきたうさぴょん',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
    //    home: StagePreviewPage(),);
    //    home: const GamePage());
    home: const StartPage());
  }
}
