import 'package:flutter_core/core.dart';
import 'package:wifiapp/module/data/local/cart_helper.dart';

import '../../../domain/entity/cart_entity.dart';
import '../general_state.dart';

class CartViewModel extends JurnalAppChangeNotifier {
  final CartHelper cartHelper;
  bool isLoading = false;
  CartEntity? cartEntity;

  CartViewModel({required this.cartHelper});

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

  _isLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
