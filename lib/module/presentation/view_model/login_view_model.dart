import 'package:appwrite/appwrite.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:wifiapp/module/data/local/session_helper.dart';

import '../../data/appwrite/appwrite_helper.dart';
import '../../external/constant/appwrite_error_type.dart';
import '../../external/external.dart';
import 'general_state.dart';

class LoginViewModel extends JurnalAppChangeNotifier {
  final AppWriteHelper appWriteHelper;
  final SessionHelper sessionHelper;
  bool isLoading = false;
  static const String emailKey = "emailKey";
  static const String passwordKey = "passwordKey";

  final form = FormGroup({
    emailKey: emailControl,
    passwordKey: passwordControl,
  });

  static FormControl emailControl = FormControl(
    validators: [Validators.required, Validators.number],
  );

  static FormControl passwordControl = FormControl(
    validators: [Validators.required],
  );

  Map<String, String> formErrorMessages = {
    ValidationMessage.required: "Kolom harus diisi",
    ValidationMessage.number: "Harus berisi angka",
  };

  LoginViewModel({
    required this.appWriteHelper,
    required this.sessionHelper,
  }) {
    form.reset();
  }

  Future<GeneralState> login() async {
    final accountHelper = appWriteHelper.accountHelper();

    try {
      _isLoading(true);
      // TODO: change to get from form
      final response = await accountHelper.createEmailSession(
        email:
            "1234567812345679@wifi.com", //emailControl.value+AppWriteConstant.emailSuffix,
        password: "12345678", // passwordControl.value,
      );

      return _getPelanggan(response.userId);
    } on AppwriteException catch (e) {
      String message = e.message!;
      if (e.type == AppWriteErrorType.userBlocked) {
        message = "Pengguna diblokir. Silahkan hubungi admin.";
      }

      return GeneralErrorState(message: message);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      form.reset();
      _isLoading(false);
    }
  }

  Future<GeneralState> _getPelanggan(String userId) async {
    try {
      _isLoading(true);
      final response = await appWriteHelper.listDocuments(
        AppWriteConstant.pelangganId,
        queries: [Query.equal("userID", userId)],
      );

      return _saveSession(userId, response.documents.first.$id);
    } on AppwriteException catch (e) {
      return GeneralErrorState(message: e.type);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      _isLoading(false);
    }
  }

  Future<GeneralState> _saveSession(userId, pelangganId) async {
    try {
      if (await sessionHelper.saveUserId(userId)) {
        if (await sessionHelper.savePelangganId(pelangganId)) {
          return GeneralSuccessState();
        } else {
          return GeneralErrorState();
        }
      } else {
        return GeneralErrorState();
      }
    } catch (e) {
      return GeneralErrorState();
    }
  }

  _isLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
