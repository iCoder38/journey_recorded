import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class AddItemDeliveryScreen extends StatefulWidget {
  const AddItemDeliveryScreen({super.key});

  @override
  State<AddItemDeliveryScreen> createState() => _AddItemDeliveryScreenState();
}

class _AddItemDeliveryScreenState extends State<AddItemDeliveryScreen> {
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
    contItemName = TextEditingController();
    contCategory = TextEditingController();
    contSelectItemType = TextEditingController();
    contPurchaseDate = TextEditingController();
    contValueAtPurchase = TextEditingController();
    contPrice = TextEditingController();
    cont1stPayment = TextEditingController();
    contMonthlyPayment = TextEditingController();
    contHowManyMonthlyPayment = TextEditingController();
    contImportantExpense = TextEditingController();
    contPurchaseAdd = TextEditingController();
    contDescription = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          'Add Item',
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
                    controller: contCategory,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Category',
                    ),
                    onTap: () {
                      //
                      if (kDebugMode) {
                        print('category click');
                      }
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
                    ),
                    onTap: () {
                      //
                      if (kDebugMode) {
                        print('item type click');
                      }
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
                    ),
                    onTap: () {
                      //
                      if (kDebugMode) {
                        print('purchase date click');
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
                    // funcCreateGrind();
                    //
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );
                  }
                },
                child: Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
