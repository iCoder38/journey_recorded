import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/shops/payment_list/buy_now_payment_screen.dart';
import 'package:journey_recorded/shops/payment_list/buy_now_skill_payment_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen(
      {super.key,
      required this.strAddressProductId,
      required this.strAddressTotalPrice,
      required this.strAddressProductName,
      required this.strAddressProductQuantity,
      required this.strWhichProfile});

  final String strAddressProductId;
  final String strAddressTotalPrice;
  final String strAddressProductName;
  final String strAddressProductQuantity;
  //
  final String strWhichProfile;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  //
  GlobalKey<FormState> formKey = GlobalKey();
  var strpaymentLoader = '';
  //

  late final TextEditingController txtName;
  late final TextEditingController txtPhoneNumber;
  late final TextEditingController txtAddress;
  late final TextEditingController txtPinCode;
  //
  var strName = '';
  var strPhoneNumber = '';

  @override
  void initState() {
    txtName = TextEditingController();
    txtPhoneNumber = TextEditingController();
    txtAddress = TextEditingController();
    txtPinCode = TextEditingController();

    funcGetLoginUserDetails();

    super.initState();
  }

  @override
  void dispose() {
    txtName.dispose();
    txtPhoneNumber.dispose();
    txtAddress.dispose();
    txtPinCode.dispose();

    super.dispose();
  }

  funcGetLoginUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print(prefs.getString('fullName'));
      print(prefs.getString('contactNumber'));
      print(prefs.getString('businessAddress'));
    }
    //
    strName = prefs.getString('fullName').toString();
    strPhoneNumber = prefs.getString('contactNumber').toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          'Address',
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
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    // asasas('str_message');
                  },
                  controller: txtName,
                  //keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: strName,
                    hintText: strName,
                  ),

                  onChanged: (value) {
                    //
                  },
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    // asasas('str_message');
                  },
                  controller: txtPhoneNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: strPhoneNumber,
                    hintText: strPhoneNumber,
                  ),
                  onChanged: (value) {},
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
                  controller: txtAddress,
                  // keyboardType: TextInputType.,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Address';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // asasas('str_message');
                  },
                  controller: txtPinCode,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pincode',
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter txtPinCode';
                    }
                    return null;
                  },
                ),
              ), //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    //
                    if (formKey.currentState!.validate()) {
                      //
                      if (widget.strWhichProfile == 'product') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuyNowPaymentScreen(
                              strProductId:
                                  widget.strAddressProductId.toString(),
                              strTotalPrice: widget.strAddressTotalPrice,
                              strProductName:
                                  widget.strAddressProductName.toString(),
                              strProductQuantity:
                                  widget.strAddressProductQuantity.toString(),
                              //
                              strAddressUserName: strName.toString(),
                              strAddressUserPhone: strPhoneNumber.toString(),
                              strAddressUserAddress: txtAddress.text.toString(),
                              strAddressUserPincode: txtPinCode.text.toString(),
                            ),
                          ),
                        );
                      } else if (widget.strWhichProfile == 'skill') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuyNowSkillPaymentScreen(
                              strProductId:
                                  widget.strAddressProductId.toString(),
                              strTotalPrice: widget.strAddressTotalPrice,
                              strProductName:
                                  widget.strAddressProductName.toString(),
                              strProductQuantity:
                                  widget.strAddressProductQuantity.toString(),
                              //
                              strAddressUserName: strName.toString(),
                              strAddressUserPhone: strPhoneNumber.toString(),
                              strAddressUserAddress: txtAddress.text.toString(),
                              strAddressUserPincode: txtPinCode.text.toString(),
                            ),
                          ),
                        );
                      }
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
                      child: text_bold_style_custom(
                        'Submit',
                        Colors.black,
                        14.0,
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
}
