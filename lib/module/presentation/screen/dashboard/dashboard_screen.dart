import 'package:flutter/material.dart';
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
                  title: const Text("Hi, Riki Yanuar"),
                  elevation: 0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
