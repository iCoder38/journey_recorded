// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class AppBarScreen extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String str_app_bar_title;
  final String str_back_button_status;

  AppBarScreen(
      {Key? key,
      required this.str_app_bar_title,
      required this.str_back_button_status})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (str_back_button_status == '0') {
      return AppBar(
        title: Text(
          str_app_bar_title,
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: navigation_color,
      );
    } else {
      return AppBar(
        title: Text(
          str_app_bar_title,
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        //automaticallyImplyLeading: true,
        backgroundColor: navigation_color,
      );
    }
  }
}
