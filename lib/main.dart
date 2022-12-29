import 'package:flutter/material.dart';
import 'package:usapyon/page/game_page.dart';
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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
    //    home: StagePreviewPage(),);
    //    home: const GamePage());
    home: const StartPage());
  }
}
