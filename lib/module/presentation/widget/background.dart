import 'package:flutter/material.dart';
import 'package:wifiapp/module/external/external.dart';

class Background extends StatelessWidget {
  final Widget widget;
  final EdgeInsets? padding;

  const Background({super.key, required this.widget, this.padding});

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Positioned(
        left: -MediaQuery.of(context).size.width * 0.45,
        top: -MediaQuery.of(context).size.width * 0.4,
        child: Container(
          decoration: const BoxDecoration(
            color: WifiColor.primary,
            shape: BoxShape.circle,
          ),
          width: MediaQuery.of(context).size.width * 1.3,
          height: MediaQuery.of(context).size.width * 1.3,
        ),
      ),
      Positioned(
        right: -MediaQuery.of(context).size.width * 0.9,
        top: -MediaQuery.of(context).size.width * 0.3,
        child: Container(
          decoration: const BoxDecoration(
            color: WifiColor.secondary,
            shape: BoxShape.circle,
          ),
          width: MediaQuery.of(context).size.width * 1.3,
          height: MediaQuery.of(context).size.width * 1.3,
        ),
      ),
      Padding(
        padding:
            padding ?? EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: widget,
      )
    ]);
  }
}
