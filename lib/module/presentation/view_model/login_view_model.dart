import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';

class LoginViewModel extends JurnalAppChangeNotifier {
  static const String emailKey = "emailKey";
  static const String passwordKey = "passwordKey";

  final form = FormGroup({
    emailKey: emailControl,
    passwordKey: passwordControl,
  });

  static FormControl emailControl = FormControl(
    validators: [Validators.required, Validators.email],
  );

  static FormControl passwordControl = FormControl(
    validators: [Validators.required],
  );

  Map<String, String> formErrorMessages = {
    ValidationMessage.required: "Kolom harus diisi",
    ValidationMessage.email: "Format email salah",
  };
}
