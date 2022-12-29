import 'package:flutter/material.dart';
import 'package:usapyon/logic/share_sns.dart';
import 'package:usapyon/page/game_page.dart';
import 'package:usapyon/view/area_restrict_view.dart';
import 'package:usapyon/view/banner_view.dart';
import 'package:usapyon/view/pyon_button.dart';
import 'package:usapyon/page/start_page.dart';
import 'package:usapyon/view/stroked_text.dart';

class ResultPage extends StatefulWidget {
  final double heightMeter;
  const ResultPage(this.heightMeter, {super.key});

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
  }

  String getGrade(double heightMeter) {
    if (heightMeter < 200) return "仮入部級！";
    if (heightMeter < 500) return "新人部員級！";
    if (heightMeter < 2483) return "日吉代表級！";
    if (heightMeter < 3776) return "総代表級！";
    if (heightMeter < 8848) return "名誉代表級！";
    return "LEGEND OB級！";
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
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const StrokedText(
                            text: "結果",
                            strokeColor: Colors.black,
                            innerColor: Colors.white,
                            fontSize: 40,
                          ),
                          Text(
                            "${widget.heightMeter.toStringAsFixed(0)}m",
                            style: const TextStyle(fontSize: 60),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: ScaleTransition(
                              scale: _gradeTextController
                                  .drive(CurveTween(curve: Curves.easeInCubic))
                                  .drive(Tween(begin: 5.0, end: 1.0)),
                              child: StrokedText(
                                text: getGrade(widget.heightMeter),
                                fontSize: 50,
                                strokeColor: Colors.white,
                                innerColor: Colors.green,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "獲得単位数 $aquisitionCredits",
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.red),
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
                                  iconSize: 64,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Image.asset("assets/facebook.png"),
                                  onPressed: () async {
                                    shareFacebook();
                                  },
                                  iconSize: 64,
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
                                  iconSize: 64,
                                ),
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: StrokedText(
                              text: "記録を友達にシェアしよう！",
                              fontSize: 32,
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
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const GamePage()));
                                      },
                                    ),
                                  ))
                            ],
                          )
                        ],
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
