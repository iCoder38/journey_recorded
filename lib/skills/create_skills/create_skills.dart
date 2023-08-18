// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
import 'package:journey_recorded/Utils.dart';

import 'package:http/http.dart' as http;
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateSkills extends StatefulWidget {
  const CreateSkills(
      {super.key, required this.str_from_profile, required this.dict_data});

  final String str_from_profile;
  final dict_data;

  @override
  State<CreateSkills> createState() => _CreateSkillsState();
}

class _CreateSkillsState extends State<CreateSkills>
    with SingleTickerProviderStateMixin {
  //
  var str_skill_id = '';
  var str_image_select = '0';
  var str_save_and_continue_loader = '0';
  var str_category_loader = '0';
  var arr_get_category_list = [];
  var str_category_id = 'n.a.';
  //

  //
  File? imageFile;
  //
  late final TextEditingController cont_skill_name;
  late final TextEditingController cont_skill_category;
  late final TextEditingController cont_skill_select_class;
  late final TextEditingController cont_skill_select_rank;
  late final TextEditingController cont_skill_stats_skill;
  late final TextEditingController cont_skill_how_to_learn;
  late final TextEditingController cont_skill_description;
  //
  @override
  void initState() {
    super.initState();
    //
    if (kDebugMode) {
      print(widget.dict_data);
    }

    if (widget.str_from_profile == 'yes') {
      cont_skill_name = TextEditingController(
        text: widget.dict_data['SkillName'].toString(),
      );
      cont_skill_category = TextEditingController(
        text: widget.dict_data['categoryName'].toString(),
      );
      cont_skill_select_class = TextEditingController(
        text: widget.dict_data['SkillClass'].toString(),
      );
      cont_skill_select_rank = TextEditingController(
        text: widget.dict_data['SkillRank'].toString(),
      );
      cont_skill_stats_skill = TextEditingController(
        text: widget.dict_data['StatsSkill'].toString(),
      );
      cont_skill_how_to_learn = TextEditingController(
        text: widget.dict_data['HourToLearn'].toString(),
      );
      cont_skill_description = TextEditingController(
        text: widget.dict_data['description'].toString(),
      );
      //
      str_category_id = widget.dict_data['categoryId'].toString();
      str_skill_id = widget.dict_data['skillId'].toString();
      //

      // setState(() {
      imageFile = File(widget.dict_data['image']);
      if (kDebugMode) {
        print(imageFile!.runtimeType);
        print(imageFile!.path);
      }
      // });

      //
    } else {
      //
      cont_skill_name = TextEditingController();
      cont_skill_category = TextEditingController();
      cont_skill_select_class = TextEditingController();
      cont_skill_select_rank = TextEditingController();
      cont_skill_stats_skill = TextEditingController();
      cont_skill_how_to_learn = TextEditingController();
      cont_skill_description = TextEditingController();
      //
    }

    //
    get_category_list_WB();
  }

  @override
  void dispose() {
    //
    cont_skill_name.dispose();
    cont_skill_category.dispose();
    cont_skill_select_class.dispose();
    cont_skill_select_rank.dispose();
    cont_skill_stats_skill.dispose();
    cont_skill_how_to_learn.dispose();
    cont_skill_description.dispose();
    //
    super.dispose();
  }

  //
  get_category_list_WB() async {
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
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_get_category_list = get_data['data'];

        setState(() {
          str_category_loader = '1';
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
        title: Text(
          //
          'Create Skills',
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
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
        child: (str_category_loader == '0')
            ? const CustomeLoaderPopUp(
                str_custom_loader: 'please wait...',
                str_status: '4',
              )
            : Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_skill_name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: cont_skill_category,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Category',
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                        ),
                      ),
                      onTap: () {
                        if (kDebugMode) {
                          print('click category');
                        }
                        category_list_POPUP('str_message');
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: cont_skill_select_class,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Select Class',
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                        ),
                      ),
                      onTap: () {
                        select_class_action_sheet(context);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: cont_skill_select_rank,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Select Rank',
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                        ),
                      ),
                      onTap: () {
                        select_rank_action_sheet(context);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_skill_stats_skill,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Stats Skill',
                      ),
                    ),
                  ),
                  /*Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      readOnly: false,
                      controller: cont_skill_how_to_learn,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Hour to learn',
                        suffixIcon: Icon(
                          Icons.schedule,
                        ),
                      ),
                      /*onTap: () async {
                        print('time');
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );

                        if (pickedTime != null) {
                          // print(pickedTime.format(context)); //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime =
                              DateFormat('HH:mm').format(parsedTime);
                          print(formattedTime); //output 14:59:00

                          //
                          cont_skill_how_to_learn.text =
                              formattedTime.toString();
                          //
                        } else {
                          print("Time is not selected");
                        }
                      },*/
                    ),
                  ),*/
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_skill_description,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      maxLines: 5,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('open camera gallery action sheet');
                      camera_gallery_for_profile(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(
                          2.0,
                        ),
                      ),
                      /*
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          left: 20.0,
                        ),
                        height: 200 - 40,
                        width: 200 - 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            fit: BoxFit.cover,
                            //
                            imageFile_for_profile!,
                            //
                            height: 150.0,
                            width: 100.0,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                      ),
                       */
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          imageFile == null
                              ? Container(
                                  height: 80,
                                  width: 80,
                                  color: Colors.pink,
                                )
                              : Container(
                                  height: 80,
                                  width: 80,
                                  color: Colors.brown,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
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
                          Text(
                            'Upload image',
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      add_skill_WB();
                    },
                    child: (str_save_and_continue_loader == '1')
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
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
                    height: 60,
                  ),
                ],
              ),
      ),
    );
  }

  // open action sheet for camera and gallery
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
                  str_image_select = '1';
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
                str_image_select = '1';

                setState(() {
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

  // open action sheet for camera and gallery
  void select_class_action_sheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select class'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              cont_skill_select_class.text = 'SS';
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
              cont_skill_select_class.text = 'S';
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
              cont_skill_select_class.text = 'A';
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
              cont_skill_select_class.text = 'B';
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
              cont_skill_select_class.text = 'C';
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

  // open action sheet for camera and gallery
  void select_rank_action_sheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Select Rank',
        ),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              cont_skill_select_rank.text = 'NOVOICE';
              //
            },
            child: Text(
              'NOVICE',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              cont_skill_select_rank.text = 'AVERAGE';
            },
            child: Text(
              'AVERAGE',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              cont_skill_select_rank.text = 'GOOD';
            },
            child: Text(
              'GOOD',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              cont_skill_select_rank.text = 'EXPERT';
            },
            child: Text(
              'EXPERT',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              cont_skill_select_rank.text = 'MASTER';
            },
            child: Text(
              'MASTER',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              cont_skill_select_rank.text = 'GENIUS';
            },
            child: Text(
              'GENIUS',
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
                          cont_skill_category.text =
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
  Future<void> upload_profile_alert(
    String str_message,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            //
            'Alert !',
            //
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 16.0,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              str_message.toString(),
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
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

  // add skill
  add_skill_WB() async {
    if (kDebugMode) {
      print('=====> POST : CREATE SKILL');
    }

    if (str_image_select == '0') {
      upload_profile_alert('Please select an Image');
    } else {
      str_save_and_continue_loader = '1';
      setState(() {});
      upload_info_profile_picture();
    }

    /*SharedPreferences prefs = await SharedPreferences.getInstance();
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
          'action': 'skilladd',
          'userId': prefs.getInt('userId').toString(),
          'SkillName': cont_skill_name.text.toString(),
          'categoryId': str_category_id.toString(),
          'SkillClass': cont_skill_select_class.text.toString(),
          'SkillRank': cont_skill_select_rank.text.toString(),
          'HourToLearn': cont_skill_how_to_learn.text.toString(),
          'description': cont_skill_description.text.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        Navigator.pop(context, '');
        // ..pop();
      } else {
        str_save_and_continue_loader = '0';
        setState(() {});
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      str_save_and_continue_loader = '0';
      setState(() {});
      // return postList;
      print('something went wrong');
    }*/
  }

  upload_info_profile_picture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request =
        http.MultipartRequest('POST', Uri.parse(application_base_url));

    request.fields['action'] = 'skilladd';
    request.fields['userId'] = prefs.getInt('userId').toString();

    //
    if (widget.str_from_profile == 'yes') {
      request.fields['skillId'] = str_skill_id.toString();
    }

    request.fields['SkillName'] = cont_skill_name.text.toString();
    request.fields['categoryId'] = str_category_id.toString();
    request.fields['SkillClass'] = cont_skill_select_class.text.toString();
    request.fields['SkillRank'] = cont_skill_select_rank.text.toString();
    request.fields['StatsSkill'] = cont_skill_stats_skill.text.toString();
    request.fields['description'] = cont_skill_description.text.toString();

    if (kDebugMode) {
      print('check');
    }
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile!.path));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responsedData = json.decode(responsed.body);
    if (kDebugMode) {
      print(responsedData);
    }

    if (responsedData['status'].toString().toLowerCase() == 'success') {
      imageFile = null;

      if (kDebugMode) {
        print('success');
      }
      Navigator.pop(context, '');
    } else {
      setState(() {
        str_save_and_continue_loader = '0';
      });
    }

    //
  }
}
