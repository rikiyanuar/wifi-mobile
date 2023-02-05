import 'dart:convert';

import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:wifiapp/module/domain/entity/cart_entity.dart';

import '../../external/external.dart';

abstract class CartHelper {
  Future<CartEntity> getAll();
  Future<bool> insertItem(CartItem item);
}

class CartHelperImpl extends CartHelper {
  @override
  Future<CartEntity> getAll() async {
    final data = json.decode(await _load());

    return CartEntity.fromJson(data);
  }

  @override
  Future<bool> insertItem(CartItem item) async {
    final res = await getAll();
    if (res.totalItem == null || res.totalItem == 0) {
      final data = CartEntity(
        totalItem: 1,
        idProduk: [item.idProduk!],
        namaProduk: [item.namaProduk!],
        qtyProduk: [item.qtyProduk!],
        hargaProduk: [item.hargaProduk!],
        totalQty: item.qtyProduk,
        subTotal: item.hargaProduk,
      );

      return await _save(data);
    } else {
      if (res.idProduk!.contains(item.idProduk)) {
        List<int> qtyList = res.qtyProduk!;
        final index = res.idProduk!.indexOf(item.idProduk!);
        final newQty = qtyList[index] + item.qtyProduk!;
        qtyList.removeAt(index);
        qtyList.insert(index, newQty);

        final data = CartEntity(
          totalItem: res.totalItem!,
          idProduk: res.idProduk!,
          namaProduk: res.namaProduk!,
          qtyProduk: qtyList,
          hargaProduk: res.hargaProduk!,
          totalQty: qtyList.reduce((v, e) => v + e),
          subTotal: res.subTotal! + item.hargaProduk!,
        );

        return await _save(data);
      } else {
        final data = CartEntity(
          totalItem: res.totalItem! + 1,
          idProduk: [...res.idProduk!, item.idProduk!],
          namaProduk: [...res.namaProduk!, item.namaProduk!],
          qtyProduk: [...res.qtyProduk!, item.qtyProduk!],
          hargaProduk: [...res.hargaProduk!, item.hargaProduk!],
          totalQty: res.totalQty! + item.qtyProduk!,
          subTotal: res.subTotal! + item.hargaProduk!,
        );

        return await _save(data);
      }
    }
  }

  Future<bool> _save(CartEntity cart) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      String base64 = AesEncryption.encryptData(
        json.encode(cart),
        keyString: PrefsConstant.orderKey,
      );
      sharedPreferences.setString(PrefsConstant.orderPrefs, base64);

      return true;
    } catch (e) {
      return false;
    }
  }

  _load() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(PrefsConstant.orderPrefs) == null ||
        sharedPreferences.getString(PrefsConstant.orderPrefs)!.isEmpty) {
      return jsonEncode({"totalItem": 0});
    }

    String base64 = sharedPreferences.getString(PrefsConstant.orderPrefs)!;
    String string = AesEncryption.decryptData(
      base64,
      keyString: PrefsConstant.orderKey,
    );

    return string;
  }
}
