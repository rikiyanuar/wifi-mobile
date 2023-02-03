import 'package:flutter_core/core.dart';
import 'package:wifiapp/module/domain/entity/poin_entity.dart';

import '../../../domain/entity/tagihan_entity.dart';

class HistoryViewModel extends JurnalAppChangeNotifier {
  List<TagihanEntity> listTagihan = [
    TagihanEntity(
      bulan: "Juli",
      tahun: 2022,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
    TagihanEntity(
      bulan: "Agustus",
      tahun: 2022,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
    TagihanEntity(
      bulan: "September",
      tahun: 2022,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
    TagihanEntity(
      bulan: "Oktober",
      tahun: 2022,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
    TagihanEntity(
      bulan: "November",
      tahun: 2022,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
    TagihanEntity(
      bulan: "Desember",
      tahun: 2022,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
    TagihanEntity(
      bulan: "Januari",
      tahun: 2023,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
    TagihanEntity(
      bulan: "Februari",
      tahun: 2023,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
    TagihanEntity(
      bulan: "Maret",
      tahun: 2023,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
    TagihanEntity(
      bulan: "April",
      tahun: 2023,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
    TagihanEntity(
      bulan: "Mei",
      tahun: 2023,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
    TagihanEntity(
      bulan: "Juni",
      tahun: 2023,
      isLunas: true,
      tglLunas: "",
      nominal: 100000,
    ),
  ];

  List<PoinEntity> listPoin = [
    PoinEntity(tanggal: "12 Desember 2022 - 20:12", nominal: 30000),
    PoinEntity(tanggal: "14 Desember 2022 - 20:12", nominal: 30000),
    PoinEntity(tanggal: "16 Desember 2022 - 20:12", nominal: 30000),
    PoinEntity(tanggal: "17 Desember 2022 - 20:12", nominal: 30000),
    PoinEntity(tanggal: "18 Desember 2022 - 20:12", nominal: 30000),
    PoinEntity(tanggal: "19 Desember 2022 - 20:12", nominal: 30000),
    PoinEntity(tanggal: "01 Januari 2023 - 20:12", nominal: 30000),
    PoinEntity(tanggal: "12 Januar 2023 - 20:12", nominal: 30000),
  ];
}
