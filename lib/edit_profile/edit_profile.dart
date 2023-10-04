// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/drawer.dart';
import 'package:journey_recorded/edit_business_profile/edit_business_profile.dart';

import 'dart:convert';
import 'dart:io';

// import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, this.getLoginUserDetails});

  final getLoginUserDetails;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  //
  var str_business_address = '';
  var str_business_fax = '';
  //
  var str_save_and_continue_loader = '0';
  // ImagePicker picker = ImagePicker();
  // XFile? image;
  File? imageFile;
  var strImageSetType = '0';
  //
  final _formKey = GlobalKey<FormState>();
  //
  late final TextEditingController cont_full_name;
  late final TextEditingController cont_user_name;
  late final TextEditingController cont_email_address;
  late final TextEditingController cont_mobile_number;
  late final TextEditingController cont_address;
  late final TextEditingController cont_career;
  late final TextEditingController cont_skills;
  //
  var str_image_status = '0';
  //

  @override
  void initState() {
    super.initState();
    //

    //
    cont_full_name = TextEditingController(
        text: widget.getLoginUserDetails['fullName'].toString());
    cont_user_name = TextEditingController(
        text: widget.getLoginUserDetails['username'].toString());
    cont_email_address = TextEditingController(
        text: widget.getLoginUserDetails['email'].toString());
    cont_mobile_number = TextEditingController(
        text: widget.getLoginUserDetails['contactNumber'].toString());
    cont_address = TextEditingController(
        text: widget.getLoginUserDetails['address'].toString());
    cont_career = TextEditingController(
        text: widget.getLoginUserDetails['career'].toString());
    cont_skills = TextEditingController(
        text: widget.getLoginUserDetails['favroite_quote'].toString());
    //
    func_get_login_user_data_all_value();
  }

  // func_
  func_get_login_user_data_all_value() async {
    // print(prefs.getString('image'));
    if (widget.getLoginUserDetails['image'].toString() == '') {
      imageFile = null;
    } else {
      imageFile = File(widget.getLoginUserDetails['image']!);
      // print(imageFile.toString());
      strImageSetType = '1';

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        title: text_bold_style_custom(
          'Edit Profile',
          Colors.white,
          16.0,
        ),
        leading: IconButton(
          onPressed: () {
            //
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  camera_gallery_for_profile(context);
                },
                child: upload_image_UI(context),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  onTap: () {
                    // asasas('str_message');
                  },
                  controller: cont_full_name,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Full Name',
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
                    // asasas('str_message');
                  },
                  controller: cont_user_name,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Username',
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
                    // asasas('str_message');
                  },
                  controller: cont_email_address,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Email address',
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
                  controller: cont_mobile_number,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Mobile Number',
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
                  controller: cont_address,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Address',
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
                  controller: cont_career,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Career',
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
                  controller: cont_skills,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Skills',
                  ),
                  onChanged: (value) {},
                ),
              ),
              //
              if (str_save_and_continue_loader == '1')
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              else
                InkWell(
                  onTap: () {
                    func_check_with_image_or_without();
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
                        'Update',
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
              /*InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditBusinessProfileScreen(
                        str_email_address: cont_email_address.text.toString(),
                        str_name: cont_full_name.text.toString(),
                        str_phone: cont_mobile_number.text.toString(),
                        str_address: cont_address.text.toString(),
                        str_business_website: str_business_address.toString(),
                        str_fax: str_business_fax.toString(),
                      ),
                    ),
                  );
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
                      'Business Information',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Container upload_image_UI(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      color: Colors.red[400],
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: Align(
        child: imageFile == null
            ? Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
              )
            : (strImageSetType == '1')
                ? Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      child: Image.network(
                        fit: BoxFit.cover,
                        //
                        widget.getLoginUserDetails['image'].toString(),
                        // str_image,
                        //
                        height: 150.0,
                        width: 100.0,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 140,
                    width: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      child: Image.file(
                        fit: BoxFit.cover,
                        //
                        imageFile!,
                        // str_image,
                        //
                        height: 150.0,
                        width: 100.0,
                      ),
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
                  strImageSetType = '0';
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
                  strImageSetType = '0';
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

  func_check_with_image_or_without() {
    setState(() {
      str_save_and_continue_loader = '1';
    });
    if (str_image_status == '0') {
      func_update_profile_without_image();
    } else {
      if (kDebugMode) {
        print('with image');
      }
      upload_info_profile_picture();
    }
  }

  func_update_profile_without_image() async {
    print('=====> POST : EDIT PROFILE');

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
          'action': 'editprofile',
          'userId': prefs.getInt('userId').toString(),
          'fullName': cont_full_name.text.toString(),
          'contactNumber': cont_mobile_number.text.toString(),
          'address': cont_address.text.toString(),
          'career': cont_career.text.toString(),
          'favroite_quote': cont_skills.text.toString(),
          'deviceToken': '',
          'device': 'iOS',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        // save login data locally
        // Map<String, dynamic> get_data = jsonDecode(get_data);
        Map<String, dynamic> user = get_data['data'];
        await prefs.setInt('userId', user['userId']);
        await prefs.setString('fullName', user['fullName']);
        await prefs.setString('email', user['email']);
        await prefs.setString('username', user['username']);
        await prefs.setString('contactNumber', user['contactNumber']);

        await prefs.setString('role', user['role']);
        await prefs.setString('businessName', user['businessName']);
        await prefs.setString('businessEmail', user['businessEmail']);
        await prefs.setString('businessWebSite', user['businessWebSite']);
        await prefs.setString('businessAddress', user['businessAddress']);
        await prefs.setString('businessFax', user['businessFax']);
        await prefs.setString('businessPhone', user['businessPhone']);
        await prefs.setString('career', user['career']);
        await prefs.setString('favroite_quote', user['favroite_quote']);
        await prefs.setString('image', user['image']);

        setState(() {
          str_save_and_continue_loader = '0';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              closeIconColor: Colors.amber,
              content: Text(
                get_data['msg'].toString(),
              ),
            ),
          );
        });
        Navigator.pop(context, 'get_back_from_edit_profile');
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

  //
  upload_info_profile_picture() async {
    setState(() {});

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request =
        await http.MultipartRequest('POST', Uri.parse(application_base_url));

    request.fields['action'] = 'editprofile';
    request.fields['userId'] = prefs.getInt('userId').toString();

    request.fields['fullName'] = cont_full_name.text.toString();
    request.fields['contactNumber'] = cont_mobile_number.text.toString();
    request.fields['address'] = cont_address.text.toString();
    request.fields['career'] = cont_career.text.toString();
    request.fields['favroite_quote'] = cont_skills.text.toString();
    request.fields['deviceToken'] = '';
    request.fields['device'] = 'iOS';

    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile!.path));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responsedData = json.decode(responsed.body);
    if (kDebugMode) {
      print(responsedData);
    }

    if (responsedData['status'].toString() == 'success') {
      Map<String, dynamic> user = responsedData['data'];
      await prefs.setInt('userId', user['userId']);
      await prefs.setString('fullName', user['fullName']);
      await prefs.setString('email', user['email']);
      await prefs.setString('username', user['username']);
      await prefs.setString('contactNumber', user['contactNumber']);

      await prefs.setString('role', user['role']);
      await prefs.setString('businessName', user['businessName']);
      await prefs.setString('businessEmail', user['businessEmail']);
      await prefs.setString('businessWebSite', user['businessWebSite']);
      await prefs.setString('businessAddress', user['businessAddress']);
      await prefs.setString('businessFax', user['businessFax']);
      await prefs.setString('businessPhone', user['businessPhone']);
      await prefs.setString('career', user['career']);
      await prefs.setString('favroite_quote', user['favroite_quote']);
      await prefs.setString('image', user['image']);

      imageFile = null;
      str_image_status = '0';

      setState(() {
        str_save_and_continue_loader = '0';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            closeIconColor: Colors.amber,
            content: Text(
              responsedData['msg'].toString(),
            ),
          ),
        );
        Navigator.pop(context, 'get_back_from_edit_profile');
      });
    }

    //
  }
}
