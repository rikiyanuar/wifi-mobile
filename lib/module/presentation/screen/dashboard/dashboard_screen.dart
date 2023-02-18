import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:flutter_libraries/provider.dart';
import 'package:wifiapp/module/domain/entity/banner_entity.dart';
import 'package:wifiapp/module/external/external.dart';
import 'package:wifiapp/module/presentation/widget/background.dart';

import '../../../data/appwrite/appwrite_helper.dart';
import '../../../data/local/cart_helper.dart';
import '../../../domain/entity/produk_entity.dart';
import '../../view_model/dashboard/dashboard_view_model.dart';
import '../../view_model/general_state.dart';
import 'detail_produk_fragment.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardViewModel? _viewModel;

  DateTime get _getNextBill {
    final bill = DateTime.parse(_viewModel!.tagihanEntity!.tglTagihan);
    final nextBill = DateTime(bill.year, bill.month + 1, bill.day);

    return nextBill;
  }

  @override
  void initState() {
    _viewModel = DashboardViewModel(
      appWriteHelper: GetIt.I.get<AppWriteHelper>(),
      cartHelper: GetIt.I.get<CartHelper>(),
    );
    _getAccount();
    _getBanner();
    _getProduk();
    _getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel!,
      child: Consumer<DashboardViewModel>(
        builder: (context, viewModel, builder) {
          return Background(
            padding: EdgeInsets.zero,
            elevation: 0,
            useClipper: true,
            floatingWidget: viewModel.cartEntity == null ? null : _buildCart(),
            widget: Column(children: [
              AppBar(
                backgroundColor: Colors.transparent,
                title: const Text("WIFI App"),
                elevation: 0,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: SingleChildScrollView(
                    child: _buildBody(),
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }

  Widget _buildCart() {
    if (_viewModel!.cartEntity!.totalItem == 0) {
      return Container();
    }
    final cart = _viewModel!.cartEntity!;
    final totalItem = cart.totalQty;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => GetIt.I.get<AppRouter>().goToCart().then((_) => _getCart()),
      child: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: AppColors.purple1,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(children: [
          Text(
            "$totalItem",
            style: TextStyles.b16White,
          ),
          Text(" item", style: TextStyles.r14White),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 20,
            width: 1.5,
            color: Colors.white,
          ),
          Expanded(
            child: Text(
              JurnalAppFormats.idrMoneyFormat(
                value: cart.subTotal!,
              ),
              style: TextStyles.b16White,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Ionicons.chevron_forward_circle, color: AppColors.white)
        ]),
      ),
    );
  }

  Column _buildBody() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildHeader(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: _buildCard(),
      ),
      ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Container(
          width: 1.sw,
          color: _viewModel!.listBanner.isNotEmpty
              ? AppColors.white
              : Colors.transparent,
          padding: const EdgeInsets.only(bottom: 60),
          child: _buildBackdrop(),
        ),
      ),
    ]);
  }

  Column _buildBackdrop() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Visibility(
        visible: _viewModel!.listBanner.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text("Informasi", style: TextStyles.s14),
        ),
      ),
      Visibility(
        visible: _viewModel!.listBanner.isNotEmpty,
        child: Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: CarouselSlider(
            items: _viewModel!.listBanner.map((e) {
              final data = BannerEntity.fromJson(e.data);
              final base64Img = Uri.parse(data.banner).data;
              Uint8List bytes = base64Img!.contentAsBytes();

              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  if (data.url.isNotEmpty) {
                    final uri = Uri.parse(data.url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  }
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.memory(bytes, fit: BoxFit.fill),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              aspectRatio: 2.4,
            ),
          ),
        ),
      ),
      Visibility(
        visible: _viewModel!.listProduk.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Rekomendasi untuk anda",
            style: TextStyles.s14,
          ),
        ),
      ),
      Visibility(
        visible: _viewModel!.listProduk.isNotEmpty,
        child: _buildGridview(),
      )
    ]);
  }

  GridView _buildGridview() {
    return GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.8,
      children: _viewModel!.listProduk.map((e) {
        final data = ProdukEntity.fromJson({...e.data, "id": e.$id});

        return _buildCardProduk(data);
      }).toList(),
    );
  }

  Widget _buildCardProduk(ProdukEntity data) {
    final base64Img = Uri.parse(data.foto).data;
    Uint8List bytes = base64Img!.contentAsBytes();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        await DetailProdukFragment(
          mounted: mounted,
          context: context,
          bytes: bytes,
          produkEntity: data,
        ).showBottomsheet();
        _getCart();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.neutral20),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.4,
            alignment: Alignment.center,
            child: Image.memory(bytes, fit: BoxFit.contain),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    data.nama,
                    style: TextStyles.s12.copyWith(
                      color: AppColors.neutral70,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    JurnalAppFormats.idrMoneyFormat(
                      value: data.harga,
                      pattern: "Rp",
                    ),
                    style: TextStyles.r12.copyWith(
                      color: AppColors.neutral70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildCard() {
    if (_viewModel!.tagihanEntity == null) {
      return const SizedBox.shrink();
    }

    final tagihan = _viewModel!.tagihanEntity == null
        ? "-"
        : JurnalAppFormats.idrMoneyFormat(
            value: _viewModel!.tagihanEntity!.nominal, pattern: "Rp");

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        width: double.infinity,
        height: 120,
        color: AppColors.white,
        child: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tagihan Anda",
                        style: TextStyles.m11.copyWith(color: AppColors.black3),
                      ),
                      Text(tagihan, style: TextStyles.h24),
                    ],
                  ),
                ),
                Visibility(
                  visible: _viewModel!.tagihanEntity!.status != "belumBayar",
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.green1,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(
                      "Sudah Lunas",
                      style: TextStyles.m11.copyWith(color: AppColors.white),
                    ),
                  ),
                )
              ]),
            ),
          ),
          _buildCardFooter()
        ]),
      ),
    );
  }

  Container _buildCardFooter() {
    return _viewModel!.tagihanEntity!.status == "belumBayar"
        ? Container(
            color: AppColors.neutral20,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jatuh Tempo",
                  style: TextStyles.m12.copyWith(color: AppColors.black1),
                ),
                Text(
                  _viewModel!.tagihanEntity!.jatuhTempo,
                  style: TextStyles.s12.copyWith(color: AppColors.black1),
                ),
              ],
            ),
          )
        : Container(
            color: AppColors.neutral20,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tagihan Berikutnya",
                  style: TextStyles.m12.copyWith(color: AppColors.black1),
                ),
                Text(
                  JurnalAppFormats.dateFormatter(
                    date: _getNextBill,
                    pattern: "dd MMMM yyyy",
                  ),
                  style: TextStyles.s12.copyWith(color: AppColors.black1),
                ),
              ],
            ),
          );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, ${_viewModel!.nama}",
                style: TextStyles.m14.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 4),
              Text(
                _viewModel!.nohp,
                style: TextStyles.l14White,
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(children: [
            const SizedBox(width: 12),
            Text(
              JurnalAppFormats.idrMoneyFormat(value: _viewModel!.poin),
              style: TextStyles.s14.copyWith(color: AppColors.black10),
            ),
            const SizedBox(width: 6),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.neutral20,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(1),
              child: const Icon(
                Icons.stars,
                color: AppColors.magenta1,
                size: 28,
              ),
            )
          ]),
        )
      ]),
    );
  }

  _getBanner() async {
    final state = await _viewModel!.getBanner();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    }
  }

  _getProduk() async {
    final state = await _viewModel!.getProduk();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    }
  }

  _getAccount() async {
    final state = await _viewModel!.getAccount();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    }
  }

  _getCart() async {
    final state = await _viewModel!.getCart();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    }
  }
}
