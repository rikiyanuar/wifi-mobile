import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:flutter_libraries/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/local/cart_helper.dart';
import '../../view_model/dashboard/cart_view_model.dart';
import '../../view_model/general_state.dart';
import '../../widget/background.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = CartViewModel(
      cartHelper: GetIt.I.get<CartHelper>(),
    );
    _getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel!,
      child: Consumer<CartViewModel>(
        builder: (context, viewModel, builder) {
          return Background(
            padding: EdgeInsets.zero,
            floatingWidget: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(16),
              child: GeneralButton(
                text: "Beli",
                onTap: () => {},
              ),
            ),
            widget: Column(children: [
              AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  "Keranjang",
                  style: TextStyles.m18.copyWith(color: AppColors.white),
                ),
                elevation: 0,
              ),
              Expanded(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      "assets/images/bc_convetti.svg",
                      width: 1.sw,
                    ),
                    Column(children: [
                      _buildPoin(),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                          child: Container(
                            width: 1.sw,
                            color: AppColors.white,
                            child: _buildBody(),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              )
            ]),
          );
        },
      ),
    );
  }

  Widget _buildPoin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(children: [
        const Icon(
          Icons.stars,
          color: AppColors.white,
          size: 32,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Poin yang dapat dipakai 50% dari total belanja",
                style: TextStyles.m11.copyWith(
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 6),
              Row(children: [
                Text(
                  "Poin Anda:",
                  style: TextStyles.r14White.copyWith(fontSize: 13),
                ),
                const SizedBox(width: 4),
                Text(
                  "140.000",
                  style: TextStyles.s14.copyWith(color: AppColors.white),
                ),
              ])
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Ionicons.bag_handle_outline,
                size: 18,
                color: AppColors.black3,
              ),
            ),
            Expanded(
              child: Text(
                "Rincian Pesanan",
                style: TextStyles.s13.copyWith(color: AppColors.black3),
              ),
            ),
          ]),
        ),
        _buildList(),
        Container(height: 6, color: AppColors.neutral10),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Ionicons.calculator_outline,
                size: 18,
                color: AppColors.black3,
              ),
            ),
            Expanded(
              child: Text(
                "Ringkasan Pembayaran",
                style: TextStyles.s13.copyWith(color: AppColors.black3),
              ),
            ),
          ]),
        ),
        _buildRingkasan(),
      ]),
    );
  }

  Widget _buildList() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final qty = _viewModel!.cartEntity!.qtyProduk![index];
          final nama = _viewModel!.cartEntity!.namaProduk![index];
          final harga = _viewModel!.cartEntity!.hargaProduk![index];
          final total = qty * harga;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                color: AppColors.magenta1,
              ),
              _buildItem(nama, harga, qty),
              Text(
                JurnalAppFormats.idrMoneyFormat(value: total, pattern: "Rp"),
                style: TextStyles.m12,
              ),
              const SizedBox(width: 16),
            ]),
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: _viewModel!.cartEntity == null
            ? 0
            : _viewModel!.cartEntity!.idProduk!.length,
      ),
    );
  }

  Widget _buildItem(String nama, int harga, int qty) {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(nama, style: TextStyles.s12),
        const SizedBox(height: 2),
        Text(
          JurnalAppFormats.idrMoneyFormat(value: harga, pattern: "Rp"),
          style: TextStyles.m12Black3,
        ),
        const SizedBox(height: 8),
        Row(children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Icon(
              Icons.remove_circle,
              size: 18,
              color: qty <= 1 ? AppColors.neutral40 : AppColors.black3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "$qty",
              style: TextStyles.b14.copyWith(color: AppColors.black2),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: const Icon(
              Icons.add_circle,
              size: 18,
              color: AppColors.black3,
            ),
          )
        ]),
      ]),
    );
  }

  Widget _buildRingkasan() {
    if (_viewModel!.cartEntity == null) {
      return const SizedBox.shrink();
    }

    final half = _viewModel!.cartEntity!.subTotal! / 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        Row(children: [
          Text("Total belanja", style: TextStyles.r12),
          const Spacer(),
          Text(
            JurnalAppFormats.idrMoneyFormat(
              value: _viewModel!.cartEntity!.subTotal!,
              pattern: "Rp",
            ),
            style: TextStyles.m12,
          ),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Text("Total poin terpakai (50%)", style: TextStyles.r12),
          const Spacer(),
          Text(
            JurnalAppFormats.idrMoneyFormat(
              value: half.toInt(),
              pattern: "-Rp",
            ),
            style: TextStyles.m12,
          ),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Text("Total bayar tunai", style: TextStyles.r12),
          const Spacer(),
          Text(
            JurnalAppFormats.idrMoneyFormat(
              value: half.toInt(),
              pattern: "Rp",
            ),
            style: TextStyles.s14,
          ),
        ])
      ]),
    );
  }

  _getCartData() async {
    final state = await _viewModel!.getCart();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    }
  }
}
