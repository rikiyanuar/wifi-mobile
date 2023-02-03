import 'package:appwrite/appwrite.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';

import '../../../domain/entity/pelanggan_entity.dart';
import '../../../data/appwrite/appwrite_helper.dart';
import '../../../external/constant/appwrite_error_type.dart';
import '../../../external/external.dart';
import '../general_state.dart';

class EditProfileViewModel extends JurnalAppChangeNotifier {
  final AppWriteHelper appWriteHelper;
  final PelangganEntity pelangganEntity;
  bool isLoading = false;
  static const String namaKey = "namaKey";
  static const String nohpKey = "nohpKey";
  static const String emailKey = "emailKey";
  static const String alamatKey = "alamatKey";
  static const String nikKey = "nikKey";
  static const String passwordKey = "passwordKey";

  final form = FormGroup({
    namaKey: namaControl,
    nohpKey: nohpControl,
    emailKey: emailControl,
    alamatKey: alamatControl,
    nikKey: nikControl,
    passwordKey: passwordControl,
  });

  static FormControl namaControl = FormControl(
    validators: [Validators.required],
  );
  static FormControl nohpControl = FormControl(
    validators: [Validators.required],
  );
  static FormControl emailControl = FormControl(
    validators: [Validators.required, Validators.email],
  );
  static FormControl alamatControl = FormControl(
    validators: [Validators.required],
  );
  static FormControl nikControl = FormControl(
    validators: [Validators.required],
  );
  static FormControl passwordControl = FormControl(
    validators: [Validators.required],
  );
  Map<String, String> formErrorMessages = {
    ValidationMessage.required: "Kolom harus diisi",
    ValidationMessage.number: "Harus berisi angka",
    ValidationMessage.email: "Format email salah",
  };

  EditProfileViewModel(
      {required this.pelangganEntity, required this.appWriteHelper}) {
    form.reset();
    namaControl.updateValue(pelangganEntity.nama);
    nohpControl.updateValue(pelangganEntity.nohp);
    emailControl.updateValue(pelangganEntity.email);
    alamatControl.updateValue(pelangganEntity.alamat);
    nikControl.updateValue(pelangganEntity.nik);
  }

  Future<GeneralState> save() async {
    final accountHelper = appWriteHelper.accountHelper();

    try {
      _isLoading(true);
      await appWriteHelper.updateDocument(
        collectionId: AppWriteConstant.pelangganId,
        documentId: pelangganEntity.id!,
        data: {
          "nama": namaControl.value,
          "nohp": nohpControl.value, // TODO: convert phone to +62
          "email": emailControl.value,
          "alamat": alamatControl.value,
          "nik": nikControl.value,
        },
      );
      await accountHelper.updateName(name: namaControl.value);
      await accountHelper.updateEmail(
          email: nikControl.value + AppWriteConstant.emailSuffix,
          password: passwordControl.value);
      await accountHelper.updatePhone(
          phone: nohpControl.value, password: passwordControl.value);

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
}
