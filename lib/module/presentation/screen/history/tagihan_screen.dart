import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:wifiapp/module/domain/entity/tagihan_entity.dart';
import '../../../external/external.dart';

class TagihanScreen extends StatefulWidget {
  final TagihanEntity tagihanEntity;

  const TagihanScreen({super.key, required this.tagihanEntity});

  @override
  State<TagihanScreen> createState() => _TagihanScreenState();
}

class _TagihanScreenState extends State<TagihanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WifiColor.primary,
      body: Stack(children: [
        Positioned(
          left: MediaQuery.of(context).size.width * 0.2,
          top: -MediaQuery.of(context).size.width * 0.4,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xff1ebbf3),
              shape: BoxShape.circle,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.4,
          top: MediaQuery.of(context).size.width * 0.05,
          child: Container(
            decoration: const BoxDecoration(
              color: WifiColor.secondary,
              shape: BoxShape.circle,
            ),
            width: MediaQuery.of(context).size.width * 2.4,
            height: MediaQuery.of(context).size.width * 2.4,
          ),
        ),
        Column(children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
              )
            ],
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: _buildCard(),
          ),
        ]),
      ]),
    );
  }

  Widget _buildCard() {
    return ClipPath(
      clipper: TicketClipper(),
      child: Stack(alignment: Alignment.center, children: [
        Container(
          color: AppColors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: _buildBody(),
        ),
        Positioned(
          right: 24,
          top: 90,
          child: RotatedBox(
            quarterTurns: 45,
            child: _buildLunas(),
          ),
          // child: RotationTransition(
          //   turns: const AlwaysStoppedAnimation(-30 / 360),
          //   child: _buildLunas(),
          // ),
        ),
      ]),
    );
  }

  Container _buildLunas() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: Colors.green.shade100,
          width: 6,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(
        "LUNAS",
        style: TextStyles.h24.copyWith(
          color: Colors.green.shade100,
          fontSize: 48,
          letterSpacing: 2,
        ),
      ),
    );
  }

  // ignore: long-method
  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text(
            "TAGIHAN ANDA",
            style: TextStyles.b13.copyWith(color: AppColors.neutral70),
          ),
        ),
        const SizedBox(height: 36),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("Nomor Tagihan", style: TextStyles.m12Black3),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "gbs6eft7s6eft8se6t".toUpperCase(),
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
            "${widget.tagihanEntity.bulan} ${widget.tagihanEntity.tahun}",
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
            "18 Juli 2022 - 19:20",
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
                value: widget.tagihanEntity.nominal, pattern: "Rp"),
            style: TextStyles.s18Black1
                .copyWith(fontSize: MediaQuery.of(context).size.width / 10),
          ),
        ),
      ],
    );
  }
}
