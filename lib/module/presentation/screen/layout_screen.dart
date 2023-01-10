import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/provider.dart';

import '../view_model/layout_view_model.dart';

class LayoutScreen extends StatefulWidget {
  final int? defaultIndexMenu;

  const LayoutScreen({super.key, this.defaultIndexMenu});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  LayoutViewModel? _viewModel;
  int _navigationIndex = 0;

  @override
  void initState() {
    if (widget.defaultIndexMenu == null) {
      _navigationIndex = 0;
    } else {
      _navigationIndex = widget.defaultIndexMenu!;
    }
    _viewModel = LayoutViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LayoutViewModel>(
            create: (context) => _viewModel!),
      ],
      child: Consumer<LayoutViewModel>(builder: (context, viewModel, builder) {
        return Scaffold(
          bottomNavigationBar: _buildNavigation(),
        );
      }),
    );
  }

  Widget _buildNavigation() {
    return BottomNavigationBar(
      currentIndex: _navigationIndex,
      unselectedItemColor: AppColors.grey1,
      selectedItemColor: AppColors.magenta1,
      unselectedFontSize: 10,
      selectedFontSize: 10,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _navigationIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_filled),
          label: "Beranda",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          activeIcon: Icon(Icons.history_outlined),
          label: "Riwayat",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: "Akun",
        ),
      ],
    );
  }
}
