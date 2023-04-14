// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFriendListScreen extends StatefulWidget {
  const AddFriendListScreen({super.key});

  @override
  State<AddFriendListScreen> createState() => _AddFriendListScreenState();
}

class _AddFriendListScreenState extends State<AddFriendListScreen> {
  //
  var str_friends_loader = '0';
  var arr_friends = [];
  //

  @override
  void initState() {
    super.initState();
    get_invite_user_list();
  }

  // get routine list
  get_invite_user_list() async {
    print('=====> POST : FRIENDS LIST');

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
          'action': 'userlist',
          'userId': prefs.getInt('userId').toString(),
          'for_friend': 'Yes',
          'keyword': '',
          'pageNo': '',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_friends = get_data['data'];
        // main_loader = '1';
        str_friends_loader = '1';
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
          //
          'Invite User',
          //
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
            onPressed: () => Navigator.pop(context, '')),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            if (str_friends_loader == '0')
              const CustomeLoaderPopUp(
                str_custom_loader: 'please wait...',
                str_status: '4',
              )
            else
              for (int i = 0; i < arr_friends.length; i++) ...[
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child:
                              (arr_friends[i]['profile_picture'].toString() ==
                                      '')
                                  ? Image.asset('assets/images/logo.png')
                                  : FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/loader.gif',
                                      image: arr_friends[i]['profile_picture']
                                          .toString(),
                                    ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          //
                          '${arr_friends[i]['fullName'].toString()}\n${arr_friends[i]['email'].toString()}',
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(
                              20.0,
                            )),
                        child: IconButton(
                          onPressed: () {
                            //
                            send_friend_request_WB(
                              arr_friends[i]['userId'].toString(),
                            );
                            //
                          },
                          icon: const Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
              ]
          ],
        ),
      ),
    );
  }

  //
  // get routine list
  send_friend_request_WB(String str_friend_id) async {
    print('=====> POST : FRIENDS LIST');

    str_friends_loader = '0';
    setState(() {});
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
          'action': 'sendfriendrequest',
          'userFrom': prefs.getInt('userId').toString(),
          'userTo': str_friend_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        // arr_friends = get_data['data'];
        // main_loader = '1';
        // str_friends_loader = '1';
        // setState(() {});
        get_invite_user_list();
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }
}
