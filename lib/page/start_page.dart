import 'package:flutter/material.dart';
import 'package:usapyon/page/game_page.dart';
import 'package:usapyon/view/area_restrict_view.dart';
import 'package:usapyon/view/banner_view.dart';
import 'package:usapyon/view/pyon_button.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StatefulWidget> createState() => StartPageState();
}

class StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController rabbitController;

  @override
  void initState() {
    super.initState();
    rabbitController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    rabbitController.repeat(reverse: true);
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
                child: Stack(
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
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset("assets/title.png"),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(64.0),
                        child: SlideTransition(
                            position: rabbitController
                                .drive(CurveTween(curve: Curves.easeInOut))
                                .drive(Tween(
                                    begin: const Offset(0, -0.05),
                                    end: const Offset(0, 0.05))),
                            child: Image.asset(
                              "assets/rabbit_title.png",
                              height: 300,
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PyonButton(
                            text: "スタート",
                            onPressed: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (_) => const GamePage()));
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PyonButton(
                          text: "ライセンス",
                          onPressed: () {
                            showAboutDialog(context: context);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PyonButton(text: "インフォメーション"),
                      )
                    ],
                  ),
                )
                      ],
                    ),
              ),
              const BannerView()
            ],
          )),
    );
  }
}
