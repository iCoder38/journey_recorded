// ignore_for_file: prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';
import 'package:journey_recorded/grind/edit_grind/edit_grind.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrindDetailsScreen extends StatefulWidget {
  const GrindDetailsScreen({super.key, this.dictShowFullData});

  final dictShowFullData;

  @override
  State<GrindDetailsScreen> createState() => _GrindDetailsScreenState();
}

class _GrindDetailsScreenState extends State<GrindDetailsScreen> {
  //
  var strLoader = '0';
  var customParse = [];
  //
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print(widget.dictShowFullData);
    }
    //
    customParse = [
      {
        'title': 'Grind name',
        'name': widget.dictShowFullData['grindName'].toString(),
      },
      {
        'title': 'Category name',
        'name': widget.dictShowFullData['categoryName'].toString(),
      },
      {
        'title': 'Priority',
        'name': widget.dictShowFullData['Priority'].toString(),
      },
      {
        'title': 'Descrption',
        'name': widget.dictShowFullData['Descrption'].toString(),
      },
      {
        'title': 'Skill Class',
        'name': widget.dictShowFullData['SkillClass'].toString(),
      },
      {
        'title': 'Skill name',
        'name': widget.dictShowFullData['skillName'].toString(),
      },
      {
        'title': 'Habit',
        'name': widget.dictShowFullData['habitName'].toString(),
      },
    ];
    //
  }
  //

/*
grindName: hh,
categoryName: SPIRITUAL, 
skillId: , 
skillName: , 
userId: 3, 
habitId: 10, 
habitName: and habit, 
totalPoint: , 
status: 1, 
Priority: gh, 
Descrption: hh, 
time_to_complete: , 
created: Mar 31st, 2023, 11:04 am
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          widget.dictShowFullData['grindName'].toString(),
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
        //automaticallyImplyLeading: true,
        backgroundColor: navigation_color,
        actions: [
          IconButton(
            onPressed: () {
              //
              deleteGrindPopUp(
                widget.dictShowFullData['grindName'].toString(),
                widget.dictShowFullData['grindId'].toString(),
              );
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          // as
          pushToCreateGrind(context);
        },
        backgroundColor: navigation_color,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              for (int i = 0; i < customParse.length; i++) ...[
                /*(customParse[i]['name'].toString() == '')
                    ? const SizedBox()
                    : */
                Container(
                  margin: const EdgeInsets.only(
                      // top: 10.0,
                      // left: 10,
                      // right: 10,
                      // bottom: 10,
                      ),
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  // height: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_with_bold_style_black(
                      //
                      customParse[i]['title'].toString(),
                      //
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.only(
                      // top: 0.0,
                      // left: 10,
                      // right: 10,
                      ),
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  // height: 48.0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: text_with_regular_style(
                      //
                      customParse[i]['name'].toString(),
                      //
                    ),
                  ),
                ),
                //
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width,
                  height: 0.2,
                ),
                //
              ],
            ],
          ),
        ),
      ),
    );
  }

  //
  Future<void> pushToCreateGrind(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditGrindScreen(
          getSelectedGrindData: widget.dictShowFullData,
        ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    if (!mounted) return;

    if (result == 'back_from_create_grind') {
      setState(() {
        // strGrindLoader = '0';
        // getGrindWB();
      });
    } else {
      //

      //
    }
  }

  //
  // ALERT
  Future<void> deleteGrindPopUp(strGrindName, strGrindId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: text_with_bold_style_black(
            'Delete',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: text_with_regular_style(
                    '${'Are you sure you want to delete "' + strGrindName}" ?',
                  ),
                ),
              ],
              //
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Dismiss',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes, delete',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //
                loaderAlert();
                deleteGrindWB(
                  strGrindId,
                );
              },
            ),
          ],
        );
      },
    );
  }

  // ALERT
  Future<void> loaderAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: text_with_bold_style_black(
          //   'Delete',
          // ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Center(
                    child: text_with_regular_style(
                      'deleting...',
                    ),
                  ),
                ),
              ],
              //
            ),
          ),
        );
      },
    );
  }

  // delete grind
  deleteGrindWB(getGrindId) async {
    if (kDebugMode) {
      print('=====> POST : DELETE GRINDS');
    }

    setState(() {
      strLoader = '1';
    });
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
          'action': 'girnddelete',
          'userId': prefs.getInt('userId').toString(),
          'grindId': getGrindId.toString(),
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
        Navigator.pop(context, 'successfully_deleted');
        Navigator.pop(context, 'successfully_deleted');
        //
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
      if (kDebugMode) {
        print('something went wrong');
      }
    }
  }
}
