// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/change_password/change_password.dart';
import 'package:journey_recorded/custom_files/language_translate_texts/language_translate_text.dart';
import 'package:journey_recorded/dashboard/dashboard.dart';
import 'package:journey_recorded/edit_profile/edit_profile.dart';
import 'package:journey_recorded/edit_profile/edit_see_profile/edit_see_profile.dart';
import 'package:journey_recorded/help/help.dart';
import 'package:journey_recorded/login/login.dart';
import 'package:journey_recorded/q_a/q_a.dart';
import 'package:journey_recorded/set_language/set_language.dart';
import 'package:journey_recorded/settings/settings.dart';
import 'package:journey_recorded/shop_order_history/shop_order_history.dart';
// import 'package:journey_recorded/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class navigationDrawer extends StatefulWidget {
  const navigationDrawer({Key? key}) : super(key: key);

  @override
  State<navigationDrawer> createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
  //
  var strUserSelectLanguage = 'en';
  final ConvertLanguage languageTextConverter = ConvertLanguage();
  //
  @override
  void initState() {
    //
    funcSelectLanguage();
    super.initState();
  }

// /********** LANGUAGE SELECTED **********************************************/
  funcSelectLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strUserSelectLanguage = prefs.getString('language').toString();
    setState(() {});
  }
// /********** LANGUAGE SELECTED **********************************************/

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: navigation_color,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(
              252,
              118,
              10,
              1,
            ),
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '',
              ),
            ),
          ),
          Container(
            // 33 237 244
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(
              33,
              237,
              244,
              1,
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'REQUESTER',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: 200,
            // color: Colors.brown,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(
                252,
                118,
                10,
                1,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.home,
                  ),
                  iconColor: Colors.white,
                  title: text_bold_style_custom(
                    //
                    languageTextConverter.funcConvertLanguage(
                      'menu_dashboard',
                      strUserSelectLanguage,
                    ),
                    Colors.white,
                    16.0,
                  ),
                  onTap: () {
                    // print('1.1.1');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(
                            // get_login_sender_chat_id: 'Dashboard',
                            ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.edit,
                  ),
                  iconColor: Colors.white,
                  title: text_bold_style_custom(
                    //
                    languageTextConverter.funcConvertLanguage(
                      'menu_edit_profile',
                      strUserSelectLanguage,
                    ),
                    Colors.white,
                    16.0,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EdtiSeeProfileScreen(
                            // get_login_sender_chat_id: 'Dashboard',
                            ),
                      ),
                    );
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.question_answer,
                  ),
                  iconColor: Colors.white,
                  title: text_bold_style_custom(
                    //
                    languageTextConverter.funcConvertLanguage(
                      'menu_q_a',
                      strUserSelectLanguage,
                    ),
                    Colors.white,
                    16.0,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuestionAndAnswerScreen(
                            // get_login_sender_chat_id: 'Dashboard',
                            ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.help,
                  ),
                  iconColor: Colors.white,
                  title: text_bold_style_custom(
                    //
                    languageTextConverter.funcConvertLanguage(
                      'menu_order_history',
                      strUserSelectLanguage,
                    ),
                    Colors.white,
                    16.0,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShopOrderHistoryScreen(
                            // get_login_sender_chat_id: 'Dashboard',
                            ),
                      ),
                    );
                    // Then close the drawer
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.help,
                  ),
                  iconColor: Colors.white,
                  title: text_bold_style_custom(
                    //
                    languageTextConverter.funcConvertLanguage(
                      'menu_help',
                      strUserSelectLanguage,
                    ),
                    Colors.white,
                    16.0,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelpScreen(
                            // get_login_sender_chat_id: 'Dashboard',
                            ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.lock,
                  ),
                  iconColor: Colors.white,
                  title: text_bold_style_custom(
                    //
                    languageTextConverter.funcConvertLanguage(
                      'menu_change_password',
                      strUserSelectLanguage,
                    ),
                    Colors.white,
                    16.0,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen(
                            // get_login_sender_chat_id: 'Dashboard',
                            ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.language,
                  ),
                  iconColor: Colors.white,
                  title: text_bold_style_custom(
                    //
                    languageTextConverter.funcConvertLanguage(
                      'menu_language',
                      strUserSelectLanguage,
                    ),
                    Colors.white,
                    16.0,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetLanguageScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                  ),
                  iconColor: Colors.white,
                  title: text_bold_style_custom(
                    //
                    languageTextConverter.funcConvertLanguage(
                      'menu_settings',
                      strUserSelectLanguage,
                    ),
                    Colors.white,
                    16.0,
                  ),
                  onTap: () {
                    // Update the state of the app
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(
                            // get_login_sender_chat_id: 'Dashboard',
                            ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  iconColor: Colors.white,
                  title: text_bold_style_custom(
                    //
                    languageTextConverter.funcConvertLanguage(
                      'menu_logout',
                      strUserSelectLanguage,
                    ),
                    Colors.white,
                    16.0,
                  ),
                  onTap: () async {
                    // Update the state of the app
                    // ...
                    // Then close the drawer

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
