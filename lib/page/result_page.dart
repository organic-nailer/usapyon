import 'package:flutter/material.dart';
import 'package:usapyon/logic/game_storage.dart';
import 'package:usapyon/logic/height_to_grade.dart';
import 'package:usapyon/logic/share_sns.dart';
import 'package:usapyon/page/game_page.dart';
import 'package:usapyon/view/area_restrict_view.dart';
import 'package:usapyon/view/banner_view.dart';
import 'package:usapyon/view/pyon_button.dart';
import 'package:usapyon/page/start_page.dart';
import 'package:usapyon/view/stroked_text.dart';

class ResultPage extends StatefulWidget {
  final double heightMeter;
  final bool isMotionEnabled;
  const ResultPage(this.heightMeter, this.isMotionEnabled, {super.key});

  @override
  State<StatefulWidget> createState() => ResultPageState();
}

class ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late final int aquisitionCredits;
  late final AnimationController _gradeTextController;

  @override
  void initState() {
    super.initState();
    aquisitionCredits = (widget.heightMeter / 100).floor();
    _gradeTextController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _gradeTextController.forward();

    GameStorage.instance.saveScore(widget.heightMeter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AreaRestrictView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      color: Colors.white.withOpacity(0.5),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StrokedText(
                                text: "結果",
                                strokeColor: Colors.black,
                                innerColor: Colors.white,
                                fontSize: constraints.biggest.height / 18,
                              ),
                              Text(
                                "${widget.heightMeter.toStringAsFixed(0)}m",
                                style: TextStyle(fontSize: constraints.biggest.height / 10),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: constraints.biggest.height / 24),
                                child: ScaleTransition(
                                  scale: _gradeTextController
                                      .drive(CurveTween(curve: Curves.easeInCubic))
                                      .drive(Tween(begin: 5.0, end: 1.0)),
                                  child: StrokedText(
                                    text: getGrade(widget.heightMeter),
                                    fontSize: constraints.biggest.height / 12,
                                    strokeColor: Colors.white,
                                    innerColor: Colors.green,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "獲得単位数 $aquisitionCredits",
                                  style: TextStyle(
                                      fontSize: constraints.biggest.height / 32, color: Colors.red),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: Image.asset("assets/twitter.png"),
                                      onPressed: () async {
                                        shareTwitter(
                                            widget.heightMeter.toStringAsFixed(0),
                                            getGrade(widget.heightMeter));
                                      },
                                      iconSize: constraints.biggest.height / 10,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: Image.asset("assets/facebook.png"),
                                      onPressed: () async {
                                        shareFacebook();
                                      },
                                      iconSize: constraints.biggest.height / 10,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: Image.asset("assets/line.png"),
                                      onPressed: () async {
                                        shareLine(
                                            widget.heightMeter.toStringAsFixed(0),
                                            getGrade(widget.heightMeter));
                                      },
                                      iconSize: constraints.biggest.height / 10,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: StrokedText(
                                  text: "記録を友達にシェアしよう！",
                                  fontSize: constraints.biggest.height /24,
                                  strokeColor: Colors.white,
                                  innerColor: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: PyonButton(
                                          text: "タイトルへ",
                                          height: constraints.biggest.height / 20,
                                          onPressed: () {
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const StartPage()));
                                          },
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: PyonButton(
                                          text: "リトライ",
                                          height: constraints.biggest.height / 20,
                                          onPressed: () {
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        GamePage(isMotionEnabled: widget.isMotionEnabled,)));
                                          },
                                        ),
                                      ))
                                ],
                              )
                            ],
                          );
                        }
                      ),
                    )),
              ),
            ),
            const BannerView()
          ],
        ),
      ),
    );
  }
}
