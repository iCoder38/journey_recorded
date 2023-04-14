// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessCodeScreen extends StatefulWidget {
  const AccessCodeScreen(
      {super.key,
      required this.str_guild_name,
      required this.str_access_code,
      required this.str_guild_id});

  final String str_guild_id;
  final String str_guild_name;
  final String str_access_code;

  @override
  State<AccessCodeScreen> createState() => _AccessCodeScreenState();
}

class _AccessCodeScreenState extends State<AccessCodeScreen> {
  //
  var str_save_and_continue_loader = '1';
  //
  TextEditingController cont_guild_name = TextEditingController();
  TextEditingController cont_access_code = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, 'back');
          },
        ),
        title: Text(
          //
          'Access Code',
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              top: 20,
              right: 20,
            ),
            height: 58,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                14.0,
              ),
            ),
            child: TextField(
              enabled: false,
              controller: cont_guild_name,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                if (kDebugMode) {
                  print("Go button is clicked");
                }
              },
              decoration: InputDecoration(
                // labelText: "Search",
                labelText: widget.str_guild_name.toString(),
                hintText: 'Guild Name',
                // prefixIcon: Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          //
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              top: 20,
              right: 20,
            ),
            height: 58,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                14.0,
              ),
            ),
            child: TextField(
              controller: cont_access_code,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                if (kDebugMode) {
                  print("Go button is clicked");
                }
              },
              decoration: const InputDecoration(
                // labelText: "Search",
                hintText: 'Access Code',
                // prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          //
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              func_match_access_code();
            },
            child: (str_save_and_continue_loader == '0')
                ? const CircularProgressIndicator()
                : Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      color: const Color.fromRGBO(
                        250,
                        42,
                        18,
                        1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(
                            0,
                            3,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'Save and Continue',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  //
  func_match_access_code() {
    if (kDebugMode) {
      print(cont_access_code.text);
    }

    if (widget.str_access_code == cont_access_code.text.toString()) {
      //
      func_save_and_continue_WB();
      //
    } else {
      func_access_code_pop_up();
    }
  }

  //
  func_access_code_pop_up() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert',
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Please enter your correct access code here.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'dismiss',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //
  func_save_and_continue_WB() async {
    print('object');
    setState(() {
      str_save_and_continue_loader = '0';
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getInt('userId').toString());
    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'gulidjoin',
          'userId': prefs.getInt('userId').toString(),
          'gulidId': widget.str_guild_id.toString(),
          'join': 'Yes',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //

        Navigator.of(context)
          ..pop()
          ..pop('back');
        //
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
      print('something went wrong');
    }
  }
  //
}
