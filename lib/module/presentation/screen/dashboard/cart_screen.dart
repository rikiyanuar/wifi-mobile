import 'package:flutter/material.dart';
import 'package:flutter_libraries/provider.dart';

import '../../view_model/dashboard/cart_view_model.dart';
import '../../widget/custom_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = CartViewModel();
    _getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel!,
      child: Consumer<CartViewModel>(
        builder: (context, viewModel, builder) {
          return CustomAppBar(
            title: "Riwayat",
            isLoading: viewModel.isLoading,
            body: _buildBody(),
          );
        },
      ),
    );
  }

  _buildBody() {}

  _getCartData() {}
}
