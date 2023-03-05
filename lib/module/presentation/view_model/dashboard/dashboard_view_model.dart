import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_core/core.dart';
import 'package:wifiapp/module/data/local/cart_helper.dart';
import 'package:wifiapp/module/domain/entity/cart_entity.dart';
import 'package:wifiapp/module/domain/entity/pelanggan_entity.dart';
import 'package:wifiapp/module/domain/entity/tagihan_entity.dart';

import '../../../data/appwrite/appwrite_helper.dart';
import '../../../external/external.dart';
import '../general_state.dart';

class DashboardViewModel extends JurnalAppChangeNotifier {
  final CartHelper cartHelper;
  final AppWriteHelper appWriteHelper;
  bool isLoading = false;
  List<Document> listBanner = [];
  List<Document> listProduk = [];
  String nama = "-";
  String nohp = "";
  CartEntity? cartEntity;
  int poin = 0;
  TagihanEntity? tagihanEntity;

  DashboardViewModel({
    required this.appWriteHelper,
    required this.cartHelper,
  });

  Future<GeneralState> getBanner() async {
    try {
      _isLoading(true);
      final response = await appWriteHelper
          .listDocuments(FlavorBaseUrlConfig.instance!.appEnvironment.bannerId);
      if (response.total > 0) {
        listBanner = response.documents;
      }

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
      final response = await appWriteHelper
          .listDocuments(FlavorBaseUrlConfig.instance!.appEnvironment.produkId);
      if (response.total > 0) {
        listProduk = response.documents;
      }

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

      return _getPelanggan(response.$id);
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

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

  Future<GeneralState> _getPelanggan(String userID) async {
    try {
      _isLoading(true);
      final response = await appWriteHelper.listDocuments(
        FlavorBaseUrlConfig.instance!.appEnvironment.pelangganId,
        queries: [
          Query.equal("userID", userID),
        ],
      );
      final data = PelangganEntity.fromJson({
        ...response.documents.first.data,
        "id": response.documents.first.$id,
      });
      poin = data.poin;

      return _getTagihan(data.id!);
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> _getTagihan(String pelangganId) async {
    try {
      _isLoading(true);
      final response = await appWriteHelper.listDocuments(
        FlavorBaseUrlConfig.instance!.appEnvironment.tagihanId,
        queries: [
          Query.equal("pelangganId", pelangganId),
        ],
      );
      if (response.total > 0) {
        tagihanEntity = TagihanEntity.fromJson(response.documents.first.data);
      }

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
