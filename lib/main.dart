import 'package:flutter_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/utils/ssl_pinning/ssl_pinning.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:wifiapp/module/domain/entity/pelanggan_entity.dart';
import 'package:wifiapp/module/presentation/screen/splash_screen.dart';

import 'generated/l10n.dart';
import 'module/external/external.dart';
import 'module/presentation/screen/account/edit_profile_screen.dart';
import 'module/presentation/screen/layout_screen.dart';
import 'module/presentation/screen/login_screen.dart';

final instance = GetIt.instance;

class AppModule {
  static Map<String, Widget Function(BuildContext)> router = {
    MainRoutes.dioLog: (context) => HttpLogListWidget(),
    AppRoutes.splashScreen: (context) => const SplashScreen(),
    AppRoutes.loginScreen: (context) => const LoginScreen(),
    AppRoutes.layoutScreen: (context) => const LayoutScreen(),
    AppRoutes.editProfileScreen: (context) => EditProfileScreen(
        pelangganEntity:
            ModalRoute.of(context)!.settings.arguments as PelangganEntity),
  };

  injector() {
    _utilsBindings();
    _routerBindings();
  }

  _utilsBindings() {
    instance.registerLazySingleton(
      () => GetIt.I.get<DioClient>().dio,
    );
    instance.registerLazySingleton<SslPinning>(
      () => SslPinningImpl(),
    );
    instance.registerLazySingleton<ServiceHelper>(
      () => ServiceHelperImpl(
        dio: GetIt.I.get<DioClient>().dio,
      ),
    );
    instance.registerLazySingleton<JurnalSharedPreferences>(
      () => JurnalSharedPreferencesImpl(),
    );
    instance.registerLazySingleton(
      () => DioClient(
        jurnalSharedPreferences: GetIt.I.get<JurnalSharedPreferences>(),
        environment: FlavorBaseUrlConfig.instance!.appEnvironment,
        sslPinning: GetIt.I.get<SslPinning>(),
        authLogout: () => JurnalAppFunctions.handleLogout(),
        authRefreshToken: () => JurnalAppFunctions.handleLogout(),
      ),
    );
  }

  _routerBindings() {
    instance.registerLazySingleton<AppRouter>(
      () => AppRouterImpl(),
    );
  }
}

class JurnalApp extends StatefulWidget {
  const JurnalApp({Key? key}) : super(key: key);

  @override
  State<JurnalApp> createState() => _JurnalAppState();
}

class _JurnalAppState extends State<JurnalApp> {
  final GlobalKey _parentKey = GlobalKey();

  @override
  void initState() {
    _setLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      text: FlavorConfig.of(context).appEnvironment.name,
      location: BannerLocation.bottomEnd,
      visible: FlavorConfig.of(context).isShowBanner,
      child: Stack(key: _parentKey, children: [
        ScreenUtilInit(
          designSize: const Size(360, 640),
          builder: (context, _) {
            return MaterialApp(
              navigatorKey: AppNavigator.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: FlavorConfig.of(context).appName,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                fontFamily: TextStyles.fontFamily,
              ),
              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget ?? Container(),
                );
              },
              initialRoute: AppRoutes.splashScreen,
              routes: AppModule.router,
            );
          },
        ),
        _buildCheckLogButton(),
      ]),
    );
  }

  Visibility _buildCheckLogButton() {
    return Visibility(
      visible: false,
      child: DraggableFloatingActionButton(
        initialOffset: const Offset(50, 50),
        onPressed: () => AppNavigator.pushNamed(MainRoutes.dioLog),
        parentKey: _parentKey,
        child: Container(
          width: 60,
          height: 60,
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: Colors.pink.withOpacity(0.8),
            shadows: const [
              BoxShadow(
                color: ShadowColors.shadowTwo,
                offset: Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 0,
              )
            ],
          ),
          child: const Icon(
            Icons.network_check,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _setLocale() async {
    final currentLocale =
        await GetIt.I.get<JurnalSharedPreferences>().getLocale();
    await S.load(Locale(currentLocale));
  }
}
