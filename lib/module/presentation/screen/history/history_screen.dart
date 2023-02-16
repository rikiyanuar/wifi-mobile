import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:flutter_libraries/provider.dart';
import 'package:wifiapp/module/data/appwrite/appwrite_helper.dart';
import 'package:wifiapp/module/domain/entity/poin_entity.dart';
import 'package:wifiapp/module/domain/entity/tagihan_entity.dart';
import 'package:wifiapp/module/presentation/widget/custom_app_bar.dart';

import '../../../data/local/session_helper.dart';
import '../../../domain/entity/transaksi_entity.dart';
import '../../view_model/general_state.dart';
import '../../view_model/history/history_view_model.dart';
import 'tagihan_fragment.dart';
import 'transaksi_fragment.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = HistoryViewModel(
      appWriteHelper: GetIt.I.get<AppWriteHelper>(),
      sessionHelper: GetIt.I.get<SessionHelper>(),
    );
    _getPoin();
    _getTagihan();
    _getTrx();
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
        child: TabBarView(children: [
          _buildListTagihan(),
          _buildListTrx(),
          _buildListPoin(),
        ]),
      ),
    );
  }

  Widget _buildListTagihan() {
    return RefreshIndicator(
      onRefresh: () => _getTagihan(),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final data = TagihanEntity.fromJson({
            ..._viewModel!.listTagihan[index].data,
            "id": _viewModel!.listTagihan[index].$id,
          });

          return ListTile(
            dense: true,
            title: Row(children: [
              Expanded(
                child: Text(
                  JurnalAppFormats.dateFormatter(
                    pattern: "MMMM yyyy",
                    text: data.tglTagihan,
                  ),
                  style: TextStyles.r13,
                ),
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
            onTap: () => TagihanFragment(
              context: context,
              tagihanEntity: data,
            ).showBottomsheet(),
          );
        },
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Divider(height: 1),
        ),
        itemCount: _viewModel!.listTagihan.length,
      ),
    );
  }

  Widget _buildListPoin() {
    return RefreshIndicator(
      onRefresh: () => _getPoin(),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final data = PoinEntity.fromJson(_viewModel!.listPoin[index].data);

          return ListTile(
            dense: true,
            title: Text(
              JurnalAppFormats.dateFormatter(
                pattern: "EEEE, dd MMM yyyy - HH:mm",
                date: DateTime.parse(data.tanggal).toLocal(),
              ),
              style: TextStyles.r13,
            ),
            trailing: Text(
              JurnalAppFormats.idrMoneyFormat(value: data.nominal),
              style: TextStyles.s13,
            ),
          );
        },
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Divider(height: 1),
        ),
        itemCount: _viewModel!.listPoin.length,
      ),
    );
  }

  Widget _buildListTrx() {
    return RefreshIndicator(
      onRefresh: () => _getTrx(),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final data = TransaksiEntity.fromJson({
            ..._viewModel!.listTrx[index].data,
            "id": _viewModel!.listTrx[index].$id,
          });

          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => TransaksiFragment(
              context: context,
              transaksiEntity: data,
            ).showBottomsheet(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nomor Transaksi",
                        style: TextStyles.r11Black3,
                      ),
                      Text(
                        data.id!.toUpperCase(),
                        style: TextStyles.r12,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data.status.toUpperCase(),
                        style: TextStyles.m11.copyWith(
                          color: AppColors.green1,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  JurnalAppFormats.idrMoneyFormat(
                      value: data.subTotal, pattern: "Rp"),
                  style: TextStyles.s13,
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.magenta1,
                )
              ]),
            ),
          );
        },
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Divider(height: 1),
        ),
        itemCount: _viewModel!.listTrx.length,
      ),
    );
  }

  _getPoin() async {
    final state = await _viewModel!.getPoin();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    }
  }

  _getTagihan() async {
    final state = await _viewModel!.getTagihan();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    }
  }

  _getTrx() async {
    final state = await _viewModel!.getTrx();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    }
  }
}
