// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFriendProfileScreen extends StatefulWidget {
  const MyFriendProfileScreen({super.key, required this.str_user_id});

  final String str_user_id;

  @override
  State<MyFriendProfileScreen> createState() => _MyFriendProfileScreenState();
}

class _MyFriendProfileScreenState extends State<MyFriendProfileScreen> {
  //
  var str_skill_hidden = '0';
  var str_phone_hidden = '0';
  var str_email_hidden = '0';
  var str_address_hidden = '0';
  var str_image_hidden = '0';

  var str_login_user_id = '';
  var str_loader = '1';
  var dictLoginData;
  //
  @override
  void initState() {
    //
    if (kDebugMode) {
      print('====================================');
      print(widget.str_user_id);
      print('====================================');
    }

    profileWB();
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          'Profile', Colors.white, 16.0,
        ),
        leading: IconButton(
          onPressed: () {
            //
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        backgroundColor: navigation_color,
      ),
      body: (str_loader == '1')
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                header_ui(context),
                //
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    // height: 240,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 0.4,
                      ),
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        (str_phone_hidden == '1')
                            ? const SizedBox(
                                height: 0,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    text_bold_style_custom(
                                      'Phone',
                                      Colors.black,
                                      16.0,
                                    ),
                                    //
                                    const Spacer(),
                                    //
                                    text_regular_style_custom(
                                      //
                                      dictLoginData['contactNumber'].toString(),
                                      Colors.black,
                                      12.0,
                                    ),
                                    //
                                  ],
                                ),
                              ),
                        //
                        (str_email_hidden == '1')
                            ? const SizedBox(
                                height: 0,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    text_bold_style_custom(
                                      'E-Mail Address',
                                      Colors.black,
                                      16.0,
                                    ),
                                    //
                                    const Spacer(),
                                    //
                                    text_regular_style_custom(
                                      //
                                      dictLoginData['email'].toString(),
                                      Colors.black,
                                      12.0,
                                    ),
                                    //
                                  ],
                                ),
                              ),
                        //
                        (str_skill_hidden == '1')
                            ? const SizedBox(
                                height: 0,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    text_bold_style_custom(
                                      'Skills',
                                      Colors.black,
                                      16.0,
                                    ),
                                    //
                                    const Spacer(),
                                    //
                                    text_regular_style_custom(
                                      //
                                      dictLoginData['favroite_quote']
                                          .toString(),
                                      Colors.black,
                                      12.0,
                                    ),
                                    //
                                  ],
                                ),
                              ),
                        //
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: text_bold_style_custom(
                                  'Address',
                                  Colors.black,
                                  16.0,
                                ),
                              ),
                              //

                              //
                              Align(
                                alignment: Alignment.topLeft,
                                child: text_regular_style_custom(
                                  //
                                  dictLoginData['address'].toString(),
                                  Colors.black,
                                  12.0,
                                ),
                              ),
                              //
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Container header_ui(BuildContext context) {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        // color: Colors.pink,
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(
              54,
              30,
              107,
              1,
            ),
            Color.fromRGBO(
              92,
              21,
              93,
              1,
            ),
            Color.fromRGBO(
              138,
              0,
              70,
              1,
            ),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                    border: Border.all(
                      width: 4.0,
                      color: Colors.white,
                    ),
                  ),
                  child: (dictLoginData['image'].toString() != '')
                      ? (str_image_hidden == '1')
                          ? Image.asset(
                              'assets/images/logo.png',
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                              child: Image.network(
                                dictLoginData['image'].toString(),
                                fit: BoxFit.cover,
                              ),
                            )
                      : Image.asset(
                          'assets/images/logo.png',
                        ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (str_login_user_id ==
                                    dictLoginData['userId'].toString())
                                ? text_bold_style_custom(
                                    //
                                    dictLoginData['fullName'].toString(),
                                    Colors.white,
                                    18.0,
                                  )
                                : text_bold_style_custom(
                                    //
                                    dictLoginData[''].toString(),
                                    Colors.white,
                                    18.0,
                                  ),
                            //
                            Row(
                              children: [
                                const Icon(
                                  Icons.confirmation_num_sharp,
                                  color: Colors.orange,
                                ),
                                //
                                text_bold_style_custom(
                                  //
                                  ' ${dictLoginData['totalPoints']}',
                                  Colors.white,
                                  16.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                        //
                        /*Row(
                              children: [
                                //
                                const Icon(
                                  Icons.confirmation_num_sharp,
                                  color: Colors.orange,
                                ),
                                text_bold_style_custom(
                                  //
                                  ' 0',
                                  Colors.white,
                                  14.0,
                                ),
                              ],
                            ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //
  // profile
  profileWB() async {
    if (kDebugMode) {
      print('=====> POST : PROFILE DATA');
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
          'userId': widget.str_user_id.toString(),
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        if (kDebugMode) {
          print('============= LOGIN USER DATA =====================');
          print(getData);
          print('===================================================');
        }
        //
        setState(() {
          dictLoginData = getData['data'];
          str_login_user_id = dictLoginData['userId'].toString();
          str_loader = '0';
          //
          if (dictLoginData['phoneView'].toString() == '1') {
            str_phone_hidden = '1';
          }
          if (dictLoginData['skillsView'].toString() == '1') {
            str_skill_hidden = '1';
          }
          if (dictLoginData['emailView'].toString() == '1') {
            str_email_hidden = '1';
          }
          if (dictLoginData['imageView'].toString() == '1') {
            str_image_hidden = '1';
          }
          //
        });

        //
      } else {
        if (kDebugMode) {
          print(
            '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
          );
        }
      }
    } else {
      // return postList;
      if (kDebugMode) {
        print('something went wrong');
      }
    }
  }
}
