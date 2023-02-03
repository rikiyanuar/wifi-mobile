import 'package:appwrite/appwrite.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';

import '../../data/appwrite/appwrite_helper.dart';
import '../../external/constant/appwrite_error_type.dart';
import 'general_state.dart';

class LoginViewModel extends JurnalAppChangeNotifier {
  final AppWriteHelper appWriteHelper;
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
      form.reset();
      _isLoading(false);
    }
  }

  _isLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
