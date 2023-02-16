import 'package:appwrite/appwrite.dart';
import 'package:flutter_core/core.dart';
import 'package:wifiapp/module/data/local/cart_helper.dart';
import 'package:wifiapp/module/data/local/session_helper.dart';
import 'package:wifiapp/module/domain/entity/pelanggan_entity.dart';

import '../../../data/appwrite/appwrite_helper.dart';
import '../../../domain/entity/cart_entity.dart';
import '../../../external/external.dart';
import '../general_state.dart';

class CartViewModel extends JurnalAppChangeNotifier {
  final AppWriteHelper appWriteHelper;
  final SessionHelper sessionHelper;
  final CartHelper cartHelper;
  bool isLoading = false;
  CartEntity? cartEntity;
  int poin = 0;

  String _nama = "";

  CartViewModel({
    required this.cartHelper,
    required this.appWriteHelper,
    required this.sessionHelper,
  });

  Future<GeneralState> getCart() async {
    try {
      _isLoading(true);
      final response = await cartHelper.getAll();
      cartEntity = response;

      return GeneralSuccessState();
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> getPelanggan() async {
    try {
      _isLoading(true);
      final pelangganId = await sessionHelper.getPelangganId();
      final response = await appWriteHelper.getDocuments(
        AppWriteConstant.pelangganId,
        pelangganId,
      );
      final pelanggan = PelangganEntity.fromJson(response.data);
      poin = pelanggan.poin;
      _nama = pelanggan.nama;

      return GeneralSuccessState();
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> beli(int used, int cash) async {
    try {
      _isLoading(true);
      final pelangganId = await sessionHelper.getPelangganId();
      await appWriteHelper.addDocuments(AppWriteConstant.transaksiId, data: {
        "pelangganId": pelangganId,
        "status": "dipesan",
        "totalQty": cartEntity!.totalQty,
        "subTotal": cartEntity!.subTotal,
        "namaProduk": cartEntity!.namaProduk,
        "qtyProduk": cartEntity!.qtyProduk,
        "hargaProduk": cartEntity!.hargaProduk,
        "idProduk": cartEntity!.idProduk,
        "tanggal": DateTime.now().toIso8601String(),
        "poinUsed": used,
        "cashUsed": cash,
        "nama": _nama,
      });

      return _removeCart();
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> _removeCart() async {
    try {
      _isLoading(true);
      if (await cartHelper.removeCart()) {
        return GeneralSuccessState();
      } else {
        return GeneralErrorState();
      }
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  _isLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
