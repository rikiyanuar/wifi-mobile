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
  final bool isLoading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.body,
    this.action,
    this.paddingTop = 4,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      padding: EdgeInsets.zero,
      widget: LoadingIndicator(
        isLoading: isLoading,
        child: Column(children: [
          AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              title,
              style: TextStyles.m18.copyWith(color: AppColors.white),
            ),
            elevation: 0,
            leading: leading,
          ),
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Container(
                width: 1.sw,
                color: AppColors.white,
                padding: EdgeInsets.only(top: paddingTop),
                child: body,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
