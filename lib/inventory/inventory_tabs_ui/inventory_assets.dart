// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/inventory/edit_inventory/edit_inventory.dart';

class InventoryTabsUIScreen extends StatefulWidget {
  const InventoryTabsUIScreen({super.key, this.arrGetAssetsWithIndex});

  final arrGetAssetsWithIndex;

  @override
  State<InventoryTabsUIScreen> createState() => _InventoryTabsUIScreenState();
}

class _InventoryTabsUIScreenState extends State<InventoryTabsUIScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: ListTile(
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
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
    //
  }

  //
  Future<void> pushToAddItem(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditInventoryScreen(),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

// get_back_from_add_notes

    if (!mounted) return;

    if (result == '1') {}
  }
}
