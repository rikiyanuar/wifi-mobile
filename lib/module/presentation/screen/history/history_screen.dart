import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/provider.dart';
import 'package:wifiapp/module/presentation/widget/custom_app_bar.dart';

import '../../view_model/history/history_view_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = HistoryViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HistoryViewModel>(
            create: (context) => _viewModel!),
      ],
      child: Consumer<HistoryViewModel>(
        builder: (context, viewModel, builder) {
          return CustomAppBar(
            title: "Riwayat",
            body: DefaultTabController(
              length: 3,
              child: Column(children: [
                _buildTabBar(),
                _buildTabView(),
              ]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.neutral40),
        ),
      ),
      child: TabBar(
        indicatorColor: AppColors.magenta1,
        indicatorWeight: 3,
        labelColor: AppColors.black3,
        labelStyle: TextStyles.m14,
        unselectedLabelStyle: TextStyles.r14,
        unselectedLabelColor: AppColors.black3,
        tabs: const [
          Tab(text: "Tagihan"),
          Tab(text: "Pembelian"),
          Tab(text: "Poin"),
        ],
      ),
    );
  }

  Widget _buildTabView() {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return const ListTile(
              dense: true,
              title: Text("Text"),
            );
          },
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Divider(height: 1),
          ),
          itemCount: 10,
        ),
      ),
    );
  }
}
