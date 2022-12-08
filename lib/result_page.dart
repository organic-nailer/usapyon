import 'package:flutter/material.dart';
import 'package:usapyon/pyon_button.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<StatefulWidget> createState() => ResultPageState();
}

class ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              color: Colors.white.withOpacity(0.5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("結果"),
                  Text("200m"),
                  Text("日吉キャンパス級！"),
                  Text("獲得単位数 211"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share),
                      Icon(Icons.share_arrival_time),
                      Icon(Icons.chat)
                    ],
                  ),
                  Text("記録を友達にシェアしよう！"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [PyonButton(), PyonButton()],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
