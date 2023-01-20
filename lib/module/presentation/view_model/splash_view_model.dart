import 'package:appwrite/appwrite.dart';
import 'package:flutter_core/core.dart';

import '../../external/appwrite/appwrite_helper.dart';
import '../../external/constant/appwrite_error_type.dart';
import 'general_state.dart';

class SplashViewModel extends JurnalAppChangeNotifier {
  final _accountHelper = AppWriteHelper.accountHelper();

  Future<GeneralState> checkSession() async {
    try {
      final response = await _accountHelper.get();

      return GeneralSuccessState(object: response);
    } on AppwriteException catch (e) {
      if (e.type == AppWriteErrorType.generalUnauthorizedScope) {
        return GeneralErrorSpecificState();
      }

      return GeneralErrorState(message: e.message);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    }
  }
}
