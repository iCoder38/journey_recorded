// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/drawer.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:flutter_email_sender/flutter_email_sender.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  //
  //

  var str_phone = 'please wait...';
  var str_email = 'please wait...';
  //
  //

  @override
  void initState() {
    super.initState();
    get_help_WB();
  }

  // get help
  get_help_WB() async {
    print('=====> GET CART');

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'help',
        },
      ),
    );

// convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      ///
      ///
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        str_email = get_data['data']['eamil'].toString();
        str_phone = get_data['data']['phone'].toString();
        //
        setState(() {});
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          'Help', Colors.white, 16.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: navigation_color,
      ),
      drawer: const navigationDrawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              height: 240,
              width: 240,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage(
                    // image name
                    'assets/images/logo.png',
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // height: 300,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: text_bold_style_custom(
                          'Connect with Us',
                          Colors.black,
                          16.0,
                        ),
                      ),
                      //height: 20,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _sendingMails();
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: text_regular_style_custom(
                            str_email.toString(),
                            Colors.black,
                            14.0,
                          ),
                        ),
                        //height: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        FlutterPhoneDirectCaller.callNumber(
                          str_phone.toString(),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: text_regular_style_custom(
                            str_phone.toString(),
                            Colors.black,
                            14.0,
                          ),
                        ),
                        //height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              // height: 300,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Center(
                child: Align(
                  alignment: Alignment.center,
                  child: text_regular_style_custom(
                    '@ 2023 Journey Recorded.\n        All Rights Reserved.',
                    Colors.black,
                    12.0,
                  ),
                ),
              ),
            ),
          ),
          /*Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Container(
                // height: 100,
                width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(
                      // image name
                      logo_name_image,
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // height: 500,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: Expanded(
                flex: 4,
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(
                          12.0,
                        ),
                        child: Text(
                          '@ 2022 Triple R Custom Detail.',
                          style: TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          12.0,
                        ),
                        child: Text(
                          'All Rights Reserved',
                          style: TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // height: 500,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: Expanded(
                flex: 4,
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(
                          12.0,
                        ),
                        child: Text(
                          '@ 2022 Triple R Custom Detail.',
                          style: TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          12.0,
                        ),
                        child: Text(
                          'All Rights Reserved',
                          style: TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )*/
        ],
      ),
    );
  }

  _sendingMails() async {
    var url = Uri.parse("mailto:$str_email");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
