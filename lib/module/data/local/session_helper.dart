import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';

import '../../external/external.dart';

abstract class SessionHelper {
  Future<bool> saveUserId(String userId);
  Future<String> getUserId();
  Future<bool> savePelangganId(String pelangganId);
  Future<String> getPelangganId();
}

class SessionHelperImpl extends SessionHelper {
  @override
  Future<String> getPelangganId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (sharedPreferences.getString(PrefsConstant.pelangganIdPrefs) == null ||
          sharedPreferences
              .getString(PrefsConstant.pelangganIdPrefs)!
              .isEmpty) {
        return "";
      }

      String base64 =
          sharedPreferences.getString(PrefsConstant.pelangganIdPrefs)!;

      return AesEncryption.decryptData(base64,
          keyString: PrefsConstant.pelangganIdKey);
    } catch (e) {
      return "";
    }
  }

  @override
  Future<String> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (sharedPreferences.getString(PrefsConstant.userIdPrefs) == null ||
          sharedPreferences.getString(PrefsConstant.userIdPrefs)!.isEmpty) {
        return "";
      }

      String base64 = sharedPreferences.getString(PrefsConstant.userIdPrefs)!;

      return AesEncryption.decryptData(base64,
          keyString: PrefsConstant.userIdKey);
    } catch (e) {
      return "";
    }
  }

  @override
  Future<bool> savePelangganId(String pelangganId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      String base64 = AesEncryption.encryptData(
        pelangganId,
        keyString: PrefsConstant.pelangganIdKey,
      );

      return sharedPreferences.setString(
          PrefsConstant.pelangganIdPrefs, base64);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> saveUserId(String userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      String base64 = AesEncryption.encryptData(
        userId,
        keyString: PrefsConstant.userIdKey,
      );

      return sharedPreferences.setString(PrefsConstant.userIdPrefs, base64);
    } catch (e) {
      return false;
    }
  }
}
