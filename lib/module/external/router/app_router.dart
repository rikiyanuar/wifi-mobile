import 'package:flutter_core/core.dart';
import 'package:wifiapp/module/domain/entity/pelanggan_entity.dart';

class AppRoutes {
  static const String root = MainRoutes.penjualanModule;
  static const String splashScreen = "/splashScreen";
  static const String loginScreen = "/loginScreen";
  static const String layoutScreen = "/layoutScreen";
  static const String editProfileScreen = "/editProfileScreen";
}

abstract class AppRouter {
  Future<void> goToSplashScreen();
  Future<void> goToLogin();
  Future<void> goToLayout(int? defaultIndexMenu);
  Future<void> goToEditProfile(PelangganEntity pelangganEntity);
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

  @override
  Future<void> goToEditProfile(PelangganEntity pelangganEntity) =>
      AppNavigator.pushNamed(
        AppRoutes.editProfileScreen,
        arguments: pelangganEntity,
      );
}
