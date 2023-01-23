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
        labelStyle: TextStyles.m13,
        unselectedLabelStyle: TextStyles.r13,
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
            final data = _viewModel!.listTagihan[index];

            return ListTile(
              dense: true,
              title: Row(children: [
                Expanded(
                  child: Text(data.bulan, style: TextStyles.r13),
                ),
                Text(
                  JurnalAppFormats.idrMoneyFormat(
                      value: data.nominal, pattern: "Rp"),
                  style: TextStyles.s13,
                ),
              ]),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.magenta1,
              ),
              onTap: () {},
            );
          },
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Divider(height: 1),
          ),
          itemCount: _viewModel!.listTagihan.length,
        ),
      ),
    );
  }
}
