import 'package:flutter/material.dart';
import 'package:flutter_core/core.dart';
import 'package:flutter_libraries/libraries.dart';
import 'package:flutter_libraries/provider.dart';
import 'package:wifiapp/module/data/appwrite/appwrite_helper.dart';

import '../../../external/router/app_router.dart';
import '../../view_model/account/account_view_model.dart';
import '../../view_model/general_state.dart';
import '../../widget/background.dart';

class AccountScreen extends StatefulWidget {
  final Function(int value) changeIndex;

  const AccountScreen({super.key, required this.changeIndex});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AccountViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = AccountViewModel(
      appWriteHelper: GetIt.I.get<AppWriteHelper>(),
    );
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
              child: _buildBody(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 14),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          "Hi, ${_viewModel!.nama}",
          style: TextStyles.m18.copyWith(color: AppColors.white),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          _viewModel!.dataAccount.nohp,
          style: TextStyles.r14.copyWith(color: AppColors.white),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(children: [
          _buildCardPoin(),
          const SizedBox(width: 14),
          _buildCardPaket(),
        ]),
      ),
      const SizedBox(height: 18),
      Expanded(
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: Container(
            width: 1.sw,
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SingleChildScrollView(
              child: _buildList(),
            ),
          ),
        ),
      )
    ]);
  }

  Widget _buildList() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 16),
      Text(
        "PENGATURAN AKUN",
        style: TextStyles.r12.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.neutral60,
        ),
      ),
      const SizedBox(height: 6),
      _buildListTile("Ubah Profil", onTap: () async {
        await GetIt.I.get<AppRouter>().goToEditProfile(_viewModel!.dataAccount);
        _getAccount();
      }),
      const Divider(height: 1),
      _buildListTile(
        "Ubah Password",
        onTap: () => GetIt.I.get<AppRouter>().goToEditPassword(),
      ),
      const SizedBox(height: 16),
      Text(
        "LAINNYA",
        style: TextStyles.r11.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.neutral60,
        ),
      ),
      const SizedBox(height: 6),
      _buildListTile("Kebijakan Privasi"),
      const Divider(height: 1),
      _buildListTile("Kirim Masukan"),
      const Divider(height: 1),
      _buildListTile(
        "WIFI App",
        trailing: Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Text("v1.0.0", style: TextStyles.l11Black3),
        ),
      ),
      const SizedBox(height: 32),
      _buildLogout(),
    ]);
  }

  ListTile _buildListTile(String title, {Function()? onTap, Widget? trailing}) {
    return ListTile(
      dense: true,
      title: Text(title, style: TextStyles.r13),
      trailing: trailing ??
          const Icon(
            Icons.chevron_right,
            color: AppColors.magenta1,
          ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildCardPoin() {
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.changeIndex(1),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          height: 70,
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(children: [
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.stars,
                      color: AppColors.magenta1,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text("Poin Anda", style: TextStyles.r11Black3),
                  ]),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Text("140.000", style: TextStyles.s13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.magenta1),
            const SizedBox(width: 6),
          ]),
        ),
      ),
    );
  }

  Widget _buildCardPaket() {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          height: 70,
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(children: [
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.wifi,
                      color: AppColors.magenta1,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text("Paket Internet", style: TextStyles.r11Black3),
                  ]),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Text(
                      "Paket 100rb",
                      style: TextStyles.s13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.magenta1),
            const SizedBox(width: 6),
          ]),
        ),
      ),
    );
  }

  Widget _buildLogout() {
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
