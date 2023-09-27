// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/dashboard/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberFullRegistrationScree extends StatefulWidget {
  const MemberFullRegistrationScree({super.key});

  @override
  State<MemberFullRegistrationScree> createState() =>
      _MemberFullRegistrationScreeState();
}

class _MemberFullRegistrationScreeState
    extends State<MemberFullRegistrationScree> {
  //
  GlobalKey<FormState> formKey = GlobalKey();
  //
  var strSubmitLoader = '0';
  TextEditingController contFullName = TextEditingController();
  TextEditingController contMobile = TextEditingController();
  TextEditingController contSkills = TextEditingController();
  TextEditingController contCareer = TextEditingController();
  TextEditingController contAddress = TextEditingController();
  //
  var str_image_status = '0';
  File? imageFile;
  var strImageSetType = '0';
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        title: text_bold_style_custom(
          'Complete Profile',
          Colors.white,
          16.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            //
          },
          icon: Icon(
            Icons.chevron_left,
            color: navigation_color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  camera_gallery_for_profile(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(0.0),
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(
                          54,
                          30,
                          107,
                          1,
                        ),
                        Color.fromRGBO(
                          92,
                          21,
                          93,
                          1,
                        ),
                        Color.fromRGBO(
                          138,
                          0,
                          70,
                          1,
                        ),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
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
                ),
              ),
              //
              const SizedBox(
                height: 20.0,
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contFullName,
                  // keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Full name...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contMobile,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Mobile...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contSkills,
                  // keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Skills...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contCareer,
                  // keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Career...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contAddress,
                  // keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Address...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    //
                    if (formKey.currentState!.validate()) {
                      //
                      func_check_with_image_or_without();
                    }
                  },
                  child: Container(
                    height: 60,
                    // width: 100,

                    decoration: BoxDecoration(
                      color: Colors.red,
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
                      child: (strSubmitLoader == '1')
                          ? const CircularProgressIndicator()
                          : text_bold_style_custom(
                              'Submit',
                              Colors.white,
                              14.0,
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

  func_check_with_image_or_without() {
    setState(() {
      strSubmitLoader = '1';
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
          'fullName': contFullName.text.toString(),
          'contactNumber': contMobile.text.toString(),
          'favroite_quote': contSkills.text.toString(),
          'career': contCareer.text.toString(),
          'address': contAddress.text.toString(),
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
          strSubmitLoader = '0';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              closeIconColor: Colors.amber,
              content: Text(
                get_data['msg'].toString(),
              ),
            ),
          );
        });
        funcPushToDashboard();
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

    request.fields['fullName'] = contFullName.text.toString();
    request.fields['contactNumber'] = contMobile.text.toString();
    request.fields['favroite_quote'] = contSkills.text.toString();
    request.fields['career'] = contCareer.text.toString();
    request.fields['address'] = contAddress.text.toString();

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
        strSubmitLoader = '0';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            closeIconColor: Colors.amber,
            content: Text(
              responsedData['msg'].toString(),
            ),
          ),
        );
      });
      funcPushToDashboard();
    }

    //
  }

  funcPushToDashboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
    );
  }
}

/*[action] => editprofile
    [userId] => 28
    [fullName] => qwerty
    [contactNumber] => 1234567890
    [favroite_quote] => 123456
    [career] => qwerty
    [address] => 12qwaszx namaste namaste namaste 
)
Array
(
    [image] => Array
        (
            [name] => 
            [type] => 
            [tmp_name] => 
            [error] => 4
            [size] => 0
        )
        */