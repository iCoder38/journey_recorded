// ignore_for_file: avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/drawer.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  //
  var strSubmitLoader = '0';
  GlobalKey<FormState> formKey = GlobalKey();
  late final TextEditingController contOldPassword;
  late final TextEditingController contNewPassword;
  late final TextEditingController contConfirmPassword;
  //
  @override
  void initState() {
    super.initState();

    contOldPassword = TextEditingController();
    contNewPassword = TextEditingController();
    contConfirmPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          'Change Password', Colors.white, 16.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: navigation_color,
      ),
      drawer: const navigationDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                height: 260,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        color: navigation_color,
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    //
                    text_bold_style_custom(
                      'Create new Password',
                      Colors.black,
                      18.0,
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: text_regular_style_custom(
                          'Please enter your email address and you will receive a password via email',
                          Colors.black,
                          12.0,
                        ),
                      ),
                    ),
                    //

                    //
                  ],
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 10.0,
                ),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(
                    28.0,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: contOldPassword,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.lock,
                          color: navigation_color,
                        ),
                        border: InputBorder.none,
                        hintText: 'Old password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter value';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 10.0,
                ),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(
                    28.0,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: contNewPassword,
                      // keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.lock,
                          color: navigation_color,
                        ),
                        border: InputBorder.none,
                        hintText: 'New password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter value';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 10.0,
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(
                      28.0,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: TextFormField(
                        obscureText: true,
                        controller: contConfirmPassword,
                        // keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.lock,
                            color: navigation_color,
                          ),
                          border: InputBorder.none,
                          hintText: 'Confirm password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    //
                    if (formKey.currentState!.validate()) {
                      //
                      funcChangePasswordWB();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10.0,
                    ),
                    height: 60,
                    // width: 100,

                    decoration: BoxDecoration(
                      color: navigation_color,
                      border: Border.all(width: 0.2),
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: Center(
                      child: (strSubmitLoader == '1')
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : text_bold_style_custom(
                              'Update Password',
                              Colors.white,
                              14.0,
                            ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // create training
  funcChangePasswordWB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      strSubmitLoader = '1';
    });
    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'changePassword',
          'userId': prefs.getInt('userId').toString(),
          'oldPassword': contOldPassword.text.toString(),
          'newPassword': contNewPassword.text.toString(),
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
          strSubmitLoader = '0';
          contOldPassword.text = '';
          contNewPassword.text = '';
          contConfirmPassword.text = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            closeIconColor: Colors.amber,
            content: Text(
              getData['msg'].toString(),
            ),
            backgroundColor: Colors.green,
          ),
        );
        //
      } else {
        // str_save_and_continue_loader = '0';
        setState(() {
          strSubmitLoader = '0';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            closeIconColor: Colors.amber,
            content: Text(
              getData['msg'].toString(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // str_save_and_continue_loader = '0';
      setState(() {});
      // return postList;
      print('something went wrong');
    }
  }
}
