import 'package:flutter_core/core.dart';

class AppRoutes {
  static const String root = MainRoutes.penjualanModule;
}

abstract class AppRouter {
  Future<void> goToSplashScreen();
  Future<void> goToLayout(int? defaultIndexMenu);
}

class AppRouterImpl extends AppRouter {
  @override
  Future<void> goToLayout(int? defaultIndexMenu) =>
      AppNavigator.pushNamedAndRemoveUntil(
        AppRoutes.root,
        arguments: defaultIndexMenu,
      );

  @override
  Future<void> goToSplashScreen() =>
      AppNavigator.pushNamedAndRemoveUntil(MainRoutes.splashScreen);
}
