import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';

import '../router/app_router.dart';

class JurnalAppFunctions {
  static handleLogout() async {
    await FirebaseAuth.instance.signOut();
    await GetIt.I.get<JurnalSharedPreferences>().removeAllPrefs();
    GetIt.I.get<AppRouter>().goToSplashScreen();
  }

  static handleRefreshToken() async {
    // final state = await GetIt.I.get<AuthUseCase>().authRefreshToken();
    // use dartz to handle refresh token and save new access token
  }
}
