// ignore_for_file: non_constant_identifier_names, unused_element, unused_local_variable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';
import 'package:journey_recorded/registration/full_registration/full_registration_modal.dart';
import 'package:journey_recorded/registration/registration_verify_username_modal/verify_username_modal.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //
  var str_register_now_loader = '0';
  //
  var str_user_clicked_status = '0';
  var str_business_clicked_status = '0';
  //
  var str_verify_username_status = '0';
  var str_get_status = '';
  var str_register_now_status = '0';
  // MODALS
  final verify_username_service = VerifyUsernameModal();
  final registration_service = RegistrationModal();
  //
  // username
  TextEditingController cont_username = TextEditingController();
  // email
  TextEditingController cont_email_address = TextEditingController();
  // full name
  TextEditingController cont_full_name = TextEditingController();
  // contact number
  TextEditingController cont_contact_number = TextEditingController();
  // password
  TextEditingController cont_password = TextEditingController();

  //
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBarScreen(
          str_app_bar_title: navigation_title_registration,
          str_back_button_status: '1',
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            // color: Colors.amber,
            decoration: const BoxDecoration(
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
                      'Welcome to Journey Recorded!',
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
                      'Create an account now',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 0.0,
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(
                              10.0,
                            ),
                            child: TextFormField(
                              controller: cont_username,
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
                          right: 20.0,
                        ),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                        ),
                        child: (str_verify_username_status == '1')
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 1.5,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  func_verify_username();
                                },
                                child: Center(
                                  child: (str_verify_username_status == '2')
                                      ? Text(
                                          'Verified',
                                          style: TextStyle(
                                            fontFamily: font_style_name,
                                            fontSize: 14.0,
                                            color: Colors.green,
                                          ),
                                        )
                                      : Text(
                                          'Verify',
                                          style: TextStyle(
                                            fontFamily: font_style_name,
                                            fontSize: 14.0,
                                            color: Colors.blue,
                                          ),
                                        ),
                                ),
                              ),
                      ),
                    ],
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
                        controller: cont_email_address,
                        // keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
                            color: navigation_color,
                          ),
                          border: InputBorder.none,
                          labelText: 'Email Address...',
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
                user_business_UI(context),
                //

                if (str_register_now_status == '0')
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey,
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
                        'Register now',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                else if (str_register_now_status == '2')
                  Container(
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
                  )
                else
                  InkWell(
                    onTap: () {
                      func_register_now_validation_before_register();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
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
                          'Register now',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container user_business_UI(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10),
      height: 160,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                func_user_text_validation();
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                ),
                height: 80,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(
                    250,
                    0,
                    30,
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
                child: (str_user_clicked_status == '0')
                    ? Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                    color: const Color.fromRGBO(
                                      202,
                                      202,
                                      202,
                                      1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Color.fromRGBO(
                                      250,
                                      0,
                                      30,
                                      1,
                                    ),
                                  ),
                                ),
                              ),
                              const TextSpan(
                                text: ' ',
                              ),
                              TextSpan(
                                text: ' User',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                    color: const Color.fromRGBO(
                                      250,
                                      220,
                                      12,
                                      1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Color.fromRGBO(
                                      250,
                                      0,
                                      30,
                                      1,
                                    ),
                                  ),
                                ),
                              ),
                              const TextSpan(
                                text: ' ',
                              ),
                              TextSpan(
                                text: ' User',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                ///
                ///
                ///
                ///
                ///
              ),
            ),
          ),
          //
          //
          // BUSINESS
          //
          //
          Expanded(
            child: InkWell(
              onTap: () {
                func_business_text_validation();
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                height: 80,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(
                    36,
                    166,
                    234,
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
                child: (str_business_clicked_status == '0')
                    ? Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                    color: const Color.fromRGBO(
                                      202,
                                      202,
                                      202,
                                      1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Color.fromRGBO(
                                      36,
                                      166,
                                      234,
                                      1,
                                    ),
                                  ),
                                ),
                              ),
                              const TextSpan(
                                text: ' ',
                              ),
                              TextSpan(
                                text: ' Business',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                    color: const Color.fromRGBO(
                                      250,
                                      220,
                                      12,
                                      1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Color.fromRGBO(
                                      36,
                                      166,
                                      234,
                                      1,
                                    ),
                                  ),
                                ),
                              ),
                              const TextSpan(
                                text: ' ',
                              ),
                              TextSpan(
                                text: ' Business',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  func_verify_username() {
    str_verify_username_status = '1';
    // change this status when verify success

    //
    setState(() {});
    //
    print('webservice hit');

    //
    verify_username_service.verify_usename_WB(cont_username.text).then(
      (value) {
        print('SOMETHING WENT WRONG BUDDY');
        print(value.success_alert);
        if (value.success_alert == 'fails') {
          setState(() {
            //
            // verified username availaible
            str_verify_username_status = '0';

            // username done
            str_register_now_status = '0';
            //
          });
          _showMyDialog(
            value.message.toString(),
          );
        } else {
          //
          print('=====> Username Verification Success <======');

          // verified username availaible
          str_verify_username_status = '2';

          // username done
          str_register_now_status = '1';

          setState(() {});
          //
        }
      },
    );
  }

  // user validation
  func_user_text_validation() {
    str_get_status = 'Member';

    str_user_clicked_status = '1';
    str_business_clicked_status = '0';

    setState(() {});
    //
    print(str_get_status);
  }

  // business validation
  func_business_text_validation() {
    str_get_status = 'Business';

    str_user_clicked_status = '0';
    str_business_clicked_status = '1';

    setState(() {});
    //
    print(str_get_status);
  }

// FULL REGISTRATION
  func_register_now_validation_before_register() {
    if (str_user_clicked_status == '1' ||
        str_business_clicked_status == '1' &&
            str_verify_username_status == '2') {
      // push
      print('=====> ALL VALUE DONE <=====');

      str_register_now_status = '2';
      setState(() {});

      registration_service
          .create_user_WB(
        cont_full_name.text.toString(),
        cont_username.text.toString(),
        cont_email_address.text.toString(),
        cont_contact_number.text.toString(),
        cont_password.text.toString(),
        str_get_status.toString(),
      )
          .then(
        (value) {
          print('SOMETHING WENT WRONG BUDDY');
          print(value.success_alert);
          if (value.success_alert == 'fails') {
            str_register_now_status = '0';
            setState(() {});

            _showMyDialog(
              value.message.toString(),
            );
          } else {
            //
            str_register_now_status = '1';
            Navigator.pop(context);
            print('=====> SUCCESSFULLY REGISTRATION <======');
            //
          }
        },
      );
    } else {
      _showMyDialog('Please select all values');
    }
  }

  // alert
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
