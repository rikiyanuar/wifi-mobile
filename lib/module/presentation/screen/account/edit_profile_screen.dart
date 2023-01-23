import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:flutter_libraries/provider.dart';
import 'package:wifiapp/module/presentation/widget/custom_app_bar.dart';

import '../../../domain/entity/pelanggan_entity.dart';
import '../../view_model/account/edit_profile_view_model.dart';
import '../../view_model/general_state.dart';

class EditProfileScreen extends StatefulWidget {
  final PelangganEntity pelangganEntity;

  const EditProfileScreen({super.key, required this.pelangganEntity});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = EditProfileViewModel(
      pelangganEntity: widget.pelangganEntity,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel!,
      child: Consumer<EditProfileViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: CustomAppBar(
              paddingTop: 0,
              title: "Ubah Profil",
              body: LoadingIndicator(
                isLoading: viewModel.isLoading,
                child: ReactiveForm(
                  formGroup: viewModel.form,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: _buildForm(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ignore: long-method
  Widget _buildForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Nama", style: TextStyles.m12Black3),
      GeneralInputText(
        key: const Key("TxtNama"),
        formControlName: EditProfileViewModel.namaKey,
        validationMessages: _viewModel!.formErrorMessages,
        hintText: "Ex: John Doe",
        margin: const EdgeInsets.only(top: 8, bottom: 14),
      ),
      Text("Nomor HP", style: TextStyles.m12Black3),
      GeneralInputText(
        key: const Key("TxtNohp"),
        formControlName: EditProfileViewModel.nohpKey,
        validationMessages: _viewModel!.formErrorMessages,
        hintText: "Ex: +628512345678",
        textInputType: TextInputType.phone,
        margin: const EdgeInsets.only(top: 8, bottom: 14),
      ),
      Text("Email", style: TextStyles.m12Black3),
      GeneralInputText(
        key: const Key("TxtEmail"),
        formControlName: EditProfileViewModel.emailKey,
        validationMessages: _viewModel!.formErrorMessages,
        hintText: "Ex: john@doe.com",
        textInputType: TextInputType.emailAddress,
        margin: const EdgeInsets.only(top: 8, bottom: 14),
      ),
      Text("Alamat", style: TextStyles.m12Black3),
      GeneralInputText(
        key: const Key("TxtAlamat"),
        formControlName: EditProfileViewModel.alamatKey,
        validationMessages: _viewModel!.formErrorMessages,
        hintText: "Ex: Jalan John Doe",
        textInputType: TextInputType.streetAddress,
        margin: const EdgeInsets.only(top: 8, bottom: 14),
      ),
      Text("NIK", style: TextStyles.m12Black3),
      GeneralInputText(
        key: const Key("TxtNIK"),
        formControlName: EditProfileViewModel.nikKey,
        validationMessages: _viewModel!.formErrorMessages,
        hintText: "Ex: 1234567812345678",
        textInputType: TextInputType.number,
        margin: const EdgeInsets.only(top: 8, bottom: 14),
      ),
      const Divider(height: 2),
      const SizedBox(height: 10),
      Text(
        "Masukkan password untuk mengubah data",
        style: TextStyles.m12Black3,
      ),
      GeneralInputText(
        key: const Key("TxtPassword"),
        formControlName: EditProfileViewModel.passwordKey,
        validationMessages: _viewModel!.formErrorMessages,
        hintText: "Password",
        isPasswordType: true,
        margin: const EdgeInsets.only(top: 8, bottom: 14),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 24),
        child: GeneralButton(
          text: "Simpan",
          onTap: () => _save(),
          isLoading: _viewModel!.isLoading,
        ),
      ),
    ]);
  }

  _save() async {
    _viewModel!.form.markAllAsTouched();
    if (_viewModel!.form.invalid) {
      StandardToast.error(context, "Lengkapi form");

      return;
    }

    final state = await _viewModel!.save();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    } else if (state is GeneralSuccessState) {
      AppNavigator.pop();
    }
  }
}
