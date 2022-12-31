import 'package:flutter/material.dart';
import 'package:usapyon/page/start_page.dart';
import 'package:usapyon/view/area_restrict_view.dart';
import 'package:usapyon/view/pyon_button.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: AreaRestrictView(
        child: Center(
          child: Stack(
            children: [
              Image.asset("assets/howtoplay.jpg"),
              Positioned(
                top: 16,
                right: 16,
                child: PyonButton(
                  height: 40,
                  text: "戻る",
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const StartPage()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
