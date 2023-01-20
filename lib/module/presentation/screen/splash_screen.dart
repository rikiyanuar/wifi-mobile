import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:flutter_libraries/provider.dart';
import 'package:wifiapp/module/external/external.dart';

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
    _viewModel = SplashViewModel();

    _checkSession();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel!,
      child: Scaffold(
        backgroundColor: WifiColor.primary,
        body: Stack(children: [
          Positioned(
            left: MediaQuery.of(context).size.width * 0.5,
            top: -MediaQuery.of(context).size.width * 0.2,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(45 / 360),
              child: Container(
                decoration: const BoxDecoration(
                  color: WifiColor.secondary,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      spreadRadius: 30,
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width * 1.5,
                height: MediaQuery.of(context).size.width * 1.5,
              ),
            ),
          ),
          Center(
            child: Text("WIFI APP", style: TextStyles.b16White),
          )
        ]),
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
