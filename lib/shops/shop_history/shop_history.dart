import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class ShopHistoryScreen extends StatefulWidget {
  const ShopHistoryScreen({super.key});

  @override
  State<ShopHistoryScreen> createState() => _ShopHistoryScreenState();
}

class _ShopHistoryScreenState extends State<ShopHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: navigation_color,
        title: text_bold_style_custom(
          'Shop History',
          Colors.white,
          16.0,
        ),
      ),
      // body: ,
    );
  }
}
