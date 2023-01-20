import 'package:appwrite/appwrite.dart';
import 'package:flutter_core/core.dart';
import 'package:wifiapp/module/domain/entity/pelanggan_entity.dart';
import 'package:wifiapp/module/external/external.dart';

import '../../../external/appwrite/appwrite_helper.dart';
import '../general_state.dart';

class AccountViewModel extends JurnalAppChangeNotifier {
  PelangganEntity dataAccount = PelangganEntity.fromJson({
    "nama": "",
    "nohp": "",
    "email": "",
    "alamat": "",
    "nik": "",
    "isBlocked": "",
    "blockedReason": "",
    "paket": [],
    "userID": "",
  });
  bool isLoading = false;
  String nama = "";

  final _accountHelper = AppWriteHelper.accountHelper();

  Future<GeneralState> getAccount() async {
    try {
      _isLoading(true);
      final response = await _accountHelper.get();
      nama = response.name;

      return _getDataAccount(response.$id);
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> logout() async {
    try {
      _isLoading(true);
      await _accountHelper.deleteSessions();

      return GeneralSuccessState();
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> _getDataAccount(String userId) async {
    try {
      _isLoading(true);
      final response = await AppWriteHelper.documentHelper(
        AppWriteConstant.pelangganId,
        queries: [Query.equal("userID", userId)],
      );
      dataAccount = PelangganEntity.fromJson(response.documents.first.data);

      return GeneralSuccessState();
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
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
