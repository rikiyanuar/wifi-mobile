import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:flutter_libraries/provider.dart';
import 'package:wifiapp/module/external/external.dart';

import '../../data/appwrite/appwrite_helper.dart';
import '../view_model/general_state.dart';
import '../view_model/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = SplashViewModel(
      appWriteHelper: GetIt.I.get<AppWriteHelper>(),
    );

    _checkSession();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel!,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [WifiColor.primary, WifiColor.secondary],
              center: Alignment.topLeft,
              radius: 1.6,
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Text(
            "WIFI App",
            style: TextStyles.h20.copyWith(color: WifiColor.accent2),
          ),
        ),
      ),
    );
  }

  _checkSession() async {
    final state = await _viewModel!.checkSession();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    } else if (state is GeneralSuccessState) {
      GetIt.I.get<AppRouter>().goToLayout(null);
    } else if (state is GeneralErrorSpecificState) {
      GetIt.I.get<AppRouter>().goToLogin();
    }
  }
}
