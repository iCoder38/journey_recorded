// ignore_for_file: non_constant_identifier_names

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
  // List<Map<String, dynamic>> arr_save_ids = [];
  //
  var str_users_loader = '0';
  //
  var str_send_user_id;
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
          'action': 'userlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        for (int i = 0; i < get_data['data'].length; i++) {
          var custom_dict = {
            'userId': get_data['data'][i]['userId'].toString(),
            'fullName': get_data['data'][i]['fullName'].toString(),
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
        title: Text(
          'Users',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
        backgroundColor: navigation_color,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(
            context,
            // 'back_from_create_task',
            str_send_user_id.toString(),
          ),
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
                              child: Text(
                                //
                                arr_user_list[i]['fullName'].toString(),
                                //
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 18.0,
                                ),
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

      print(arr_save_ids);
      var stringList = arr_save_ids.join(',');
      print(stringList);
      print(stringList.runtimeType);
      str_send_user_id = stringList.toString();
      //
      str_users_loader = '1';
      setState(() {});
    }
  }
}
