// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class InventoryTabsUIScreen extends StatefulWidget {
  const InventoryTabsUIScreen({super.key, this.arrGetAssetsWithIndex});

  final arrGetAssetsWithIndex;

  @override
  State<InventoryTabsUIScreen> createState() => _InventoryTabsUIScreenState();
}

class _InventoryTabsUIScreenState extends State<InventoryTabsUIScreen> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: text_bold_style_custom(
        //
        widget.arrGetAssetsWithIndex['name'].toString(),
        Colors.black,
        16.0,
      ),
      subtitle: text_regular_style_custom(
        //
        widget.arrGetAssetsWithIndex['purchaseDate'].toString(),
        Colors.black,
        10.0,
      ),
    );
    //
  }
}
