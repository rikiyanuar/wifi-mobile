import 'package:flutter_core/core.dart';

class AppRoutes {
  static const String root = MainRoutes.penjualanModule;
  static const String splashScreen = "/splashScreen";
  static const String loginScreen = "/loginScreen";
  static const String layoutScreen = "/layoutScreen";
}

abstract class AppRouter {
  Future<void> goToSplashScreen();
  Future<void> goToLogin();
  Future<void> goToLayout(int? defaultIndexMenu);
}

class AppRouterImpl extends AppRouter {
  @override
  Future<void> goToLayout(int? defaultIndexMenu) =>
      AppNavigator.pushNamedAndRemoveUntil(
        AppRoutes.layoutScreen,
        arguments: defaultIndexMenu,
      );

  @override
  Future<void> goToSplashScreen() =>
      AppNavigator.pushNamedAndRemoveUntil(AppRoutes.splashScreen);

  @override
  Future<void> goToLogin() =>
      AppNavigator.pushNamedAndRemoveUntil(AppRoutes.loginScreen);
}
