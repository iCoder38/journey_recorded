// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/dashboard/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyCartProductsScreen extends StatefulWidget {
  const BuyCartProductsScreen({super.key, required this.strTotalPrice});

  final String strTotalPrice;

  @override
  State<BuyCartProductsScreen> createState() => _BuyCartProductsScreenState();
}

class _BuyCartProductsScreenState extends State<BuyCartProductsScreen> {
  //
  GlobalKey<FormState> formKey = GlobalKey();
  var strpaymentLoader = '';
  //
  late final TextEditingController txtCardHolderName;
  late final TextEditingController txtCardNumber;
  late final TextEditingController txtCardExpYear;
  late final TextEditingController txtCardExpMonth;
  //
  @override
  void initState() {
    txtCardHolderName = TextEditingController();
    txtCardNumber = TextEditingController();
    txtCardExpYear = TextEditingController();
    txtCardExpMonth = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    txtCardHolderName.dispose();
    txtCardNumber.dispose();
    txtCardExpYear.dispose();
    txtCardExpMonth.dispose();

    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          'Payment',
          Colors.white,
          16.0,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: navigation_color,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //

              //
              Container(
                height: 0.4,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: text_bold_style_custom(
                  'Card Details',
                  Colors.black,
                  20.0,
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // asasas('str_message');
                  },
                  controller: txtCardHolderName,
                  //keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card holder name',
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // asasas('str_message');
                  },
                  controller: txtCardNumber,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(16),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card number',
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              //
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(
                        10.0,
                      ),
                      child: TextFormField(
                        readOnly: false,
                        onTap: () {
                          // asasas('str_message');
                        },
                        controller: txtCardExpMonth,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expiry Month',
                        ),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  //
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(
                        10.0,
                      ),
                      child: TextFormField(
                        readOnly: false,
                        onTap: () {
                          // asasas('str_message');
                        },
                        controller: txtCardExpYear,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expiry Year',
                        ),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    //
                    if (formKey.currentState!.validate()) {
                      //
                      paymentScreenPopupUI();
                      funcSendDataToServer();
                    }
                  },
                  child: Container(
                    height: 60,
                    // width: 100,

                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(170, 200, 240, 1),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.credit_card),
                          const SizedBox(
                            width: 10,
                          ),
                          text_bold_style_custom(
                            'Buy Now \$${widget.strTotalPrice}',
                            Colors.black,
                            14.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  funcSendDataToServer() async {
    if (kDebugMode) {
      print('=====> POST : BUY NOW PAYMENT');
    }

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
          'action': 'purchase',
          'userId': prefs.getInt('userId').toString(),
          'totalAmount': widget.strTotalPrice.toString(),
          'transactioID': 'tok_1NhSZfJCQ0WRSbXvoZyHBFfu'
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
        // get and parse data
        Navigator.pop(context);
        //
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
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

  // ALERT
  void paymentScreenPopupUI() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 40,
            child: Center(
              child: text_regular_style_custom(
                'please wait...',
                Colors.black,
                14.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
