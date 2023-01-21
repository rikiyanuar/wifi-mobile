import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/provider.dart';
import 'package:wifiapp/module/presentation/widget/background.dart';

import '../../view_model/dashboard/dashboard_view_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = DashboardViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DashboardViewModel>(
            create: (context) => _viewModel!),
      ],
      child: Consumer<DashboardViewModel>(
        builder: (context, viewModel, builder) {
          return Background(
            padding: EdgeInsets.zero,
            widget: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text("WIFI App"),
                  elevation: 0,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  height: 90,
                  child: Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("title", style: TextStyles.r11Black3),
                          const SizedBox(height: 4),
                          Text(
                            "value",
                            style: TextStyles.r13
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("title", style: TextStyles.r11Black3),
                          const SizedBox(height: 4),
                          Text(
                            "value",
                            style: TextStyles.r13
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
