import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:wifiapp/module/domain/entity/tagihan_entity.dart';

class TagihanFragment {
  final BuildContext context;
  final TagihanEntity tagihanEntity;

  TagihanFragment({
    required this.context,
    required this.tagihanEntity,
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
          snappings: [0.7, 1.0],
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
              "Detail Tagihan",
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
              child: Text("Status Tagihan", style: TextStyles.m12Black3),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _getStatus(),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Nomor Tagihan", style: TextStyles.m12Black3),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                tagihanEntity.id!.toUpperCase(),
                style: TextStyles.s12.copyWith(color: AppColors.black1),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Periode Tagihan", style: TextStyles.m12Black3),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                JurnalAppFormats.dateFormatter(
                  pattern: "MMMM yyyy",
                  text: tagihanEntity.tglTagihan,
                ),
                style: TextStyles.s12.copyWith(color: AppColors.black1),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Tanggal Pembayaran", style: TextStyles.m12Black3),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                tagihanEntity.tglBayar,
                style: TextStyles.s12.copyWith(color: AppColors.black1),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Total Tagihan", style: TextStyles.m12Black3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                JurnalAppFormats.idrMoneyFormat(
                    value: tagihanEntity.nominal, pattern: "Rp"),
                style: TextStyles.s18Black1
                    .copyWith(fontSize: MediaQuery.of(context).size.width / 10),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  _getStatus() {
    String status = tagihanEntity.status;
    if (status == "lunas") {
      return Text(
        "LUNAS",
        style: TextStyles.b14.copyWith(color: AppColors.green1),
      );
    } else {
      return Text(
        "BELUM DIBAYAR",
        style: TextStyles.b14.copyWith(color: AppColors.red1),
      );
    }
  }
}
