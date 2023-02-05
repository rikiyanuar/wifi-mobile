import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:wifiapp/module/domain/entity/cart_entity.dart';

import '../../../data/local/cart_helper.dart';
import '../../../domain/entity/produk_entity.dart';

class DetailProdukFragment {
  final bool mounted;
  final BuildContext context;
  final ProdukEntity produkEntity;
  final Uint8List bytes;

  DetailProdukFragment({
    required this.context,
    required this.produkEntity,
    required this.bytes,
    required this.mounted,
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
        footerBuilder: (_, __) => _buildFooter(),
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
          Text(
            "Detail Produk",
            style: Theme.of(context).textTheme.headline6,
          ),
        ]),
      ),
    );
  }

  Material _buildContent() {
    return Material(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.memory(
                bytes,
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(height: 12),
            Text(produkEntity.nama, style: TextStyles.s16),
            const SizedBox(height: 6),
            Text(
              JurnalAppFormats.idrMoneyFormat(
                  value: produkEntity.harga, pattern: "Rp"),
              style: TextStyles.r14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                produkEntity.deskripsi,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material _buildFooter() {
    return Material(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GeneralButton(
          text: "Tambahkan ke Keranjang",
          onTap: () => _addToCart(),
        ),
      ),
    );
  }

  _addToCart() async {
    final cartHelper = GetIt.I.get<CartHelper>();

    try {
      final res = await cartHelper.insertItem(CartItem(
        idProduk: produkEntity.id,
        hargaProduk: produkEntity.harga,
        namaProduk: produkEntity.nama,
        qtyProduk: 1,
      ));

      if (!mounted) return;
      if (res) {
        AppNavigator.pop();
        StandardToast.success(context, "Berhasil ditambahkan ke keranjang");
      } else {
        StandardToast.showClientErrorToast(context);
      }
    } catch (e) {
      StandardToast.showClientErrorToast(context);
    }
  }
}
