import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<StatefulWidget> createState() => BannerViewState();
}

class BannerViewState extends State<BannerView> {
  bool bannerIsOne = true;
  late final Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) { 
      setState(() {
        bannerIsOne = !bannerIsOne;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
          await launchUrlString("https://www.ace-compliance.com/blog/wp-content/uploads/IMG_4688.jpg");
      },
      child: Image.asset(
        bannerIsOne ? "assets/banner1.png" : "assets/banner2.png",
      ),
    );
  }
}