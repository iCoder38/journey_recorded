// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:journey_recorded/friends/add_friend/add_friend_list.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  //
  var str_login_user_id = '';
  var str_friends_loader = '0';
  var arr_friends = [];
  //

  @override
  void initState() {
    super.initState();
    get_friends_list_WB();
  }

  // get routine list
  get_friends_list_WB() async {
    print('=====> POST : FRIENDS LIST');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    str_login_user_id = prefs.getInt('userId').toString();

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

        if (arr_friends.isEmpty) {
          str_friends_loader = '2';
          setState(() {});
        } else {
          str_friends_loader = '1';
          setState(() {});
        }
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
          'Friends',
          Colors.white,
          16.0,
        ),
        backgroundColor: navigation_color,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              push_to_add_friend(context);
            },
            icon: const Icon(
              Icons.group_add_outlined,
              color: Colors.white,
            ),
          )
        ],
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
            else if (str_friends_loader == '2')
              const CustomeLoaderPopUp(
                str_custom_loader: 'Friends not Added Yet.',
                str_status: '4',
              )
            else
              for (int i = 0; i < arr_friends.length; i++) ...[
                if (str_login_user_id == arr_friends[i]['userTo'].toString())
                  //
                  show_FROM_data(context, i)
                //
                else
                  //
                  show_TO_data(context, i),
                //
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

  Container show_TO_data(BuildContext context, int i) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            // width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: (arr_friends[i]['To_profile_picture'].toString() == '')
                  ? SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          30.0,
                        ),
                        child: Image.network(
                          arr_friends[i]['To_profile_picture'].toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              //
              arr_friends[i]['To_userName'].toString(),
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
          (arr_friends[i]['status'].toString() == '1')
              ? Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                  child: Align(
                      child: Text(
                    'pending',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  )),
                )
              : Container(
                  height: 40,
                  width: 80,
                  color: Colors.greenAccent,
                  child: Align(
                      child: Text(
                    'Friends',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  )),
                ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Container show_FROM_data(BuildContext context, int i) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: (arr_friends[i]['From_profile_picture'].toString() == '')
                ? SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                      child: Image.network(
                        arr_friends[i]['From_profile_picture'].toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              //
              arr_friends[i]['From_userName'].toString(),
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
          if (arr_friends[i]['status'].toString() == '1')
            InkWell(
              onTap: () {
                add_friend_popup(
                  context,
                  arr_friends[i]['friendId'].toString(),
                );
              },
              child: Container(
                height: 40,
                // width: 120,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    child: Text(
                      'New Request',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            InkWell(
              onTap: () {
                DECLINE_friend_popup(
                  context,
                  arr_friends[i]['friendId'].toString(),
                );
              },
              child: Container(
                height: 40,
                // width: 80,

                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      child: Text(
                    'Friends',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Future<void> push_to_add_friend(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddFriendListScreen(),
      ),
    );

    print('Result =====>$result');

    if (!mounted) return;
    str_friends_loader = '0';
    setState(() {});
    get_friends_list_WB();
  }

  //
  // open action sheet
  void add_friend_popup(
    BuildContext context,
    String str_friend_id_is,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Friend Request',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 16.0,
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          //

          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);
              accept_friend_RequesT_WB(str_friend_id_is);
            },
            child: Text(
              //
              'Accept',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);
              // DECLINE_friend_popup(context, str_friend_id_is);
              DECLINE_friend_RequesT_WB(str_friend_id_is);
            },
            child: Text(
              //
              'Decline',
              //
              style: TextStyle(
                fontFamily: font_style_name, fontSize: 16.0, color: Colors.red,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //

          /*CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
                // color: Colors.orange,
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  //
  // accept decline friend request
  accept_friend_RequesT_WB(
    String str_friend_id,
  ) async {
    print('=====> POST : FRIENDS LIST');

    str_friends_loader = '0';
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    str_login_user_id = prefs.getInt('userId').toString();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'acceptfriendrequest',
          'userId': prefs.getInt('userId').toString(),
          'friendId': str_friend_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        get_friends_list_WB();
        //
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  // UNFRIEND
  // open action sheet
  void DECLINE_friend_popup(
    BuildContext context,
    String str_friend_id_is,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Friend Request',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 16.0,
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          //

          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);
              DECLINE_friend_RequesT_WB(str_friend_id_is);
            },
            child: Text(
              //
              'Unfriend',
              //
              style: TextStyle(
                fontFamily: font_style_name, fontSize: 16.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //

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
                // color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
  // accept decline friend request
  DECLINE_friend_RequesT_WB(
    String str_friend_id,
  ) async {
    print('=====> POST : FRIENDS LIST');

    str_friends_loader = '0';
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    str_login_user_id = prefs.getInt('userId').toString();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'declinefriendrequest',
          'userId': prefs.getInt('userId').toString(),
          'friendId': str_friend_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        get_friends_list_WB();
        //
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
