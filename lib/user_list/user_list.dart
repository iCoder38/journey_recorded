// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  //
  var arr_user_list = [];
  //
  var arr_save_ids = [];
  var arr_save_names = [];
  // List<Map<String, dynamic>> arr_save_ids = [];
  //
  var str_users_loader = '0';
  //
  var str_send_user_id;
  var str_send_user_names;
  //
  var saveIdAndName;
  //
  @override
  void initState() {
    super.initState();

    /*;*/

    get_user_list_WB();
  }

  get_user_list_WB() async {
    print('=====> POST : USER LIST');

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
          'action': 'friendlist',
          'userId': prefs.getInt('userId').toString(),
          'status': '2',
          'pageNo': '1',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        var setName = '';
        var setIds = '';
        //
        for (int i = 0; i < get_data['data'].length; i++) {
          if (get_data['data'][i]['userTo'].toString() ==
              prefs.getInt('userId').toString()) {
            //
            setName = get_data['data'][i]['From_userName'].toString();
            setIds = get_data['data'][i]['From_userId'].toString();
          } else {
            //
            setName = get_data['data'][i]['To_userName'].toString();
            setIds = get_data['data'][i]['To_userId'].toString();
          }
          var custom_dict = {
            'userId': setIds,
            'fullName': setName,
            'email': get_data['data'][i]['email'].toString(),
            'contactNumber': get_data['data'][i]['contactNumber'].toString(),
            'profile_picture':
                get_data['data'][i]['profile_picture'].toString(),
            'status': 'no',
          };

          arr_user_list.add(custom_dict);
        }

        str_users_loader = '1';

        // print(arr_user_list);
        setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          'Invite Users',
          Colors.white,
          16.0,
        ),
        backgroundColor: navigation_color,
        leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            onPressed: () =>
                funcBeforeBack() /*Navigator.pop(
            context,
            saveIdAndName.toString(),
          ),*/
            ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: (str_users_loader == '1')
            ? Column(
                children: <Widget>[
                  for (int i = 0; i < arr_user_list.length; i++) ...[
                    InkWell(
                      onTap: () {
                        // print(arr_user_list[i]['userId'].toString());
                        func_edit_user_list(
                          i,
                          arr_user_list[i]['status'].toString(),
                        );
                        // print(i);
                      },
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                left: 20.0,
                              ),
                              child: text_regular_style_custom(
                                //
                                arr_user_list[i]['fullName'].toString(),
                                Colors.black,
                                14.0,
                              ),
                            ),
                            (arr_user_list[i]['status'].toString() == 'no')
                                ? const Text('')
                                : Container(
                                    margin: const EdgeInsets.only(
                                      right: 20.0,
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(0),
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        print('object');
                                      },
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                    ),
                  ]
                ],
              )
            : const CustomeLoaderPopUp(
                str_custom_loader: 'please wait...',
                str_status: '0',
              ),
      ),
    );
  }

  func_edit_user_list(
    int indexx,
    String str_status,
  ) {
    print(str_status);
    str_users_loader = '0';
    setState(() {});

    if (str_status == 'yes') {
      var custom_dict = {
        'userId': arr_user_list[indexx]['userId'].toString(),
        'fullName': arr_user_list[indexx]['fullName'].toString(),
        'email': arr_user_list[indexx]['email'].toString(),
        'contactNumber': arr_user_list[indexx]['contactNumber'].toString(),
        'profile_picture': arr_user_list[indexx]['profile_picture'].toString(),
        'status': 'no',
      };

      arr_user_list.removeAt(indexx);

      arr_user_list.insert(indexx, custom_dict);

      str_users_loader = '1';
      setState(() {});
    } else {
      var custom_dict = {
        'userId': arr_user_list[indexx]['userId'].toString(),
        'fullName': arr_user_list[indexx]['fullName'].toString(),
        'email': arr_user_list[indexx]['email'].toString(),
        'contactNumber': arr_user_list[indexx]['contactNumber'].toString(),
        'profile_picture': arr_user_list[indexx]['profile_picture'].toString(),
        'status': 'yes',
      };

      arr_user_list.removeAt(indexx);

      arr_user_list.insert(indexx, custom_dict);
      //
      // var stringList = result.join(',');
      arr_save_ids.add(arr_user_list[indexx]['userId'].toString());
      arr_save_names.add(arr_user_list[indexx]['fullName'].toString());

      // print(arr_save_ids);
      // var stringList = arr_save_ids.join(',');
      // var stringListNames = arr_save_names.join(',');
      // // print(stringList);
      // // print(stringList.runtimeType);
      // str_send_user_id = stringList.toString();
      // str_send_user_names = stringListNames.toString();
      // //
      str_users_loader = '1';
      // //
      // // funcSaveValueInLoadlDB(str_send_user_id, str_send_user_names);
      // saveIdAndName = str_send_user_id + '#' + str_send_user_names;

      //
    }
    print(arr_user_list);
    //
    for (int i = 0; i < arr_user_list.length; i++) {
      if (arr_user_list[i]['status'].toString() == 'yes') {
        saveIdAndName = arr_user_list[i]['status'].toString();
      }
    }
    //
    var stringList = arr_save_ids.join(',');
    var stringListNames = arr_save_names.join(',');
    // print(stringList);
    // print(stringList.runtimeType);
    str_send_user_id = stringList.toString();
    str_send_user_names = stringListNames.toString();
    //
    str_users_loader = '1';
    //
    // funcSaveValueInLoadlDB(str_send_user_id, str_send_user_names);

    //
    setState(() {});
  }

  funcBeforeBack() async {
    print('clicked back');
    print(arr_user_list);
    //
    var arr = [];
    for (int i = 0; i < arr_user_list.length; i++) {
      if (arr_user_list[i]['status'].toString() == 'yes') {
        var custom = {
          'id': arr_user_list[i]['userId'].toString(),
          'name': arr_user_list[i]['fullName'].toString(),
        };

        arr.add(custom);
      }
    }
    //
    print(arr);
    //
    var arrids = [];
    var arrNames = [];
    for (int j = 0; j < arr.length; j++) {
      arrids.add(arr[j]['id']);
      arrNames.add(arr[j]['name']);
    }
    //
    print(arrids);
    print(arrNames);
    //
    var list = arrids;
    var stringList = list.join(',');
    print(stringList);
    //
    var listnames = arrNames;
    var stringListnames = listnames.join(',');
    print(stringListnames);
    //
    saveIdAndName = '$stringList # $stringListnames';
    print(saveIdAndName);
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('save_task_members_ids', stringList);
    await prefs.setString('save_task_members_names', stringListnames);
    //
    Navigator.pop(context, saveIdAndName);
  }
}
