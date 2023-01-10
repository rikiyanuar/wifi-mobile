import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:wifiapp/module/external/constant/app_environment.dart';

import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform(AppEnvironment.prod),
  );
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  FlavorBaseUrlConfig(
    appEnvironment: AppEnvironment.prod,
  );

  var appConfig = FlavorConfig(
    appEnvironment: AppEnvironment.prod,
    appName: AppEnvironment.prod.appName,
    isShowBanner: false,
    childWidget: const JurnalApp(),
  );

  AppModule().injector();

  runZonedGuarded(() {
    runApp(appConfig);
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

Future<void> backgroundMessageHandler(_) async {}
