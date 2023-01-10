import 'package:flutter/material.dart';
import 'package:wifiapp/module/external/external.dart';

class Background extends StatelessWidget {
  final Widget widget;

  const Background({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Positioned(
        left: -MediaQuery.of(context).size.width * 0.45,
        top: -MediaQuery.of(context).size.width * 0.3,
        child: Container(
          decoration: const BoxDecoration(
            color: WifiColor.primary,
            shape: BoxShape.circle,
          ),
          width: MediaQuery.of(context).size.width * 1.5,
          height: MediaQuery.of(context).size.width * 1.5,
        ),
      ),
      Positioned(
        right: -MediaQuery.of(context).size.width * 0.8,
        top: -MediaQuery.of(context).size.width * 0.6,
        child: Container(
          decoration: const BoxDecoration(
            color: WifiColor.secondary,
            shape: BoxShape.circle,
          ),
          width: MediaQuery.of(context).size.width * 1.5,
          height: MediaQuery.of(context).size.width * 1.5,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: widget,
      )
    ]);
  }
}
