import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_core/core.dart';

import '../../../data/appwrite/appwrite_helper.dart';
import '../../../external/external.dart';
import '../general_state.dart';

class DashboardViewModel extends JurnalAppChangeNotifier {
  final AppWriteHelper appWriteHelper;
  bool isLoading = false;
  List<Document> listBanner = [];
  List<Document> listProduk = [];
  String nama = "-";
  String nohp = "";

  DashboardViewModel({required this.appWriteHelper});

  Future<GeneralState> getBanner() async {
    try {
      _isLoading(true);
      final response =
          await appWriteHelper.listDocuments(AppWriteConstant.bannerId);
      listBanner = response.documents;

      return GeneralSuccessState();
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> getProduk() async {
    try {
      _isLoading(true);
      final response =
          await appWriteHelper.listDocuments(AppWriteConstant.produkId);
      listProduk = response.documents;

      return GeneralSuccessState();
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> getAccount() async {
    final accountHelper = appWriteHelper.accountHelper();

    try {
      _isLoading(true);
      final response = await accountHelper.get();
      nama = response.name;
      nohp = response.phone;

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
