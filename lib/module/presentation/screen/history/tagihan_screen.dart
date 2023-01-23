import 'package:flutter/material.dart';
import 'package:wifiapp/module/domain/entity/tagihan_entity.dart';
import '../../widget/custom_app_bar.dart';

class TagihanScreen extends StatefulWidget {
  final TagihanEntity tagihanEntity;

  const TagihanScreen({super.key, required this.tagihanEntity});

  @override
  State<TagihanScreen> createState() => _TagihanScreenState();
}

class _TagihanScreenState extends State<TagihanScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Tagihan Anda",
      body: _buildBody(),
    );
  }

  _buildBody() {}
}
