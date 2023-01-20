import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:flutter_libraries/provider.dart';

import '../../../external/router/app_router.dart';
import '../../view_model/account/account_view_model.dart';
import '../../view_model/general_state.dart';
import '../../widget/background.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AccountViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = AccountViewModel();
    _getAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel!,
      child: Consumer<AccountViewModel>(
        builder: (context, viewModel, builder) {
          return Background(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            widget: LoadingIndicator(
              isLoading: viewModel.isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      "Hi, ${viewModel.nama}",
                      style: TextStyles.m18.copyWith(color: AppColors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      viewModel.dataAccount.nohp,
                      style: TextStyles.r14.copyWith(color: AppColors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 6,
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.only(left: 14, right: 7),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 70,
                          child: Row(children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Poin anda",
                                      style: TextStyles.r12Black3),
                                  const SizedBox(height: 4),
                                  Text("1400", style: TextStyles.m12),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: AppColors.magenta1,
                            ),
                          ]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 6,
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.only(right: 14, left: 7),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          height: 70,
                          child: Row(children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Paket Internet",
                                      style: TextStyles.r12Black3),
                                  const SizedBox(height: 4),
                                  Text("Paket 100rb", style: TextStyles.m12),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: AppColors.magenta1,
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Container(
                        width: 1.sw,
                        color: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildData(),
                              _buildLogout(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildData() {
    return Container(height: 200);
  }

  _buildLogout() {
    return GeneralButton(
      text: "Keluar",
      color: AppColors.red1,
      onTap: () => _logout(),
    );
  }

  _getAccount() async {
    final state = await _viewModel!.getAccount();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    }
  }

  _logout() async {
    final state = await _viewModel!.logout();

    if (!mounted) return;
    if (state is GeneralErrorState) {
      StandardToast.showClientErrorToast(context, message: state.message);
    } else if (state is GeneralSuccessState) {
      GetIt.I.get<AppRouter>().goToSplashScreen();
    }
  }
}
