// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditInventoryScreen extends StatefulWidget {
  const EditInventoryScreen({super.key, this.dictGetInventoryDetails});

  final dictGetInventoryDetails;

  @override
  State<EditInventoryScreen> createState() => _EditInventoryScreenState();
}

class _EditInventoryScreenState extends State<EditInventoryScreen> {
  //
  var strCategoryFetched = '0';
  var str_category_id = '';
  var str_category_name = '';
  var arr_get_category_list = [];
  var strSelectItemType = '1';
  var strSaveAndContinueStatus = '0';
  //
  var arr_select_item = [
    {
      'name': 'Assets',
      'id': '1',
    },
    {
      'name': 'Liability',
      'id': '2',
    },
    {
      'name': 'Other',
      'id': '3',
    }
  ];
  //
  final formKey = GlobalKey<FormState>();
  late final TextEditingController contItemName;
  late final TextEditingController contCategory;
  late final TextEditingController contSelectItemType;
  late final TextEditingController contPurchaseDate;
  late final TextEditingController contValueAtPurchase;
  late final TextEditingController contPrice;
  late final TextEditingController cont1stPayment;
  late final TextEditingController contMonthlyPayment;
  late final TextEditingController contHowManyMonthlyPayment;
  late final TextEditingController contImportantExpense;
  late final TextEditingController contPurchaseAdd;
  late final TextEditingController contDescription;
  //
  @override
  void initState() {
    print('======================= INVENTORY DETAILS ========================');
    print(widget.dictGetInventoryDetails);
    print('==================================================================');

    // name
    contItemName = TextEditingController(
        text: widget.dictGetInventoryDetails['name'].toString());
    // category id
    // str_category_id = widget.dictGetInventoryDetails['name'].toString();
    //
    contCategory = TextEditingController();
    contSelectItemType = TextEditingController(
        text: widget.dictGetInventoryDetails['type'].toString());
    contPurchaseDate = TextEditingController(
        text: widget.dictGetInventoryDetails['purchaseDate'].toString());
    contValueAtPurchase = TextEditingController(
        text: widget.dictGetInventoryDetails['cost'].toString());
    contPrice = TextEditingController(
        text: widget.dictGetInventoryDetails['salePrice'].toString());
    cont1stPayment = TextEditingController(
        text: widget.dictGetInventoryDetails['firstPayment'].toString());
    contMonthlyPayment = TextEditingController(
        text: widget.dictGetInventoryDetails['MonthlyPayment'].toString());
    contHowManyMonthlyPayment = TextEditingController(
        text: widget.dictGetInventoryDetails['No_of_month'].toString());
    contImportantExpense = TextEditingController(
        text: widget.dictGetInventoryDetails['expense'].toString());
    contPurchaseAdd = TextEditingController(
        text: widget.dictGetInventoryDetails['advertisement'].toString());
    contDescription = TextEditingController(
        text: widget.dictGetInventoryDetails['description'].toString());

    // api = category list
    getCategoryList();
    super.initState();
  }

  @override
  void dispose() {
    contItemName.dispose();
    contCategory.dispose();
    contSelectItemType.dispose();
    contPurchaseDate.dispose();
    contValueAtPurchase.dispose();
    contPrice.dispose();
    cont1stPayment.dispose();
    contMonthlyPayment.dispose();
    contHowManyMonthlyPayment.dispose();
    contImportantExpense.dispose();
    contPurchaseAdd.dispose();
    contDescription.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: text_bold_style_custom(
            //
            'Edit',
            Colors.white,
            16.0,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop('0'),
          ),
          backgroundColor: navigation_color,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      'Item Name',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      controller: contItemName,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Item Name',
                      ),

                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter item name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      'Category',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                (strCategoryFetched == '0')
                    ? CircularProgressIndicator(
                        color: Colors.pink[200],
                      )
                    : Container(
                        margin: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            14,
                          ),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffDDDDDD),
                              blurRadius: 6.0,
                              spreadRadius: 2.0,
                              offset: Offset(0.0, 0.0),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: contCategory,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Category',
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                              ),
                            ),
                            onTap: () {
                              //
                              if (kDebugMode) {
                                print('category click');
                              }
                              //
                              category_list_POPUP('context');
                            },
                            // validation
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter category';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      'Select Item Type',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      readOnly: true,
                      controller: contSelectItemType,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Item Type',
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                        ),
                      ),
                      onTap: () {
                        //
                        if (kDebugMode) {
                          print('item type click');
                        }
                        //
                        itemTypePOPUP();
                      },
                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select item type';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      'Purchase Date',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      readOnly: true,
                      controller: contPurchaseDate,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Purchase Date',
                        suffixIcon: Icon(
                          Icons.calendar_month,
                        ),
                      ),
                      onTap: () async {
                        //
                        if (kDebugMode) {
                          print('purchase date click');
                        }
                        //
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          if (kDebugMode) {
                            print(pickedDate);
                          }
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          if (kDebugMode) {
                            print(formattedDate);
                          }

                          setState(() {
                            contPurchaseDate.text =
                                formattedDate; //set foratted date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter purchase date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      'Value at Purchase',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: contValueAtPurchase,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Value at Purchase',
                      ),

                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter value at purchase';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      'Price',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: contPrice,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Price',
                      ),

                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      '1st Payment',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: cont1stPayment,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '1st Payment',
                      ),

                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter 1st Payment';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      'Monthly Payment',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: contMonthlyPayment,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Monthly Payment',
                      ),

                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter monthly payment';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      'How many monthly payment',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: contHowManyMonthlyPayment,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'How many monthly payment',
                      ),

                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter how many montly payment';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      'Important Expense',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      controller: contImportantExpense,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Important Expense',
                      ),

                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter important expense';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      'Purchase add. or property add.',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      controller: contPurchaseAdd,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Purchase add. or property add.',
                      ),

                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter purchase add. or property add.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // /***********************************************************/
                // /***********************************************************/
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      'Description',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      controller: contDescription,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Description',
                      ),

                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      //
                      func_reward_WB();
                    }
                  },
                  child: (strSaveAndContinueStatus == '1')
                      ? Container(
                          margin: const EdgeInsets.all(
                            10.0,
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
                          child: const Center(
                            child: CircularProgressIndicator(),
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
                const SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//
  getCategoryList() async {
    if (kDebugMode) {
      print('=====> POST : GET CATEGORY');
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
          'action': 'category',
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    // print(get_data['data']);
    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        arr_get_category_list = getData['data'];

        setState(() {
          strCategoryFetched = '1';
        });
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  //
  // ALERT
  Future<void> category_list_POPUP(
    String str_message,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Please select Category',
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 16.0,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: arr_get_category_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          //
                          str_category_id =
                              arr_get_category_list[index]['id'].toString();
                          //
                          contCategory.text =
                              arr_get_category_list[index]['name'].toString();
                          //
                          setState(() {});
                        },
                        child: ListTile(
                          leading: const Icon(
                            Icons.category,
                          ),
                          title: Text(
                            arr_get_category_list[index]['name'].toString(),
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
              ],
              //
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

  // ALERT
  Future<void> itemTypePOPUP() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: text_bold_style_custom(
            //
            'Please select Item Type',
            Colors.black,
            16.0,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: arr_select_item.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          //
                          Navigator.of(context).pop();
                          strSelectItemType =
                              arr_select_item[index]['id'].toString();
                          contSelectItemType.text =
                              arr_select_item[index]['name'].toString();
                        },
                        child: ListTile(
                          leading: const Icon(
                            Icons.category,
                          ),
                          title: text_regular_style_custom(
                            //
                            arr_select_item[index]['name'].toString(),
                            Colors.black,
                            14.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
              ],
              //
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

  //

  func_reward_WB() async {
    if (kDebugMode) {
      print('=====> POST : EDIT INVENTORY ITEM ');
    }

    setState(() {
      strSaveAndContinueStatus = '1';
    });
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'businessproducts',
          'userId': prefs.getInt('userId').toString(),
          'categoryId': str_category_id.toString(),
          'name': contItemName.text.toString(),
          'type': strSelectItemType.toString(),
          'purchaseDate': contPurchaseDate.text.toString(),
          'cost': contValueAtPurchase.text.toString(),
          'salePrice': contPrice.text.toString(),
          'firstPayment': cont1stPayment.text.toString(),
          'MonthlyPayment': contMonthlyPayment.text.toString(),
          'No_of_month': contHowManyMonthlyPayment.text.toString(),
          'expense': contImportantExpense.text.toString(),
          'advertisement': contPurchaseAdd.text.toString(),
          'description': contDescription.text.toString(),
          'businessType': 'Item'.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(get_data);
    }

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        strSaveAndContinueStatus = '0';
        Navigator.pop(context, '1');
      } else {
        //
        setState(() {
          strSaveAndContinueStatus = '0';
        });
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      setState(() {
        strSaveAndContinueStatus = '0';
      });
    }
  }
}
