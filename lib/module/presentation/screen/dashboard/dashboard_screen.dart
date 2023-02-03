import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:flutter_libraries/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:wifiapp/module/domain/entity/banner_entity.dart';
import 'package:wifiapp/module/presentation/widget/background.dart';

import '../../../data/appwrite/appwrite_helper.dart';
import '../../../domain/entity/produk_entity.dart';
import '../../view_model/dashboard/dashboard_view_model.dart';
import '../../view_model/general_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = DashboardViewModel(
      appWriteHelper: GetIt.I.get<AppWriteHelper>(),
    );
    _getAccount();
    _getBanner();
    _getProduk();
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
            floatingWidget: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              color: AppColors.purple1,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(children: [
                Text(
                  "12",
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
                      value: 120000,
                    ),
                    style: TextStyles.b16White,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Ionicons.chevron_forward_circle,
                    color: AppColors.white)
              ]),
            ),
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
          color: AppColors.white,
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

              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.memory(bytes, fit: BoxFit.fill),
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
        final data = ProdukEntity.fromJson(e.data);

        return _buildCardProduk(data);
      }).toList(),
    );
  }

  Widget _buildCardProduk(ProdukEntity data) {
    final base64Img = Uri.parse(data.foto).data;
    Uint8List bytes = base64Img!.contentAsBytes();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _showDetailProduk(data, bytes),
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
                      Text("Rp100.000", style: TextStyles.h24),
                    ],
                  ),
                ),
                Container(
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
                )
              ]),
            ),
          ),
          Container(
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
                  "01 Februari 2023",
                  style: TextStyles.s12.copyWith(color: AppColors.black1),
                ),
              ],
            ),
          )
        ]),
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
              "140.000",
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

  // ignore: long-method
  _showDetailProduk(ProdukEntity produkEntity, Uint8List bytes) {
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
        headerBuilder: (_, __) {
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
        },
        footerBuilder: (_, __) {
          return Material(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GeneralButton(
                text: "Tambahkan ke Keranjang",
                onTap: () {},
              ),
            ),
          );
        },
        builder: (_, __) {
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
        },
      );
    });
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
}
