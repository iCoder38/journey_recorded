// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class DialogExample extends StatefulWidget {
  const DialogExample({super.key, required this.str_alert_text_name});

  final String str_alert_text_name;

  @override
  State<DialogExample> createState() => _DialogExampleState();
}

class _DialogExampleState extends State<DialogExample> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.transparent,
                width: 48.0,
                height: 48.0,
                child: const CircularProgressIndicator(
                  color: Colors.pink,
                ),
              ),
            ),
            Align(
              child: Text(
                //
                widget.str_alert_text_name.toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
