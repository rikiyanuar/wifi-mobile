import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';

import 'background.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? body;
  final Widget? action;
  final double paddingTop;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.body,
    this.action,
    this.paddingTop = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      padding: EdgeInsets.zero,
      widget: Column(children: [
        AppBar(
          backgroundColor: Colors.transparent,
          title: Text(title),
          elevation: 0,
          leading: leading,
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Container(
              width: 1.sw,
              color: AppColors.white,
              padding: EdgeInsets.only(top: paddingTop),
              child: body,
            ),
          ),
        )
      ]),
    );
  }
}
