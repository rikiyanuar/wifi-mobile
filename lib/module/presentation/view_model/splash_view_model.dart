import 'package:appwrite/appwrite.dart';
import 'package:flutter_core/core.dart';

import '../../data/appwrite/appwrite_helper.dart';
import '../../external/constant/appwrite_error_type.dart';
import 'general_state.dart';

class SplashViewModel extends JurnalAppChangeNotifier {
  final AppWriteHelper appWriteHelper;

  SplashViewModel({required this.appWriteHelper});

  Future<GeneralState> checkSession() async {
    final accountHelper = appWriteHelper.accountHelper();

    try {
      final response = await accountHelper.get();

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
