import 'package:appwrite/appwrite.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';

import '../../../data/appwrite/appwrite_helper.dart';
import '../../../external/constant/appwrite_error_type.dart';
import '../general_state.dart';

class EditPasswordViewModel extends JurnalAppChangeNotifier {
  final AppWriteHelper appWriteHelper;
  bool isLoading = false;
  static const String oldKey = "oldKey";
  static const String newKey = "newKey";
  static const String newConfirmKey = "newConfirmKey";

  final form = FormGroup({
    oldKey: oldControl,
    newKey: newControl,
    newConfirmKey: newConfirmControl,
  });

  static FormControl oldControl = FormControl(
    validators: [
      Validators.required,
      Validators.minLength(8),
      Validators.maxLength(8),
    ],
  );
  static FormControl newControl = FormControl(
    validators: [
      Validators.required,
      Validators.minLength(8),
      Validators.maxLength(8),
    ],
  );
  static FormControl newConfirmControl = FormControl(
    validators: [
      Validators.required,
      Validators.minLength(8),
      Validators.maxLength(8),
      _mustMatch
    ],
  );

  Map<String, String> formErrorMessages = {
    ValidationMessage.required: "Kolom harus diisi",
    ValidationMessage.minLength: "Minimal 8 karakter",
    ValidationMessage.maxLength: "Maksimal 8 karakter",
    "mustMatch": "Password baru tidak sama",
  };

  EditPasswordViewModel({required this.appWriteHelper}) {
    form.reset();
  }

  Future<GeneralState> save() async {
    final accountHelper = appWriteHelper.accountHelper();

    try {
      _isLoading(true);

      await accountHelper.updatePassword(
        password: newControl.value,
        oldPassword: oldControl.value,
      );

      return GeneralSuccessState();
    } on AppwriteException catch (e) {
      String message = e.message!;
      if (e.type == AppWriteErrorType.userInvalidCredentials) {
        message = "Password yang Anda masukkan salah";
      }

      return GeneralErrorState(message: message);
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

  static Map<String, dynamic>? _mustMatch(AbstractControl<dynamic> control) =>
      newControl.value != control.value ? {"mustMatch": true} : null;
}
