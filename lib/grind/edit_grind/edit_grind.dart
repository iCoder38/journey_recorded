// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditGrindScreen extends StatefulWidget {
  const EditGrindScreen({super.key, this.getSelectedGrindData});

  final getSelectedGrindData;

  @override
  State<EditGrindScreen> createState() => _EditGrindScreenState();
}

class _EditGrindScreenState extends State<EditGrindScreen> {
  //
  var strCreateGrindLoader = '0';
  var arr_get_category_list = [];
  var str_category_id = '0';
  var strScreenLoader = '0';
  //
  final formKey = GlobalKey<FormState>();
  late final TextEditingController contGrindName;
  late final TextEditingController contGrindCategory;
  late final TextEditingController contGrindTime;
  late final TextEditingController contGrindPriority;
  late final TextEditingController contSelectClass;
  late final TextEditingController contGrindDescription;
  //
  @override
  void initState() {
    contGrindName = TextEditingController(
      text: widget.getSelectedGrindData['grindName'].toString(),
    );
    contGrindCategory = TextEditingController(
      text: widget.getSelectedGrindData['categoryName'].toString(),
    );
    contGrindTime = TextEditingController(
      text: widget.getSelectedGrindData['no_of_time_to_complete'].toString(),
    );
    contGrindPriority = TextEditingController(
      text: widget.getSelectedGrindData['Priority'].toString(),
    );
    contGrindDescription = TextEditingController(
      text: widget.getSelectedGrindData['Descrption'].toString(),
    );
    contSelectClass = TextEditingController(
      text: widget.getSelectedGrindData['SkillClass'].toString(),
    );

    super.initState();

    if (kDebugMode) {
      print(widget.getSelectedGrindData);
    }
    //
    str_category_id = widget.getSelectedGrindData['categoryId'].toString();
    //
    getCategoryList();
  }

  @override
  void dispose() {
    contGrindName.dispose();
    contGrindCategory.dispose();
    contGrindTime.dispose();
    contGrindPriority.dispose();
    contGrindDescription.dispose();
    contSelectClass.dispose();

    super.dispose();
  }

// get category list
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
          // 'userId': prefs.getInt('userId').toString(),
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
          strScreenLoader = '1';
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
      appBar: AppBar(
        title: text_bold_style_custom(
          widget.getSelectedGrindData['grindName'],
          Colors.white,
          16.0,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        //automaticallyImplyLeading: true,
        backgroundColor: navigation_color,
      ),

      body: Form(
        key: formKey,
        child: (strScreenLoader == '0')
            ? Align(
                child: CircularProgressIndicator(
                  color: navigation_color,
                ),
              )
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
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
                        controller: contGrindName,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name',
                        ),

                        // validation
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter grind name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  //
                  Container(
                    margin: const EdgeInsets.all(10),
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
                        controller: contGrindCategory,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                          ),
                          border: InputBorder.none,
                          hintText: 'Category',
                        ),
                        onTap: () {
                          category_list_POPUP('str_message');
                        },
                        // validation
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select category';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  //
                  Container(
                    margin: const EdgeInsets.all(10),
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
                        controller: contGrindTime,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Time to complete the activity',
                        ),
                        // validation
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some data';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  //
                  Container(
                    margin: const EdgeInsets.all(10),
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
                        controller: contGrindPriority,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Priority',
                        ),
                        // validation
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter priority';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  //
                  Container(
                    margin: const EdgeInsets.all(10),
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
                        controller: contSelectClass,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Select class',
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                          ),
                        ),
                        // validation
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter select class';
                          }
                          return null;
                        },
                        onTap: () {
                          //
                          openSelectClassSheet(context);
                        },
                      ),
                    ),
                  ),
                  //
                  Container(
                    margin: const EdgeInsets.all(10),
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
                        controller: contGrindDescription,
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
                  //
                  //
                  (strCreateGrindLoader == '1')
                      ? const CircularProgressIndicator()
                      : InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              //
                              funcEditGrind();
                              //
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
                ],
              ),
      ),
      //
    );
  }

//
  void openSelectClassSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select class'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              contSelectClass.text = 'SS';
              //
            },
            child: Text(
              'SS : THESE ARE HARDEST SKILLS AND MAY TAKE THE LOGEST TIME TO LEARN. THESE SKILL MIGHT NEED TO GAIN SOME SKILLS BEFORE LEARNING THIS SKILL.',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              contSelectClass.text = 'S';
            },
            child: Text(
              'S : THESE ARE RARE AND HARDER TO LEARN.',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              contSelectClass.text = 'A';
            },
            child: Text(
              'A : THESE ARE HARD SKILLS TO LEARN.',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              contSelectClass.text = 'B';
            },
            child: Text(
              'B : THERE ARE NOT TO HARD TO LEARN.',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              contSelectClass.text = 'C';
            },
            child: Text(
              'C : THESE ARE EASY SKILLS TO LEARN.',
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
  // ALERT
  Future<void> category_list_POPUP(
    String strMessage,
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
                          contGrindCategory.text =
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

  //
  // create grind
  funcEditGrind() async {
    setState(() {
      strCreateGrindLoader = '1';
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
          'action': 'grandadd',
          'userId': prefs.getInt('userId').toString(),
          'grindId': widget.getSelectedGrindData['grindId'].toString(),
          'Priority': contGrindPriority.text.toString(),
          'grindName': contGrindName.text.toString(),
          'categoryId': str_category_id.toString(),
          'Descrption': contGrindDescription.text.toString(),
          'time_to_complete': contGrindTime.text.toString(),
          'SkillClass': contSelectClass.text.toString(),
          // 'skillId': strSaveRelatedSkillId.toString(),
          // 'habitId': strSaveRelatedHabitId.toString(),
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
        //

        setState(() {
          strCreateGrindLoader = '0';
          // Navigator.pop(context, 'back_from_create_grind');
          Navigator.of(context)
            ..pop()
            ..pop('back_from_create_grind');
        });
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
}
