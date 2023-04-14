// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({super.key});

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  //
  File? imageFile;
  var str_image_status = '0';
  //
  var str_save_and_continue_loader = '0';
  //
  var str_category_id = '';
  var arr_get_category_list = [];
  //
  final _formKey = GlobalKey<FormState>();
  //
  late final TextEditingController cont_item_name;
  late final TextEditingController cont_cateogry;
  late final TextEditingController cont_select_item_type;
  late final TextEditingController cont_purchase_Date;
  late final TextEditingController cont_value_at_purchase;
  late final TextEditingController cont_price;
  late final TextEditingController cont_1st_payment;
  late final TextEditingController cont_monthly_payment;
  late final TextEditingController cont_how_many;
  late final TextEditingController cont_important_expense;
  late final TextEditingController cont_purchase;
  late final TextEditingController cont_description;
  //
  @override
  void initState() {
    super.initState();
    //
    cont_item_name = TextEditingController();
    cont_cateogry = TextEditingController();
    cont_select_item_type = TextEditingController();
    cont_purchase_Date = TextEditingController();
    cont_value_at_purchase = TextEditingController();
    cont_price = TextEditingController();
    cont_1st_payment = TextEditingController();
    cont_monthly_payment = TextEditingController();
    cont_how_many = TextEditingController();
    cont_important_expense = TextEditingController();
    cont_purchase = TextEditingController();
    cont_description = TextEditingController();
    //
    get_category_list_WB();
  }

  // get category list
  get_category_list_WB() async {
    print('=====> POST : GET CATEGORY');

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
          // 'userId': prefs.getInt('userId').toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);

    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_get_category_list = get_data['data'];

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

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: 'Create Item',
        str_back_button_status: '1',
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // open_service_list(context);
                  },
                  controller: cont_item_name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Item Name',
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    category_list_POPUP();
                  },
                  controller: cont_cateogry,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category',
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // open_service_list(context);
                  },
                  controller: cont_select_item_type,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select item Type',
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);

                      setState(() {
                        cont_purchase_Date.text =
                            formattedDate; //set foratted date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  controller: cont_purchase_Date,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Purchase Date',
                    suffixIcon: Icon(
                      Icons.calendar_month,
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // open_service_list(context);
                  },
                  controller: cont_value_at_purchase,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Value at purchase',
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // open_service_list(context);
                  },
                  controller: cont_price,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // open_service_list(context);
                  },
                  controller: cont_1st_payment,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '1st Payment',
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // open_service_list(context);
                  },
                  controller: cont_monthly_payment,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Monthly payment',
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // open_service_list(context);
                  },
                  controller: cont_how_many,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'How many monthly payments',
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // open_service_list(context);
                  },
                  controller: cont_important_expense,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Important Expense',
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // open_service_list(context);
                  },
                  controller: cont_purchase,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Purchase add. or property add.',
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    // open_service_list(context);
                  },
                  controller: cont_description,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  onChanged: (value) {},
                  maxLines: 6,
                ),
              ),
              Align(
                child: InkWell(
                  onTap: () {
                    camera_gallery_for_profile(context);
                  },
                  child: imageFile == null
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          child: Image.file(
                            fit: BoxFit.cover,
                            //
                            imageFile!,
                            //
                            height: 150.0,
                            width: 100.0,
                          ),
                        ),
                ),
              ),
              if (str_save_and_continue_loader == '1')
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              else
                InkWell(
                  onTap: () {
                    //
                    func_validate_WB();
                    //
                  },
                  child: Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      color: navigation_color,
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
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void camera_gallery_for_profile(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Camera option'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.camera,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  str_image_status = '1';
                  imageFile = File(pickedFile.path);
                });
              }
            },
            child: Text(
              'Open Camera',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.gallery,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                print('object 22.22');

                setState(() {
                  str_image_status = '1';
                  imageFile = File(pickedFile.path);
                });
              }
            },
            child: Text(
              'Open Gallery',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

// ALERT
  Future<void> category_list_POPUP() async {
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
                          cont_cateogry.text =
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

  func_validate_WB() {
    if (str_image_status == '0') {
      gear_popup('Alert');
    } else {
      func_submit_item_WB();
    }
  }

// ALERT
  Future<void> gear_popup(
    String str_title,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            str_title.toString(),
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print('edit 2');
                    Navigator.pop(context);

                    // _navigateAndDisplaySelection(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Please select image.',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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

  // submit item
  func_submit_item_WB() async {
    if (kDebugMode) {
      print('submit item');
    }

    setState(() {
      str_save_and_continue_loader = '1';
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request =
        await http.MultipartRequest('POST', Uri.parse(application_base_url));

/*
[action] => productadd
    [userId] => 42
    [categoryId] => 1
    [name] => r
    [type] => Assets
    [purchaseDate] => 2023-01-17
    [cost] => 22
    [salePrice] => 22
    [firstPayment] => 02
    [MonthlyPayment] => 55
    [No_of_month] => 22
    [expense] => fff
    [advertisement] => ffff
    [description] => ffg
    [businessType] => Item
          */
    request.fields['action'] = 'productadd';
    request.fields['userId'] = prefs.getInt('userId').toString();

    request.fields['categoryId'] = str_category_id.toString();
    request.fields['name'] = cont_item_name.text.toString();
    request.fields['type'] = cont_select_item_type.text.toString();
    request.fields['purchaseDate'] = cont_purchase_Date.text.toString();
    request.fields['salePrice'] = cont_price.text.toString();
    request.fields['firstPayment'] = cont_1st_payment.text.toString();
    request.fields['MonthlyPayment'] = cont_monthly_payment.text.toString();
    request.fields['No_of_month'] = cont_how_many.text.toString();
    request.fields['expense'] = cont_important_expense.text.toString();
    request.fields['advertisement'] = cont_purchase.text.toString();
    request.fields['description'] = cont_description.text.toString();
    request.fields['businessType'] = 'Item';

    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile!.path));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responsedData = json.decode(responsed.body);
    print(responsedData);

    if (responsedData['status'].toString().toLowerCase() == 'success') {
      imageFile = null;
      str_image_status = '0';
      Navigator.pop(context, '');

      setState(() {
        str_save_and_continue_loader = '0';
      });
    }
  }
}
