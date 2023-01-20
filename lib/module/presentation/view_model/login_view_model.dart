import 'package:appwrite/appwrite.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:wifiapp/module/external/external.dart';

import '../../external/appwrite/appwrite_helper.dart';
import '../../external/constant/appwrite_error_type.dart';
import 'general_state.dart';

class LoginViewModel extends JurnalAppChangeNotifier {
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

  final _accountHelper = AppWriteHelper.accountHelper();

  Future<GeneralState> login() async {
    try {
      _isLoading(true);
      // TODO: change to get from form
      final response = await _accountHelper.createEmailSession(
        email:
            "1234567812345679@wifi.com", //emailControl.value+AppWriteConstant.emailSuffix,
        password: "Qwerty123", // passwordControl.value,
      );

      return GeneralSuccessState(object: response);
    } on AppwriteException catch (e) {
      String message = e.message!;
      if (e.type == AppWriteErrorType.userBlocked) {
        message = "Pengguna diblokir. Silahkan hubungi admin.";
      }

      return GeneralErrorState(message: message);
    } catch (e) {
      return GeneralErrorState(message: e.toString());
    } finally {
      emailControl.updateValue("");
      passwordControl.updateValue("");
      _isLoading(false);
    }
  }

  _isLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
