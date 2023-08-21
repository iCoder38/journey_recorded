// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/dashboard/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyNowSkillPaymentScreen extends StatefulWidget {
  const BuyNowSkillPaymentScreen(
      {super.key,
      required this.strProductId,
      required this.strTotalPrice,
      required this.strProductName,
      required this.strProductQuantity});

  final String strProductId;
  final String strTotalPrice;
  final String strProductName;
  final String strProductQuantity;

  @override
  State<BuyNowSkillPaymentScreen> createState() =>
      _BuyNowSkillPaymentScreenState();
}

class _BuyNowSkillPaymentScreenState extends State<BuyNowSkillPaymentScreen> {
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    text_bold_style_custom(
                      'Product Name : ',
                      Colors.black,
                      16.0,
                    ),
                    //
                    text_regular_style_custom(
                      //
                      widget.strProductName,
                      //
                      Colors.black,
                      14.0,
                    ),
                    //
                  ],
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    text_bold_style_custom(
                      'Quantity : ',
                      Colors.black,
                      16.0,
                    ),
                    //
                    text_regular_style_custom(
                      //
                      widget.strProductQuantity,
                      //
                      Colors.black,
                      14.0,
                    ),
                    //
                  ],
                ),
              ),
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
      print('=====> POST : BUY NOW PAYMENT FOR SKILL');
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
          'action': 'servicebuy',
          'userId': prefs.getInt('userId').toString(),
          'serviceid': widget.strProductId.toString(),
          'amount': widget.strTotalPrice.toString(),
          'transactioID': 'tok_1NhSZfJCQ0WRSbXvoZyHBFfu',
          'type': 'Skill'
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

  /*Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await _createTestPaymentSheet();

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: data['paymentIntent'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['customer'],
          // Extra options
          testEnv: true,
          applePay: true,
          googlePay: true,
          style: ThemeMode.dark,
          merchantCountryCode: 'DE',
        ),
      );
      setState(() {
        // _ready = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }*/
}
