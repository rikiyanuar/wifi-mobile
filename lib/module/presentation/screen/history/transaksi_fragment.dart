import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:wifiapp/module/domain/entity/transaksi_entity.dart';

class TransaksiFragment {
  final BuildContext context;
  final TransaksiEntity transaksiEntity;

  TransaksiFragment({
    required this.context,
    required this.transaksiEntity,
  });

  showBottomsheet() {
    return showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        cornerRadius: 12,
        cornerRadiusOnFullscreen: 0,
        avoidStatusBar: true,
        duration: const Duration(milliseconds: 500),
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        headerBuilder: (_, __) => _buildHeader(),
        builder: (_, __) => _buildContent(),
      );
    });
  }

  Material _buildHeader() {
    return Material(
      child: Container(
        height: kToolbarHeight,
        color: AppColors.white,
        child: Row(children: [
          IconButton(
            onPressed: () => AppNavigator.pop(),
            icon: const Icon(Icons.close),
          ),
          Expanded(
            child: Text(
              "Detail Transaksi",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.close, color: Colors.transparent),
          ),
        ]),
      ),
    );
  }

  // ignore: long-method
  Material _buildContent() {
    return Material(
      color: AppColors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Status Transaksi", style: TextStyles.m12Black3),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                transaksiEntity.status.toUpperCase(),
                style: TextStyles.b13.copyWith(color: AppColors.green1),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Nomor Transaksi", style: TextStyles.m12Black3),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                transaksiEntity.id!.toUpperCase(),
                style: TextStyles.s12.copyWith(color: AppColors.black1),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Tanggal Transaksi", style: TextStyles.m12Black3),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                JurnalAppFormats.dateFormatter(
                  pattern: "EEEE, dd MMMM yyyy - HH:mm",
                  text: transaksiEntity.tanggal,
                ),
                style: TextStyles.s12.copyWith(color: AppColors.black1),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Total Transaksi", style: TextStyles.m12Black3),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                JurnalAppFormats.idrMoneyFormat(
                  value: transaksiEntity.subTotal,
                  pattern: "Rp",
                ),
                style: TextStyles.s13.copyWith(color: AppColors.black1),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  Text("Poin pelanggan terpakai", style: TextStyles.m12Black3),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                JurnalAppFormats.idrMoneyFormat(
                    value: transaksiEntity.poinUsed),
                style: TextStyles.s13.copyWith(color: AppColors.black1),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Total bayar tunai", style: TextStyles.m12Black3),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                JurnalAppFormats.idrMoneyFormat(
                  value: transaksiEntity.cashUsed,
                  pattern: "Rp",
                ),
                style: TextStyles.s13.copyWith(color: AppColors.black1),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Daftar Pesanan", style: TextStyles.m12Black3),
            ),
            const SizedBox(height: 10),
            _buildList(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final qty = transaksiEntity.qtyProduk[index];
          final nama = transaksiEntity.namaProduk[index];
          final harga = transaksiEntity.hargaProduk[index];
          final total = qty * harga;

          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(children: [
              _buildItem(nama, harga, qty),
              Text(
                JurnalAppFormats.idrMoneyFormat(value: total, pattern: "Rp"),
                style: TextStyles.m12,
              ),
              const SizedBox(width: 16),
            ]),
          );
        },
        itemCount: transaksiEntity.idProduk.length,
        padding: const EdgeInsets.symmetric(horizontal: 17),
      ),
    );
  }

  Widget _buildItem(String nama, int harga, int qty) {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(nama, style: TextStyles.m12),
        const SizedBox(height: 2),
        Row(children: [
          Text(
            "$qty x ",
            style: TextStyles.m12Black3,
          ),
          Text(
            JurnalAppFormats.idrMoneyFormat(value: harga, pattern: "Rp"),
            style: TextStyles.m12Black3,
          ),
        ]),
        const SizedBox(height: 8),
      ]),
    );
  }
}
