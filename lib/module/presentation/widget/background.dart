import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:wifiapp/module/external/external.dart';

class Background extends StatelessWidget {
  final Widget widget;
  final EdgeInsets? padding;
  final double? elevation;
  final bool useClipper;
  final Widget? floatingWidget;

  const Background({
    super.key,
    required this.widget,
    this.padding,
    this.elevation,
    this.useClipper = false,
    this.floatingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      useClipper ? _buildClipper(context) : _defaultBackground(context),
      Material(
        color: Colors.transparent,
        elevation: elevation ?? 1,
        child: Padding(
          padding: padding ??
              EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: widget,
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: floatingWidget ?? Container(),
      ),
    ]);
  }

  Positioned _buildClipper(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 250,
      child: ClipPath(
        clipper: BottomWaveClipper(),
        child: _defaultBackground(context),
      ),
    );
  }

  Widget _defaultBackground(BuildContext context) {
    return Stack(children: [
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
    ]);
  }
}
