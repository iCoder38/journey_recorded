import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class AlertDialogScreen extends StatelessWidget {
  const AlertDialogScreen(
      {super.key,
      required Text title,
      required SingleChildScrollView content,
      required List<Widget> actions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Alert',
        style: TextStyle(
          fontFamily: font_style_name,
          fontSize: 16.0,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'str_messa',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Dismiss'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
