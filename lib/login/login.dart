// ignore_for_file: non_constant_identifier_names, unused_element, use_build_context_synchronously

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';
import 'package:journey_recorded/dashboard/dashboard.dart';
import 'package:journey_recorded/login/login_modal/login_modal.dart';

import 'package:journey_recorded/registration/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  var str_login_loader = '0';
  //
  bool shouldPop = true;
  // email
  TextEditingController cont_email_address = TextEditingController();
  // password
  TextEditingController cont_password = TextEditingController();
  //
  // MODAL
  final login_service = LoginModal();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBarScreen(
          str_app_bar_title: navigation_title_login.toString(),
          str_back_button_status: '0',
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                image: ExactAssetImage(
                  'assets/images/background.png',
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 240,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: ExactAssetImage(
                          'assets/images/logo.png',
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      'Hello user, welcome back!',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      'Login in your account',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                /*Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.brown,
                ),*/

                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 20.0,
                  ),
                  height: 80,
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
                      padding: const EdgeInsets.all(
                        10.0,
                      ),
                      child: TextFormField(
                        controller: cont_email_address,
                        // keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.person,
                            color: navigation_color,
                          ),
                          border: InputBorder.none,
                          labelText: 'Username...',
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 10.0,
                  ),
                  height: 80,
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
                      padding: const EdgeInsets.all(
                        10.0,
                      ),
                      child: TextFormField(
                        controller: cont_password,
                        // keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.lock,
                            color: navigation_color,
                          ),
                          border: InputBorder.none,
                          labelText: 'Password...',
                        ),
                      ),
                    ),
                  ),
                ),
                //
                // user_business_UI(context),
                //
                // if (str_register_now_status == '0') ... [],

                InkWell(
                    onTap: () {
                      func_call_before_sign_in_validation();
                    },
                    child: (str_login_loader == '0')
                        ? Container(
                            margin: const EdgeInsets.only(
                              top: 20.0,
                              left: 20.0,
                              right: 20.0,
                            ),
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(
                                1,
                                26,
                                77,
                                1,
                              ),
                              borderRadius: BorderRadius.circular(
                                10.0,
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
                            child: Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(
                              10.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                              color: Colors.transparent,
                            ),
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Column(
                                children: const [
                                  CircularProgressIndicator(),
                                ],
                              ),
                            ),
                          )),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Lost your password ?",
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 0.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Don't have an account ? - Sign up",
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // VALIDATION
  func_call_before_sign_in_validation() {
    if (cont_email_address.text == '') {
      _showMyDialog('Email address should not be empty.');
    } else if (cont_password.text == '') {
      _showMyDialog('Password should not be empty.');
    } else {
      print('LOGIN HIT');
      str_login_loader = '1';
      setState(() {});
      login_service
          .login_WB(
        cont_email_address.text,
        cont_password.text,
      )
          .then(
        (value) {
          print('SOMETHING WENT WRONG BUDDY');
          print(value.success_alert);
          if (value.success_alert == 'fails') {
            //
            str_login_loader = '0';
            setState(() {
              //
            });
            _showMyDialog(
              value.message.toString(),
            );
          } else {
            //
            print('=====> Login Success <======');

            setState(() {});
            //
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
            );
          }
        },
      );
    }
  }

  // ALERT
  Future<void> _showMyDialog(
    String str_message,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
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
                  str_message,
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
      },
    );
  }
}
