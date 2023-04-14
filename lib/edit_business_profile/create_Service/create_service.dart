// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  //
  var str_main_loader = '0';
  //
  var str_save_and_continue_loader = '0';
  //
  File? imageFile;
  var str_image_status = '0';
  //
  final _formKey = GlobalKey<FormState>();
  //
  late final TextEditingController cont_service;
  late final TextEditingController cont_name;
  late final TextEditingController cont_price;
  //
  var str_service_id = '';
  //
  var arr_service_list = [];
  //
  @override
  void initState() {
    super.initState();
    //
    cont_service = TextEditingController();
    cont_name = TextEditingController();
    cont_price = TextEditingController();
    //
    get_category_list_WB();
    //
  }

// get category list
  get_category_list_WB() async {
    print('=====> POST : GET SPECIAL LIST');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      /*
      [action] => speciallist
    [userId] => 52
    [serviceType] => Service
      */
      body: jsonEncode(
        <String, String>{
          'action': 'speciallist',
          'userId': prefs.getInt('userId').toString(),
          'serviceType': 'Service',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_service_list = get_data['data'];

        setState(() {
          str_main_loader = '1';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: 'Create Service',
        str_back_button_status: '1',
      ),
      body: Form(
        // str_main_loader = 'create_new';
        key: _formKey,
        child: Column(
          children: <Widget>[
            if (str_main_loader == '0')
              const CustomeLoaderPopUp(
                str_custom_loader: 'please wait...',
                str_status: '4',
              )
            else if (str_main_loader == 'create_new')
              Column(
                children: [
                  const SizedBox(
                    height: 0,
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
                      controller: cont_service,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Service Name',
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                        ),
                      ),
                      onChanged: (value) {},
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
                        upload_info_profile_picture();
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
                            'Save',
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        str_main_loader = '2';
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(
                        10.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        color: Colors.red[400],
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
                          'Dismiss',
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
              )
            else
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        open_service_list(context);
                      },
                      controller: cont_service,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Service',
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
                      onTap: () {
                        // asasas('str_message');
                      },
                      controller: cont_name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      onTap: () {
                        // asasas('str_message');
                      },
                      controller: cont_price,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                      ),
                      onChanged: (value) {},
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
                        add_service_WB();
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
                ],
              )
          ],
        ),
      ),
    );
  }

  // open service
  void open_service_list(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Service'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          for (int i = 0; i < arr_service_list.length; i++) ...[
            CupertinoActionSheetAction(
              onPressed: () async {
                cont_service.text = arr_service_list[i]['name'].toString();
                str_service_id = arr_service_list[i]['productId'].toString();
                Navigator.pop(context);
              },
              child: Text(
                //
                arr_service_list[i]['name'].toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              setState(() {
                str_main_loader = 'create_new';
                cont_name.text = '';
                cont_service.text = '';
              });
            },
            child: Text(
              'Create New',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
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

//
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

  upload_info_profile_picture() async {
    print('=====> POST : SPECIAL ADD SERVICE');

    setState(() {
      //str_main_loader = '2';
      str_save_and_continue_loader = '1';
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
          'action': 'specialadd',
          'userId': prefs.getInt('userId').toString(),
          'name': cont_service.text.toString(),
          'parentId': '0'.toString(),
          'serviceType': 'Service'.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //

        search_id();
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

  // add service
  add_service_WB() async {
    print('=====> POST : ADD SERVICE');

    setState(() {
      str_save_and_continue_loader = '1';
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
          'action': 'specialadd',
          'userId': prefs.getInt('userId').toString(),
          'name': cont_name.text.toString(),
          'price': cont_price.text.toString(),
          'parentId': str_service_id.toString(),
          'serviceType': 'Service'.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        setState(() {
          str_main_loader = '2';
          str_save_and_continue_loader = '0';
        });
        Navigator.pop(context, '');
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

  // get id
  // get category list
  search_id() async {
    print('=====> POST : GET SPECIAL LIST');

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
          'action': 'speciallist',
          'userId': prefs.getInt('userId').toString(),
          'serviceType': 'Service',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    if (resposne.statusCode == 200) {
      arr_service_list.clear();
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        // print('====> qwqw qwq wq wqw q');

        arr_service_list = get_data['data'];

        // print(cont_name.text);
        // print(cont_service.text);

        for (int i = 0; i < arr_service_list.length; i++) {
          if (cont_service.text == arr_service_list[i]['name'].toString()) {
            // print(arr_service_list[i]);
            str_service_id = arr_service_list[i]['productId'].toString();
          }
        }
        setState(() {
          str_main_loader = '2';
          str_save_and_continue_loader = '0';
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
}
