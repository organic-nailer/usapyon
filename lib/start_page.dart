import 'package:flutter/material.dart';
import 'package:usapyon/area_restrict_view.dart';
import 'package:usapyon/pyon_button.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AreaRestrictView(
        child: SizedBox(
          width: 300,
          child: PyonButton(
            text: "スタート",
          ),
        ),
      ),
    );
  }
}
