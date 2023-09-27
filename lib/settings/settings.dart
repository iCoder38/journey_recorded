// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/drawer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //
  var strFullScreenLoader = '0';
  //
  var strProfilePicture = '0';
  var strEmailAddress = '0';
  var strPhoneNumber = '0';
  var strSkills = '0';
  //
  @override
  void initState() {
    funcProfileWB('no');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        title: text_bold_style_custom(
          'Profile Setting',
          Colors.white,
          16.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: const navigationDrawer(),
      body: (strFullScreenLoader == '0')
          ? Center(
              child: text_regular_style_custom(
                'loading...',
                Colors.black,
                16.0,
              ),
            )
          : Column(
              children: [
                ListTile(
                  title: text_regular_style_custom(
                    'Profile Picture',
                    Colors.black,
                    14.0,
                  ),
                  trailing: (strProfilePicture == '0')
                      ? Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: text_regular_style_custom(
                              'Off',
                              Colors.white,
                              14.0,
                            ),
                          ),
                        )
                      : Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: text_regular_style_custom(
                              'On',
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ),
                  onTap: () {
                    //
                    if (strProfilePicture == '0') {
                      funcUpdateSetting('profile_picture', '1');
                    } else {
                      funcUpdateSetting('profile_picture', '0');
                    }
                  },
                ),
                //
                Container(
                  height: 0.2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
                //
                ListTile(
                  title: text_regular_style_custom(
                    'E-mail Address',
                    Colors.black,
                    14.0,
                  ),
                  trailing: (strEmailAddress == '0')
                      ? Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: text_regular_style_custom(
                              'Off',
                              Colors.white,
                              14.0,
                            ),
                          ),
                        )
                      : Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: text_regular_style_custom(
                              'On',
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ),
                  onTap: () {
                    if (strEmailAddress == '0') {
                      funcUpdateSetting('email_address', '1');
                    } else {
                      funcUpdateSetting('email_address', '0');
                    }
                  },
                ),
                //
                Container(
                  height: 0.2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
                //
                ListTile(
                  title: text_regular_style_custom(
                    'Phone number',
                    Colors.black,
                    14.0,
                  ),
                  trailing: (strPhoneNumber == '0')
                      ? Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: text_regular_style_custom(
                              'Off',
                              Colors.white,
                              14.0,
                            ),
                          ),
                        )
                      : Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: text_regular_style_custom(
                              'On',
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ),
                  onTap: () {
                    if (strPhoneNumber == '0') {
                      funcUpdateSetting('phone_number', '1');
                    } else {
                      funcUpdateSetting('phone_number', '0');
                    }
                  },
                ),
                //
                Container(
                  height: 0.2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
                //
                ListTile(
                  title: text_regular_style_custom(
                    'Skills',
                    Colors.black,
                    14.0,
                  ),
                  trailing: (strSkills == '0')
                      ? Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: text_regular_style_custom(
                              'Off',
                              Colors.white,
                              14.0,
                            ),
                          ),
                        )
                      : Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: text_regular_style_custom(
                              'On',
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ),
                  onTap: () {
                    if (strSkills == '0') {
                      funcUpdateSetting('skill', '1');
                    } else {
                      funcUpdateSetting('skill', '0');
                    }
                  },
                ),
                //
                Container(
                  height: 0.2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
                //
              ],
            ),
    );
  }

//
  // action list
  funcProfileWB(hideAlert) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print('POST ====> PROFILE');
    }

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
          strFullScreenLoader = '1';
          //
          strProfilePicture = getData['data']['imageView'].toString();
          strEmailAddress = getData['data']['emailView'].toString();
          strPhoneNumber = getData['data']['phoneView'].toString();
          strSkills = getData['data']['skillsView'].toString();
          //
          if (hideAlert == 'yes') {
            Navigator.pop(context);
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
    }
  }

  //
  funcUpdateSetting(tag, status) async {
    startLoadingUI(
      context,
      'Updating',
    );
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print('POST ====> UPDATE PROFILE');
    }

    var resposne;
    if (tag == 'profile_picture') {
      resposne = await http.post(
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
            'imageView': status.toString(),
          },
        ),
      );
    } else if (tag == 'email_address') {
      resposne = await http.post(
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
            'emailView': status.toString(),
          },
        ),
      );
    } else if (tag == 'phone_number') {
      resposne = await http.post(
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
            'phoneView': status.toString(),
          },
        ),
      );
    } else if (tag == 'skill') {
      resposne = await http.post(
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
            'skillsView': status.toString(),
          },
        ),
      );
    }

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        funcProfileWB('yes');
      } else {
        if (kDebugMode) {
          print(
            '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
          );
        }
      }
    } else {
      // return postList;
    }
  }
}
