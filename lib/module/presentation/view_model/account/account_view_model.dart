import 'package:appwrite/appwrite.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:wifiapp/module/domain/entity/pelanggan_entity.dart';
import 'package:wifiapp/module/external/external.dart';

import '../../../data/appwrite/appwrite_helper.dart';
import '../general_state.dart';

class AccountViewModel extends JurnalAppChangeNotifier {
  final AppWriteHelper appWriteHelper;
  PelangganEntity dataAccount = PelangganEntity.fromJson({
    "nama": "",
    "nohp": "",
    "email": "",
    "alamat": "",
    "nik": "",
    "isBlocked": "",
    "blockedReason": "",
    "paket": ["", "", ""],
    "userID": "",
    "poin": 0,
  });
  bool isLoading = false;
  String nama = "";
  String appVersion = "";

  AccountViewModel({required this.appWriteHelper}) {
    _getVersion();
  }

  Future<GeneralState> getAccount() async {
    final accountHelper = appWriteHelper.accountHelper();

    try {
      _isLoading(true);
      final response = await accountHelper.get();
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
    final accountHelper = appWriteHelper.accountHelper();

    try {
      _isLoading(true);
      await accountHelper.deleteSessions();

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
      final response = await appWriteHelper.listDocuments(
        FlavorBaseUrlConfig.instance!.appEnvironment.pelangganId,
        queries: [Query.equal("userID", userId)],
      );
      dataAccount = PelangganEntity.fromJson({
        ...response.documents.first.data,
        "id": response.documents.first.$id,
      });

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

  _getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    notifyListeners();
  }
}
