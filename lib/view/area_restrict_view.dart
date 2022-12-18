import 'package:flutter/material.dart';

class AreaRestrictView extends StatelessWidget {
  final Widget child;
  const AreaRestrictView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final aspect = constraints.biggest.aspectRatio;
        if (aspect > 9 / 16) {
          return Center(
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: child,
            ),
          );
        } else {
          return child;
        }
      },
    );
  }
}
