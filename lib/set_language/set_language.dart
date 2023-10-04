// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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
  var str_screen_loader = '1';
  var strUserSelectLanguage = '0';
  final ConvertLanguage languageTextConverter = ConvertLanguage();
  //
  @override
  void initState() {
    loginUserProfileWB();
    super.initState();
  }

  // profile
  loginUserProfileWB() async {
    if (kDebugMode) {
      print('=====> POST : GET LOGIN USER DATA');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'profile',
          'userId': prefs.getInt('userId').toString(),
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        setState(() {
          strUserSelectLanguage = getData['data']['language'].toString();
          str_screen_loader = '0';
        });
      } else {
        if (kDebugMode) {
          print(
            '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
          );
        }
      }
    } else {
      // return postList;
      print('something went wrong');
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (strUserSelectLanguage == '0')
            ? const SizedBox()
            : text_bold_style_custom(
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
      body: (str_screen_loader == '1')
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                  trailing: (strUserSelectLanguage == 'en')
                      ? const Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : const SizedBox(),
                  onTap: () {
                    //
                    setState(() {
                      strUserSelectLanguage = 'en';
                    });
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
                  trailing: (strUserSelectLanguage == 'sp')
                      ? const Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : const SizedBox(),
                  onTap: () {
                    //
                    setState(() {
                      strUserSelectLanguage = 'sp';
                    });
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
    funcUpdateLanguageWB(languageSelect);
  }

  // update language
  funcUpdateLanguageWB(languageSelected) async {
    if (kDebugMode) {
      print('=====> POST : UPDATE LANGUAGE');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'editprofile',
          'userId': prefs.getInt('userId').toString(),
          'language': languageSelected.toString(),
          'device': 'iOS',
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        Map<String, dynamic> user = getData['data'];
        await prefs.setInt('userId', user['userId']);
        await prefs.setString('selected_language', user['language']);
        //
        setState(() {
          if (strUserSelectLanguage == 'en') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                closeIconColor: Colors.amber,
                content: Text(
                  getData['msg'].toString(),
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                closeIconColor: Colors.amber,
                content: text_regular_style_custom(
                  //
                  languageTextConverter.funcConvertLanguage(
                    'alert_profile_update_successfully',
                    strUserSelectLanguage,
                    // select_language_alert_text,
                  ),
                  Colors.white,
                  14.0,
                ),
              ),
            );
          }
        });
      } else {
        if (kDebugMode) {
          print(
            '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
          );
        }
      }
    } else {
      // return postList;
      print('something went wrong');
    }
  }
}
