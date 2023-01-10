import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:wifiapp/module/external/external.dart';

import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  FlavorBaseUrlConfig(
    appEnvironment: AppEnvironment.dev,
  );

  var appConfig = FlavorConfig(
    appEnvironment: AppEnvironment.dev,
    appName: AppEnvironment.dev.appName,
    isShowBanner: true,
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
