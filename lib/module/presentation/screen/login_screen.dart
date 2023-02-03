import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:flutter_libraries/provider.dart';
import 'package:wifiapp/module/external/router/app_router.dart';
import 'package:wifiapp/module/presentation/view_model/general_state.dart';

import '../../data/appwrite/appwrite_helper.dart';
import '../view_model/login_view_model.dart';
import '../widget/background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = LoginViewModel(
      appWriteHelper: GetIt.I.get<AppWriteHelper>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
            create: (context) => _viewModel!),
      ],
      child: Consumer<LoginViewModel>(builder: (context, viewModel, builder) {
        return Scaffold(
          body: LoadingIndicator(
            isLoading: viewModel.isLoading,
            child: Background(
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("LOGO WIFI APP", style: TextStyles.b16White),
                  Container(
                    margin: const EdgeInsets.all(24),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: ReactiveForm(
                      formGroup: _viewModel!.form,
                      child: _buildForm(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text("NIK", style: TextStyles.r14),
        const SizedBox(height: 10),
        GeneralInputText(
          key: const Key("TxtNIK"),
          formControlName: LoginViewModel.emailKey,
          validationMessages: _viewModel!.formErrorMessages,
          hintText: "Ex: 370808170819450005",
          textInputType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        Text("Password", style: TextStyles.r14),
        const SizedBox(height: 10),
        GeneralInputText(
          key: const Key("TxtPassword"),
          formControlName: LoginViewModel.passwordKey,
          validationMessages: _viewModel!.formErrorMessages,
          hintText: "Password",
          isPasswordType: true,
        ),
        const SizedBox(height: 38),
        GeneralButton(
          text: "Login",
          onTap: () => _login(),
        ),
        const SizedBox(height: 18)
      ],
    );
  }

  _login() async {
    _viewModel!.form.markAllAsTouched();
    if (_viewModel!.form.invalid) {
      StandardToast.error(context, "Lengkapi form login");

      return;
    }

    final state = await _viewModel!.login();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    } else if (state is GeneralSuccessState) {
      GetIt.I.get<AppRouter>().goToLayout(null);
    }
  }
}
