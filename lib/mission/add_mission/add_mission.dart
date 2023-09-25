// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:intl/intl.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/mission/add_mission/add_mission_modal.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddMissionScreen extends StatefulWidget {
  const AddMissionScreen(
      {super.key,
      required this.str_category_id,
      required this.str_goal_id,
      required this.str_edit_status,
      required this.str_mission_text,
      required this.str_deadline,
      required this.str_mission_id,
      required this.str_navigation_title});

  final String str_navigation_title;
  final String str_mission_text;
  final String str_deadline;
  final String str_edit_status;
  final String str_category_id;
  final String str_goal_id;
  final String str_mission_id;

  @override
  State<AddMissionScreen> createState() => _AddMissionScreenState();
}

class _AddMissionScreenState extends State<AddMissionScreen> {
  //
  var loader = '0';
  var str_category_id = 'n.a.';
  var arr_get_category_list = [];
  //
  TextEditingController cont_add_category = TextEditingController();
  TextEditingController cont_add_name = TextEditingController();
  TextEditingController cont_add_mission_text = TextEditingController();
  //
  TextEditingController cont_deadline = TextEditingController();
  //
  AddMissionModal add_mission_service = AddMissionModal();
  //

  @override
  void initState() {
    super.initState();

    cont_add_mission_text.text = widget.str_mission_text.toString();
    cont_deadline.text = widget.str_deadline.toString();

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
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        title: text_bold_style_custom(
          (widget.str_edit_status == '1')
              ? 'Edit'
              : widget.str_navigation_title,
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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 20.0,
              ),
              // height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: TextFormField(
                controller: cont_add_category,
                readOnly: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'category...',
                  labelText: 'Category',
                ),
                maxLines: 1,
                onTap: () {
                  category_list_POPUP('str_message');
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 20.0,
              ),
              // height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: TextFormField(
                controller: cont_add_name,
                readOnly: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'name...',
                  labelText: 'Name',
                ),
                maxLines: 1,
                onTap: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 20.0,
              ),
              // height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: TextFormField(
                controller: cont_deadline,
                readOnly: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'deadline',
                  labelText: 'deadline',
                ),
                maxLines: 1,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                    String formattedDate = DateFormat('yyyy-MM-dd').format(
                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                    print(
                        formattedDate); //formatted date output using intl package =>  2022-07-04
                    //You can format date as per your need

                    setState(() {
                      cont_deadline.text =
                          formattedDate; //set foratted date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 20.0,
              ),
              // height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: TextFormField(
                controller: cont_add_mission_text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Text',
                  labelText: 'Text',
                ),
                maxLines: 5,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  loader = '1';
                });
                (widget.str_navigation_title == 'Add Quest')
                    ? (widget.str_edit_status == '1')
                        ? edit_mission_WB()
                        : add_mission_service
                            .add_mission_WB(
                                cont_add_mission_text.text.toString(),
                                str_category_id.toString(),
                                widget.str_goal_id.toString(),
                                cont_deadline.text.toString(),
                                cont_add_name.text.toString(),
                                'addquest')
                            .then((value) {
                            print('do something');
                            Navigator.pop(context);
                          })
                    : (widget.str_edit_status == '1')
                        ? edit_mission_WB()
                        : add_mission_service
                            .add_mission_WB(
                                cont_add_mission_text.text.toString(),
                                str_category_id.toString(),
                                widget.str_goal_id.toString(),
                                cont_deadline.text.toString(),
                                cont_add_name.text.toString(),
                                'addmission')
                            .then((value) {
                            print('do something');
                            Navigator.pop(context, 'add_mission_successfully');
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
                child: (loader == '1')
                    ? const Center(
                        child: SizedBox(
                          height: 40.0,
                          width: 40.0,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Center(
                        child: (widget.str_edit_status == '1')
                            ? Text(
                                'Edit Mission',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Add',
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
    );
  }

//

  edit_mission_WB() async {
    print('=====> POST : EDIT MISSION');

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
          'action': (widget.str_navigation_title == 'Add Quest')
              ? 'addquest'
              : 'addmission',
          'userId': prefs.getInt('userId').toString(),
          'missionId': widget.str_mission_id.toString(),
          'goalId': widget.str_goal_id.toString(),
          'categoryId': widget.str_category_id.toString(),
          'description': cont_add_mission_text.text.toString(),
          'deadline': cont_deadline.text.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        Navigator.of(context)
          ..pop()
          ..pop('from_edit_mission');
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
                          cont_add_category.text =
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
}
