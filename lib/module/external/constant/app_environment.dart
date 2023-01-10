import 'package:flutter_core/core.dart';

extension AppEnvironmentText on AppEnvironment {
  String get appName {
    switch (this) {
      case AppEnvironment.dev:
        return "Jurnal Penjualan Dev";
      case AppEnvironment.stag:
        return "Jurnal Penjualan Stag";
      case AppEnvironment.prod:
        return "Jurnal Penjualan";
      default:
        return "";
    }
  }

  String get penjualanUrl {
    switch (this) {
      case AppEnvironment.dev:
      case AppEnvironment.stag:
        // return "http://192.168.0.4:3000";
        return "https://dev-api-penjualan.jurnalapp.com";
      case AppEnvironment.prod:
        return "https://dev-api-penjualan.jurnalapp.com";
      default:
        return "";
    }
  }
}
