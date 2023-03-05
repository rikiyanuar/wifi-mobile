import 'package:flutter_core/core.dart';

extension AppEnvironmentText on AppEnvironment {
  String get appName {
    switch (this) {
      case AppEnvironment.prod:
        return "Matriks";
      case AppEnvironment.dev:
      default:
        return "Matriks Dev";
    }
  }

  String get host {
    switch (this) {
      case AppEnvironment.prod:
        return "https://api.orizanet.xyz/v1";
      case AppEnvironment.dev:
      default:
        return "http://10.0.2.2/v1";
    }
  }

  String get projectId {
    switch (this) {
      case AppEnvironment.prod:
        return "63f59a147bcd5b5bcccf";
      case AppEnvironment.dev:
      default:
        return "63c7eb97650f681f6651";
    }
  }

  String get databaseId {
    switch (this) {
      case AppEnvironment.prod:
        return "63fccbdd21a0185efe1d";
      case AppEnvironment.dev:
      default:
        return "63c8b33e1502ea584d8b";
    }
  }

  String get pelangganId {
    switch (this) {
      case AppEnvironment.prod:
        return "63ff702069cc959428a2";
      case AppEnvironment.dev:
      default:
        return "63c9585d79a525d85bf0";
    }
  }

  String get bannerId {
    switch (this) {
      case AppEnvironment.prod:
        return "6400aefaea8506e7e606";
      case AppEnvironment.dev:
      default:
        return "63ccdca32b055ca23581";
    }
  }

  String get produkId {
    switch (this) {
      case AppEnvironment.prod:
        return "6400a076bdd5c6b02210";
      case AppEnvironment.dev:
      default:
        return "63cb7d762d8550435696";
    }
  }

  String get tagihanId {
    switch (this) {
      case AppEnvironment.prod:
        return "6401573729748febe3f2";
      case AppEnvironment.dev:
      default:
        return "63e676c158474816f867";
    }
  }

  String get poinId {
    switch (this) {
      case AppEnvironment.prod:
        return "64017322c154cef48928";
      case AppEnvironment.dev:
      default:
        return "63ebddaf7074b158ea24";
    }
  }

  String get transaksiId {
    switch (this) {
      case AppEnvironment.prod:
        return "6400af61ae8d56520316";
      case AppEnvironment.dev:
      default:
        return "63cd67f8607d64a62c8f";
    }
  }
}
