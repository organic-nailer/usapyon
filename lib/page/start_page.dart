import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orientation_web/orientation_web.dart';
import 'package:usapyon/logic/game_storage.dart';
import 'package:usapyon/logic/height_to_grade.dart';
import 'package:usapyon/page/game_page.dart';
import 'package:usapyon/page/information_page.dart';
import 'package:usapyon/view/area_restrict_view.dart';
import 'package:usapyon/view/banner_view.dart';
import 'package:usapyon/view/concentration_line_view.dart';
import 'package:usapyon/view/pyon_button.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StatefulWidget> createState() => StartPageState();
}

class StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController rabbitController;
  bool isMotionEnabled = true;
  late final Future<double?> highScoreData;
  late final Future<bool?> motionEnabledData;

  @override
  void initState() {
    super.initState();
    rabbitController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    rabbitController.repeat(reverse: true);

    // requestDeviceOrientationEventPermission();
    highScoreData = GameStorage.instance.getHightScore();
    motionEnabledData = GameStorage.instance.getMotionEnabled();
  }

  @override
  void dispose() {
    rabbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: AreaRestrictView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                children: [
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        "assets/campus.png",
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const Positioned.fill(
                    child: ConcentrationLineView(
                      split: 32,
                      color: Colors.white24,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset("assets/title.png"),
                  ),
                  Align(
                    alignment: const Alignment(0.9, 0.4),
                    child: FutureBuilder(
                      future: highScoreData,
                      builder: (context, snapshot) {
                        final highScore = snapshot.data;
                        final grade = highScore != null ? getGrade(highScore) : "-";
                        final fontSizeHead = constraints.biggest.height / 28;
                        final fontSizeText = constraints.biggest.height / 36;
                        return Container(
                          color: Colors.amber.shade200,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("ハイスコア", style: TextStyle(fontSize: fontSizeHead, color: Colors.pink),),
                              Text("${highScore?.toStringAsFixed(0) ?? "-"} m", style: TextStyle(fontSize: fontSizeText),),
                              Text("称号", style: TextStyle(fontSize: fontSizeHead, color: Colors.pink),),
                              Text(grade, style: TextStyle(fontSize: fontSizeText),)
                            ],
                          ),
                        );
                      }
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.all(constraints.biggest.height / 12),
                          child: SlideTransition(
                              position: rabbitController
                                  .drive(CurveTween(curve: Curves.easeInOut))
                                  .drive(Tween(
                                      begin: const Offset(0, -0.05),
                                      end: const Offset(0, 0.05))),
                              child: Transform.rotate(
                                angle: pi / 12,
                                child: Image.asset(
                                  "assets/rabbit_title.png",
                                  height: constraints.biggest.height / 2.5,
                                ),
                              )),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: constraints.biggest.width / 8),
                            child: PyonButton(
                              height: constraints.biggest.height / 20,
                              text: "スタート",
                              onPressed: () {
                                requestDeviceOrientationEventPermission();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => GamePage(isMotionEnabled: isMotionEnabled,)));
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: constraints.biggest.width / 8),
                          child: PyonButton(
                            text: "ライセンス",
                            height: constraints.biggest.height / 20,
                            onPressed: () {
                              showLicensePage(context: context);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: constraints.biggest.width / 8),
                          child: PyonButton(
                            text: "インフォメーション",
                            height: constraints.biggest.height / 20,
                            onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => const InformationPage()));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: const Alignment(-0.9, -0.4),
                    child: FutureBuilder(
                      future: GameStorage.instance.getMotionEnabled(),
                      builder: (context, snapshot) {
                        isMotionEnabled = snapshot.data ?? isMotionEnabled;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FloatingActionButton.large(
                              backgroundColor: Colors.amber.shade200,
                              foregroundColor: Colors.black,
                              onPressed: () {
                                setState(() {
                                  isMotionEnabled = !isMotionEnabled;
                                });
                                GameStorage.instance.saveMotionEnabled(isMotionEnabled);
                              },
                              child: Icon(isMotionEnabled ? Icons.screen_rotation : Icons.screen_lock_rotation),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(isMotionEnabled ? "傾き:ON" : "傾き:OFF", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                            )
                          ],
                        );
                      }
                    ),
                  )
                ],
              );
            }),
          ),
          const BannerView()
        ],
      )),
    );
  }
}
