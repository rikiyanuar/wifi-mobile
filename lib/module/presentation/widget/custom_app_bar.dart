import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';

class CustomAppBar extends StatelessWidget {
  final AppBar? appBar;
  final String title;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final Widget? body;
  final Widget? action;
  final Color? backgroundColor;
  final double? elevation;

  CustomAppBar({
    Key? key,
    this.appBar,
    required this.title,
    this.leading,
    this.bottom,
    this.body,
    this.action,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar ??
          AppBar(
            title: Text(title),
            leading: leading ??
                IconButton(
                  onPressed: () => AppNavigator.pop(),
                  icon: const Icon(Ionicons.chevron_back_outline),
                ),
            bottom: bottom,
            elevation: elevation,
            backgroundColor: backgroundColor,
            actions: [
              action ??
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Ionicons.help_circle_outline),
                  ),
            ],
          ),
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: Container(
          width: 1.sw,
          color: AppColors.white,
          child: body,
        ),
      ),
    );
  }
}
