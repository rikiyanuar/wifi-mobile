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
        FlavorBaseUrlConfig.instance!.appEnvironment.pelangganId,
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
      final userId = await sessionHelper.getUserId();

      /// insert to trx
      await appWriteHelper.addDocuments(
          FlavorBaseUrlConfig.instance!.appEnvironment.transaksiId,
          data: {
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

      /// deduct poin if used > 0
      if (used > 0) {
        await appWriteHelper.updateDocument(
          collectionId:
              FlavorBaseUrlConfig.instance!.appEnvironment.pelangganId,
          documentId: pelangganId,
          data: {"poin": poin - used},
        );

        await appWriteHelper.addDocuments(
            FlavorBaseUrlConfig.instance!.appEnvironment.poinId,
            data: {
              "userId": userId,
              "pelangganId": pelangganId,
              "nama": _nama,
              "tanggal": DateTime.now().toIso8601String(),
              "nominal": -used,
            });
      }

      return _removeCart();
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> changeQty(int index, int qty) async {
    try {
      _isLoading(true);
      final id = cartEntity!.idProduk![index];
      final nama = cartEntity!.namaProduk![index];
      final harga = cartEntity!.hargaProduk![index];

      if (await cartHelper.insertItem(CartItem(
        idProduk: id,
        hargaProduk: harga,
        namaProduk: nama,
        qtyProduk: qty,
      ))) {
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

  Future<GeneralState> removeItem(int index) async {
    try {
      _isLoading(true);
      final id = cartEntity!.idProduk![index];
      final nama = cartEntity!.namaProduk![index];
      final harga = cartEntity!.hargaProduk![index];
      final qty = cartEntity!.qtyProduk![index];

      if (await cartHelper.removeItem(CartItem(
        idProduk: id,
        hargaProduk: harga,
        namaProduk: nama,
        qtyProduk: qty,
      ))) {
        return getCart();
      } else {
        return GeneralErrorState();
      }
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
