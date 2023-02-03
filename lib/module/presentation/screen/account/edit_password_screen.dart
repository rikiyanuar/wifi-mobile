import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:flutter_libraries/provider.dart';

import '../../../data/appwrite/appwrite_helper.dart';
import '../../view_model/account/edit_password_view_model.dart';
import '../../view_model/general_state.dart';
import '../../widget/custom_app_bar.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  EditPasswordViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = EditPasswordViewModel(
      appWriteHelper: GetIt.I.get<AppWriteHelper>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel!,
      child: Consumer<EditPasswordViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: CustomAppBar(
              paddingTop: 0,
              title: "Ubah Password",
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

  Widget _buildForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Password Lama", style: TextStyles.m12Black3),
      GeneralInputText(
        key: const Key("TxtOld"),
        formControlName: EditPasswordViewModel.oldKey,
        validationMessages: _viewModel!.formErrorMessages,
        hintText: "Password lama",
        margin: const EdgeInsets.only(top: 8, bottom: 14),
        isPasswordType: true,
      ),
      Text("Password Baru", style: TextStyles.m12Black3),
      GeneralInputText(
        key: const Key("TxtNew"),
        formControlName: EditPasswordViewModel.newKey,
        validationMessages: _viewModel!.formErrorMessages,
        hintText: "Password baru",
        margin: const EdgeInsets.only(top: 8, bottom: 14),
        isPasswordType: true,
      ),
      Text("Konfirmasi Password Baru", style: TextStyles.m12Black3),
      GeneralInputText(
        key: const Key("TxtNewConfirm"),
        formControlName: EditPasswordViewModel.newConfirmKey,
        validationMessages: _viewModel!.formErrorMessages,
        hintText: "Konfirmasi password baru",
        margin: const EdgeInsets.only(top: 8, bottom: 14),
        isPasswordType: true,
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
