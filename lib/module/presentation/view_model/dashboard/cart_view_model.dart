import 'package:flutter_core/core.dart';

class CartViewModel extends JurnalAppChangeNotifier {
  bool isLoading = false;

  _isLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
