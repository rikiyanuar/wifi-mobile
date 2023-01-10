import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:wifiapp/module/external/external.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3))
        .then((_) => GetIt.I.get<AppRouter>().goToLogin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
