// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/add_notes_in_goal/add_note_in_goal_modal.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddNotesInGoalScreen extends StatefulWidget {
  const AddNotesInGoalScreen(
      {super.key,
      required this.str_profession_id,
      required this.str_profession_type});

  final String str_profession_id;
  final String str_profession_type;

  @override
  State<AddNotesInGoalScreen> createState() => _AddNotesInGoalScreenState();
}

class _AddNotesInGoalScreenState extends State<AddNotesInGoalScreen> {
  //
  var str_category_id = '';
  //
  var arr_get_category_list = [];
  //
  var str_add_note_loader = '0';
  //
  TextEditingController cont_add_note_text = TextEditingController();
  TextEditingController cont_category = TextEditingController();
  //
  AddNoteModal add_note_service = AddNoteModal();
  //

  @override
  void initState() {
    super.initState();
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
    // print('dushu');
    // print(get_data['data']);
    // print('dushu');
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_get_category_list = get_data['data'];

        // print('dushu');
        // print(arr_get_category_list);
        // print('dushu');
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
        title: Text(
          'Add Note',
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
          onPressed: () => Navigator.pop(
            context,
          ),
        ),
        backgroundColor: navigation_color,
      ),
      body: Column(
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
              readOnly: true,
              controller: cont_category,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'category...',
                labelText: 'Category',
              ),
              // maxLines: 5,
              onTap: () {
                category_list_POPUP();
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
              controller: cont_add_note_text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'write note...',
                labelText: 'Write Note',
              ),
              maxLines: 5,
            ),
          ),
          (str_add_note_loader == '0')
              ? InkWell(
                  onTap: () {
                    print('goal => add note click');
                    str_add_note_loader = '1';
                    setState(() {});
                    add_note_service
                        .add_note_WB(
                      cont_add_note_text.text,
                      widget.str_profession_id,
                      widget.str_profession_type,
                      str_category_id.toString(),
                    )
                        .then((value) {
                      print('do something');
                      // Navigator.pop(context);
                      Navigator.pop(
                          context, 'get_back_from_add_notes'.toString());
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
                    child: Center(
                      child: Text(
                        '+ Add Note',
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
              : Container(
                  margin: const EdgeInsets.all(
                    10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                    color: Colors.transparent,
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                      ],
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
                          cont_category.text =
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
