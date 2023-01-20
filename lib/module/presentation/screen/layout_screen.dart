import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:wifiapp/module/presentation/screen/dashboard/dashboard_screen.dart';

import 'account/account_screen.dart';
import 'history/history_screen.dart';

class LayoutScreen extends StatefulWidget {
  final int? defaultIndexMenu;

  const LayoutScreen({super.key, this.defaultIndexMenu});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _navigationIndex = 0;

  @override
  void initState() {
    if (widget.defaultIndexMenu == null) {
      _navigationIndex = 0;
    } else {
      _navigationIndex = widget.defaultIndexMenu!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: _buildNavigation(),
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

  Widget _getBody() {
    if (_navigationIndex == 0) {
      return const DashboardScreen();
    } else if (_navigationIndex == 1) {
      return const HistoryScreen();
    } else if (_navigationIndex == 2) {
      return AccountScreen(changeIndex: _changeIndex);
    }

    return const DashboardScreen();
  }

  _changeIndex(int value) {
    setState(() {
      _navigationIndex = value;
    });
  }
}
