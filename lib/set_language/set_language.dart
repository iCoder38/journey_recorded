import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/drawer.dart';
import 'package:journey_recorded/custom_files/language_translate_texts/language_translate_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetLanguageScreen extends StatefulWidget {
  const SetLanguageScreen({super.key});

  @override
  State<SetLanguageScreen> createState() => _SetLanguageScreenState();
}

class _SetLanguageScreenState extends State<SetLanguageScreen> {
  //
  var strUserSelectLanguage = 'en';
  final ConvertLanguage languageTextConverter = ConvertLanguage();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          languageTextConverter.funcConvertLanguage(
            class_name_selected_language,
            strUserSelectLanguage,
            // select_language_text,
          ),
          Colors.white,
          16.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: navigation_color,
      ),
      drawer: const navigationDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: text_regular_style_custom(
                //
                languageTextConverter.funcConvertLanguage(
                  class_name_selected_language,
                  strUserSelectLanguage,
                  // select_language_text,
                ),
                Colors.black,
                14.0,
              ),
            ),
          ),
          //
          ListTile(
            title: text_regular_style_custom(
              'English',
              Colors.black,
              14.0,
            ),
            onTap: () {
              //
              strUserSelectLanguage = 'en';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  closeIconColor: Colors.amber,
                  content: text_regular_style_custom(
                    'Selected Language : English',
                    Colors.white,
                    14.0,
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              //
              funcUpdateLanguageStatusLocally('en');
            },
          ),
          //
          ListTile(
            title: text_regular_style_custom(
              'Spanish',
              Colors.black,
              14.0,
            ),
            onTap: () {
              //
              strUserSelectLanguage = 'sp';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  closeIconColor: Colors.amber,
                  content: text_regular_style_custom(
                    //
                    languageTextConverter.funcConvertLanguage(
                      'select_language_spanish_alert',
                      strUserSelectLanguage,
                      // select_language_alert_text,
                    ),
                    Colors.white,
                    14.0,
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              //
              funcUpdateLanguageStatusLocally('sp');
            },
          ),
          //
        ],
      ),
    );
  }

  //
  funcUpdateLanguageStatusLocally(
    languageSelect,
  ) async {
    if (kDebugMode) {
      print('USER SELECT ====> $languageSelect');
    }
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', languageSelect);
    //
    setState(() {});
  }
}
