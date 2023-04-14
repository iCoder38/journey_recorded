// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateSpecialScreen extends StatefulWidget {
  const CreateSpecialScreen({super.key});

  @override
  State<CreateSpecialScreen> createState() => _CreateSpecialScreenState();
}

class _CreateSpecialScreenState extends State<CreateSpecialScreen> {
  //
  var str_save_and_continue_loader = '0';
  //
  File? imageFile;
  //
  late final TextEditingController cont_name;
  late final TextEditingController cont_price;
  //
  var str_image_status = '0';
  //
  @override
  void initState() {
    super.initState();
    //
    cont_name = TextEditingController();
    cont_price = TextEditingController();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: 'Create Special',
        str_back_button_status: '1',
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(
              10.0,
            ),
            child: TextFormField(
              onTap: () {},
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
              onTap: () {},
              controller: cont_price,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
              ),
              onChanged: (value) {},
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Align(
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
          ),
          if (str_save_and_continue_loader == '1')
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            )
          else
            InkWell(
              onTap: () {
                validation_alert();
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

  //
  validation_alert() {
    if (str_image_status == '0') {
      gear_popup('Alert');
    } else {
      upload_info_profile_picture();
    }
  }

  upload_info_profile_picture() async {
    setState(() {
      str_save_and_continue_loader = '1';
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request =
        await http.MultipartRequest('POST', Uri.parse(application_base_url));

    request.fields['action'] = 'specialadd';
    request.fields['userId'] = prefs.getInt('userId').toString();

    request.fields['name'] = cont_name.text.toString();
    request.fields['parentId'] = '0'.toString();
    request.fields['price'] = cont_price.text.toString();
    request.fields['serviceType'] = 'Special';

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
    } else {
      setState(() {
        str_save_and_continue_loader = '0';
      });
    }

    //
  }

  //
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
}
