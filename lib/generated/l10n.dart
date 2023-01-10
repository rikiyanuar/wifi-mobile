// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Jurnal Penjualan`
  String get common_appTitle {
    return Intl.message(
      'Jurnal Penjualan',
      name: 'common_appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Keluar`
  String get common_signOut {
    return Intl.message(
      'Keluar',
      name: 'common_signOut',
      desc: '',
      args: [],
    );
  }

  /// `Anda yakin ingin keluar aplikasi?`
  String get common_signOutDesc {
    return Intl.message(
      'Anda yakin ingin keluar aplikasi?',
      name: 'common_signOutDesc',
      desc: '',
      args: [],
    );
  }

  /// `Info Jurnal Penjualan`
  String get common_infoTitle {
    return Intl.message(
      'Info Jurnal Penjualan',
      name: 'common_infoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ya`
  String get common_yes {
    return Intl.message(
      'Ya',
      name: 'common_yes',
      desc: '',
      args: [],
    );
  }

  /// `Tidak`
  String get common_no {
    return Intl.message(
      'Tidak',
      name: 'common_no',
      desc: '',
      args: [],
    );
  }

  /// `Sedang memuat ...`
  String get common_loading {
    return Intl.message(
      'Sedang memuat ...',
      name: 'common_loading',
      desc: '',
      args: [],
    );
  }

  /// `Mohon tunggu ...`
  String get common_please_wait {
    return Intl.message(
      'Mohon tunggu ...',
      name: 'common_please_wait',
      desc: '',
      args: [],
    );
  }

  /// `Jam`
  String get common_time_hour {
    return Intl.message(
      'Jam',
      name: 'common_time_hour',
      desc: '',
      args: [],
    );
  }

  /// `Menit`
  String get common_time_minute {
    return Intl.message(
      'Menit',
      name: 'common_time_minute',
      desc: '',
      args: [],
    );
  }

  /// `Tanggal`
  String get common_time_date {
    return Intl.message(
      'Tanggal',
      name: 'common_time_date',
      desc: '',
      args: [],
    );
  }

  /// `Hari`
  String get common_time_day {
    return Intl.message(
      'Hari',
      name: 'common_time_day',
      desc: '',
      args: [],
    );
  }

  /// `Bulan`
  String get common_time_month {
    return Intl.message(
      'Bulan',
      name: 'common_time_month',
      desc: '',
      args: [],
    );
  }

  /// `Tahun`
  String get common_time_year {
    return Intl.message(
      'Tahun',
      name: 'common_time_year',
      desc: '',
      args: [],
    );
  }

  /// `pcs`
  String get common_unit_pcs {
    return Intl.message(
      'pcs',
      name: 'common_unit_pcs',
      desc: '',
      args: [],
    );
  }

  /// `item`
  String get common_unit_item {
    return Intl.message(
      'item',
      name: 'common_unit_item',
      desc: '',
      args: [],
    );
  }

  /// `Kategori`
  String get common_category {
    return Intl.message(
      'Kategori',
      name: 'common_category',
      desc: '',
      args: [],
    );
  }

  /// `Produk`
  String get common_product {
    return Intl.message(
      'Produk',
      name: 'common_product',
      desc: '',
      args: [],
    );
  }

  /// `Pembayaran`
  String get common_payment {
    return Intl.message(
      'Pembayaran',
      name: 'common_payment',
      desc: '',
      args: [],
    );
  }

  /// `Transaksi`
  String get common_trx {
    return Intl.message(
      'Transaksi',
      name: 'common_trx',
      desc: '',
      args: [],
    );
  }

  /// `Riwayat`
  String get common_history {
    return Intl.message(
      'Riwayat',
      name: 'common_history',
      desc: '',
      args: [],
    );
  }

  /// `Pesanan`
  String get common_order {
    return Intl.message(
      'Pesanan',
      name: 'common_order',
      desc: '',
      args: [],
    );
  }

  /// `Ringkasan`
  String get common_summary {
    return Intl.message(
      'Ringkasan',
      name: 'common_summary',
      desc: '',
      args: [],
    );
  }

  /// `Urutkan`
  String get common_buttons_sort {
    return Intl.message(
      'Urutkan',
      name: 'common_buttons_sort',
      desc: '',
      args: [],
    );
  }

  /// `Simpan`
  String get common_buttons_save {
    return Intl.message(
      'Simpan',
      name: 'common_buttons_save',
      desc: '',
      args: [],
    );
  }

  /// `Ubah`
  String get common_buttons_edit {
    return Intl.message(
      'Ubah',
      name: 'common_buttons_edit',
      desc: '',
      args: [],
    );
  }

  /// `Hapus`
  String get common_buttons_delete {
    return Intl.message(
      'Hapus',
      name: 'common_buttons_delete',
      desc: '',
      args: [],
    );
  }

  /// `Tambah`
  String get common_buttons_add {
    return Intl.message(
      'Tambah',
      name: 'common_buttons_add',
      desc: '',
      args: [],
    );
  }

  /// `Batal`
  String get common_buttons_cancel {
    return Intl.message(
      'Batal',
      name: 'common_buttons_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Batalkan`
  String get common_buttons_cancelAlt {
    return Intl.message(
      'Batalkan',
      name: 'common_buttons_cancelAlt',
      desc: '',
      args: [],
    );
  }

  /// `Lanjutkan`
  String get common_buttons_continue {
    return Intl.message(
      'Lanjutkan',
      name: 'common_buttons_continue',
      desc: '',
      args: [],
    );
  }

  /// `Kosongkan`
  String get common_buttons_clear {
    return Intl.message(
      'Kosongkan',
      name: 'common_buttons_clear',
      desc: '',
      args: [],
    );
  }

  /// `Aktif`
  String get common_active {
    return Intl.message(
      'Aktif',
      name: 'common_active',
      desc: '',
      args: [],
    );
  }

  /// `Tidak Aktif`
  String get common_notActive {
    return Intl.message(
      'Tidak Aktif',
      name: 'common_notActive',
      desc: '',
      args: [],
    );
  }

  /// `Berhasil`
  String get common_success {
    return Intl.message(
      'Berhasil',
      name: 'common_success',
      desc: '',
      args: [],
    );
  }

  /// `Gagal`
  String get common_failed {
    return Intl.message(
      'Gagal',
      name: 'common_failed',
      desc: '',
      args: [],
    );
  }

  /// `Ganti Bahasa`
  String get common_selectLanguage {
    return Intl.message(
      'Ganti Bahasa',
      name: 'common_selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Pilih Bahasa`
  String get common_chooseLanguage {
    return Intl.message(
      'Pilih Bahasa',
      name: 'common_chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Saat ganti bahasa, aplikasi akan dimuat ulang`
  String get common_selectLanguageInfo {
    return Intl.message(
      'Saat ganti bahasa, aplikasi akan dimuat ulang',
      name: 'common_selectLanguageInfo',
      desc: '',
      args: [],
    );
  }

  /// `Bahasa`
  String get common_language {
    return Intl.message(
      'Bahasa',
      name: 'common_language',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get common_total {
    return Intl.message(
      'Total',
      name: 'common_total',
      desc: '',
      args: [],
    );
  }

  /// `Tunai`
  String get common_paymentMethod_cash {
    return Intl.message(
      'Tunai',
      name: 'common_paymentMethod_cash',
      desc: '',
      args: [],
    );
  }

  /// `Kartu Kredit`
  String get common_paymentMethod_creditCard {
    return Intl.message(
      'Kartu Kredit',
      name: 'common_paymentMethod_creditCard',
      desc: '',
      args: [],
    );
  }

  /// `Kartu Debit`
  String get common_paymentMethod_debitCard {
    return Intl.message(
      'Kartu Debit',
      name: 'common_paymentMethod_debitCard',
      desc: '',
      args: [],
    );
  }

  /// `Terjadi kendala, mohon coba beberapa saat lagi`
  String get common_errorMessage_clientError {
    return Intl.message(
      'Terjadi kendala, mohon coba beberapa saat lagi',
      name: 'common_errorMessage_clientError',
      desc: '',
      args: [],
    );
  }

  /// `Terjadi kendala di sistem, mohon coba beberapa saat lagi`
  String get common_errorMessage_serverError {
    return Intl.message(
      'Terjadi kendala di sistem, mohon coba beberapa saat lagi',
      name: 'common_errorMessage_serverError',
      desc: '',
      args: [],
    );
  }

  /// `Kolom harus diisi`
  String get common_errorMessage_requiredField {
    return Intl.message(
      'Kolom harus diisi',
      name: 'common_errorMessage_requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Format email salah`
  String get common_errorMessage_emailField {
    return Intl.message(
      'Format email salah',
      name: 'common_errorMessage_emailField',
      desc: '',
      args: [],
    );
  }

  /// `Kolom harus berisi angka`
  String get common_errorMessage_numberField {
    return Intl.message(
      'Kolom harus berisi angka',
      name: 'common_errorMessage_numberField',
      desc: '',
      args: [],
    );
  }

  /// `Hapus data`
  String get common_dialogs_deleteData {
    return Intl.message(
      'Hapus data',
      name: 'common_dialogs_deleteData',
      desc: '',
      args: [],
    );
  }

  /// `Apakah kamu yakin ingin menghapus data ini?`
  String get common_dialogs_deleteDataInfo {
    return Intl.message(
      'Apakah kamu yakin ingin menghapus data ini?',
      name: 'common_dialogs_deleteDataInfo',
      desc: '',
      args: [],
    );
  }

  /// `Fullscreen Mode`
  String get common_fullscreen {
    return Intl.message(
      'Fullscreen Mode',
      name: 'common_fullscreen',
      desc: '',
      args: [],
    );
  }

  /// `Rp`
  String get common_rp {
    return Intl.message(
      'Rp',
      name: 'common_rp',
      desc: '',
      args: [],
    );
  }

  /// `Bantuan`
  String get common_support {
    return Intl.message(
      'Bantuan',
      name: 'common_support',
      desc: '',
      args: [],
    );
  }

  /// `Lihat Detail`
  String get common_open_detail {
    return Intl.message(
      'Lihat Detail',
      name: 'common_open_detail',
      desc: '',
      args: [],
    );
  }

  /// `Sembunyikan`
  String get common_hide {
    return Intl.message(
      'Sembunyikan',
      name: 'common_hide',
      desc: '',
      args: [],
    );
  }

  /// `Minta Fitur Baru`
  String get common_req_feature {
    return Intl.message(
      'Minta Fitur Baru',
      name: 'common_req_feature',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
