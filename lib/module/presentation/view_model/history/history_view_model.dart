import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_core/core.dart';
import 'package:wifiapp/module/data/local/session_helper.dart';

import '../../../data/appwrite/appwrite_helper.dart';
import '../../../external/external.dart';
import '../general_state.dart';

class HistoryViewModel extends JurnalAppChangeNotifier {
  final AppWriteHelper appWriteHelper;
  final SessionHelper sessionHelper;
  bool isLoading = false;
  List<Document> listTagihan = [];
  List<Document> listPoin = [];
  List<Document> listTrx = [];

  HistoryViewModel({
    required this.appWriteHelper,
    required this.sessionHelper,
  });

  Future<GeneralState> getPoin() async {
    try {
      _isLoading(true);
      final pelangganId = await sessionHelper.getPelangganId();
      final response = await appWriteHelper.listDocuments(
        AppWriteConstant.poinId,
        queries: [
          Query.equal("pelangganId", pelangganId),
          Query.limit(20),
          Query.orderDesc("\$id"),
        ],
      );
      listPoin = response.documents;

      return GeneralSuccessState();
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> getTagihan() async {
    try {
      _isLoading(true);
      final pelangganId = await sessionHelper.getPelangganId();
      final response = await appWriteHelper.listDocuments(
        AppWriteConstant.tagihanId,
        queries: [
          Query.equal("pelangganId", pelangganId),
          Query.limit(20),
          Query.orderDesc("\$id"),
        ],
      );
      listTagihan = response.documents;

      return GeneralSuccessState();
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> getTrx() async {
    try {
      _isLoading(true);
      final pelangganId = await sessionHelper.getPelangganId();
      final response = await appWriteHelper.listDocuments(
        AppWriteConstant.transaksiId,
        queries: [
          Query.equal("pelangganId", pelangganId),
          Query.orderDesc("\$id"),
        ],
      );
      listTrx = response.documents;

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
