// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/add_notes_in_goal/add_notes_in_goal.dart';
import 'package:journey_recorded/goals/edit_notes_in_goal/edit_notes_in_goal.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  //
  var str_category_id = '';
  var str_main_loader = '0';
  var str_get_message;
  var str_note_id;
  var str_profession_id;
  var str_professional_type;
  var str_user_id;
  var arr_notes_list = [];
  var arr_get_category_list = [];
  //
  @override
  void initState() {
    super.initState();
    func_notes_WB();
  }

  // NOTES
  Future func_notes_WB() async {
    print('=====> POST : NOTES 1');

    setState(() {
      str_main_loader = 'notes_loader_start';
    });
    //
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
          'action': 'notelist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arr_notes_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          arr_notes_list.add(i);
        }

        get_category_list_WB();
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

//
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
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_get_category_list = get_data['data'];

        if (arr_notes_list.isEmpty) {
          setState(() {
            str_main_loader = 'notes_data_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'notes_loader_stop';
          });
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
      appBar: app_bar_notes_UI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push_to_create_notes(context);
        },
        backgroundColor: navigation_color,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Expanded(
            //   flex: 1,
            //   child: top_three_buttons_UI(),
            // ),
            top_three_buttons_UI(),
            //
            if (str_main_loader == 'notes_loader_start')
              const CustomeLoaderPopUp(
                str_custom_loader: 'please wait...',
                str_status: '3',
              )
            else if (str_main_loader == 'notes_data_empty')
              const CustomeLoaderPopUp(
                str_custom_loader: 'Note not Added Yet',
                str_status: '4',
              )
            else
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //scrollDirection: Axis.vertical,
                //shrinkWrap: true,
                itemCount: arr_notes_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 0.0,
                      ),
                      // height: 100,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: ListTile(
                        // leading: const FlutterLogo(size: 72.0),
                        title: Text(
                          //
                          arr_notes_list[index]['created'].toString(),
                          // _tabController.index.toString(),
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Container(
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            //
                            arr_notes_list[index]['message'].toString(),
                            // '2',
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        /*trailing: Icon(
                              Icons.more_vert,
                            ),*/
                        isThreeLine: true,
                        trailing: Column(
                          children: <Widget>[
                            Expanded(
                              child: IconButton(
                                onPressed: (() {
                                  // print(index);
                                  str_get_message = arr_notes_list[index]
                                          ['message']
                                      .toString();
                                  str_note_id = arr_notes_list[index]['noteId']
                                      .toString();
                                  str_profession_id = arr_notes_list[index]
                                          ['profesionalId']
                                      .toString();
                                  str_professional_type = arr_notes_list[index]
                                          ['profesionalType']
                                      .toString();

                                  gear_popup(
                                    'Manage Notes',
                                    arr_notes_list[index]['noteId'].toString(),
                                  );
                                }),
                                icon: const Icon(
                                  Icons.settings,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            // Expanded(
            //   flex: 10,
            //   child: list_view_in_notes_UI(),
            // ),
            /*Expanded(
              flex: 2,
              child: Container(
                // height: 300,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 10.0,
                          bottom: 20.0,
                          top: 10.0,
                        ),
                        // height: 40,
                        color: Colors.transparent,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            // hintText: 'Tell us about yourself',
                            // helperText: 'Keep it short, this is just a demo.',
                            labelText: 'Save any notes2',
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        // height: 40,
                        color: Colors.transparent,
                        child: const Icon(
                          Icons.save,
                        ),
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
            ),*/
            /*Container(
              //height: 80,
              width: MediaQuery.of(context).size.width,
              color: navigation_color,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //
                  
                  //
                  
                  //
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  SingleChildScrollView list_view_in_notes_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        //scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(
                top: 10.0,
                bottom: 0.0,
              ),
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Card(
                child: ListTile(
                  leading: const FlutterLogo(size: 72.0),
                  title: Text(
                    'Three-line ListTile',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  /*trailing: Icon(
                          Icons.more_vert,
                        ),*/
                  isThreeLine: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container top_three_buttons_UI() {
    return Container(
      color: Colors.blue[900],
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: InkWell(
                onTap: () {
                  open_category_list(context);
                },
                child: Container(
                  height: 60,
                  // width: MediaQuery.of(context).size.width,

                  decoration: const BoxDecoration(
                    // color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        60.0,
                      ),
                      bottomLeft: Radius.circular(
                        10.0,
                      ),
                      bottomRight: Radius.circular(
                        60.0,
                      ),
                      topRight: Radius.circular(
                        10.0,
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(250, 220, 10, 1),
                        Color.fromRGBO(252, 215, 10, 1),
                        Color.fromRGBO(251, 195, 11, 1),
                        Color.fromRGBO(250, 180, 10, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Categories'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          /*Expanded(
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: Container(
                height: 60,
                // width: MediaQuery.of(context).size.width,

                decoration: const BoxDecoration(
                  // color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      60.0,
                    ),
                    bottomLeft: Radius.circular(
                      10.0,
                    ),
                    bottomRight: Radius.circular(
                      60.0,
                    ),
                    topRight: Radius.circular(
                      10.0,
                    ),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(250, 220, 10, 1),
                      Color.fromRGBO(252, 215, 10, 1),
                      Color.fromRGBO(251, 195, 11, 1),
                      Color.fromRGBO(250, 180, 10, 1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Action'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),*/
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: InkWell(
                onTap: () {
                  //
                  open_filter_action_sheet(context);
                  //
                },
                child: Container(
                  height: 60,
                  // width: MediaQuery.of(context).size.width,

                  decoration: const BoxDecoration(
                    // color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        60.0,
                      ),
                      bottomLeft: Radius.circular(
                        10.0,
                      ),
                      bottomRight: Radius.circular(
                        60.0,
                      ),
                      topRight: Radius.circular(
                        10.0,
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(250, 220, 10, 1),
                        Color.fromRGBO(252, 215, 10, 1),
                        Color.fromRGBO(251, 195, 11, 1),
                        Color.fromRGBO(250, 180, 10, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Filters'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar app_bar_notes_UI() {
    return AppBar(
      backgroundColor: navigation_color,
      title: Text(
        ///
        navigation_title_notes,

        ///
        style: TextStyle(
          fontFamily: font_style_name,
          fontSize: 18.0,
        ),
      ),
      /*actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 16.0,
          ),
          child: Icon(
            Icons.mic,
            color: app_yellow_color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 20.0,
          ),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: app_yellow_color,
            child: const Icon(
              Icons.question_mark,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 20.0,
          ),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: app_yellow_color,
            child: const Icon(
              Icons.question_mark,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 20.0,
          ),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: app_yellow_color,
            child: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
        ),
      ],*/
    );
  }

  //
  // ALERT
  Future<void> gear_popup(
    String str_title,
    String note_id_is,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            str_title.toString(),
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print('edit 2');
                    Navigator.pop(context);

                    _navigateAndDisplaySelection(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.edit,
                            size: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Edit Note',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print(' delete note');

                    Navigator.pop(context);

                    delete_notes_WB(
                      note_id_is,
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.delete_forever,
                            size: 16.0,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: ' Delete Note',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
              ],
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

  delete_notes_WB(
    String note_id,
  ) async {
    print('=====> POST : DELETE NOTES');

    // str_notes_loader_status = '0';
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
          'action': 'notedelete',
          'userId': prefs.getInt('userId').toString(),
          'noteId': note_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_notes_list = [];
        //
        func_notes_WB();
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

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotesInGoalScreen(
          str_message: str_get_message,
          str_note_id: str_note_id.toString(),
          str_professional_id: str_profession_id.toString(),
          str_professional_type: str_professional_type.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_edit_notes') {
      arr_notes_list.clear();
      setState(() {
        func_notes_WB();
      });
    }
  }

  Future<void> push_to_create_notes(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNotesInGoalScreen(
          str_profession_id: prefs.getInt('userId').toString(),
          str_profession_type: 'Profile'.toString(),
        ),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

// get_back_from_add_notes

    if (!mounted) return;

    // if (result)
    func_notes_WB();
    // setState(() {});
  }

  void open_category_list(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Categories'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          //
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);
              //
              func_notes_WB();
              //
            },
            child: Text(
              'All',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          //
          for (int i = 0; i < arr_get_category_list.length; i++) ...[
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                note_list_by_category_list_WB(
                    arr_get_category_list[i]['id'].toString());

                str_category_id = arr_get_category_list[i]['id'].toString();
              },
              child: Text(
                arr_get_category_list[i]['name'].toString(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
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

  /*
[action] => notelist
    [userId] => 45
    [categoryId] => 1
    [pageNo] => 1
  */
// NOTES
  Future note_list_by_category_list_WB(
    String str_category_id,
  ) async {
    print('=====> POST : NOTES 1');

    setState(() {
      str_main_loader = 'notes_loader_start';
    });
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      //   [action] => notelist
      // [userId] => 45
      // [categoryId] => 1
      // [pageNo] => 1
      body: jsonEncode(
        <String, String>{
          'action': 'notelist',
          'userId': prefs.getInt('userId').toString(),
          'categoryId': str_category_id.toString(),
          'pageNo': '',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arr_notes_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          arr_notes_list.add(i);
        }
        if (arr_notes_list.isEmpty) {
          setState(() {
            str_main_loader = 'notes_data_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'notes_loader_stop';
          });
        }
        // get_category_list_WB();
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  // action
  void open_filter_action_sheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Filters'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              func_notes_WB();
              //
            },
            child: Text(
              'All',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              (str_category_id == '')
                  ? search_notes_without_category_id_WB
                  : search_notes_with_category_id_WB('Goal');
              //
            },
            child: Text(
              'Goal',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              (str_category_id == '')
                  ? search_notes_without_category_id_WB
                  : search_notes_with_category_id_WB('Task');
              //
            },
            child: Text(
              'Task',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              (str_category_id == '')
                  ? search_notes_without_category_id_WB
                  : search_notes_with_category_id_WB('Quest');
              //
            },
            child: Text(
              'Quest',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              (str_category_id == '')
                  ? search_notes_without_category_id_WB
                  : search_notes_with_category_id_WB('Mission');
              //
            },
            child: Text(
              'Mission',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              (str_category_id == '')
                  ? search_notes_without_category_id_WB
                  : search_notes_with_category_id_WB('Training');
              //
            },
            child: Text(
              'Training',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              (str_category_id == '')
                  ? search_notes_without_category_id_WB
                  : search_notes_with_category_id_WB('Profile');
              //
            },
            child: Text(
              'Profile',
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
  Future search_notes_with_category_id_WB(
    String str_professional_type,
  ) async {
    print('=====> POST : NOTES 1');

    setState(() {
      str_main_loader = 'notes_loader_start';
    });
    //
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
          'action': 'notelist',
          'userId': prefs.getInt('userId').toString(),
          'categoryId': str_category_id.toString(),
          'profesionalType': str_professional_type.toString(),
          'pageNo': '',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arr_notes_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          arr_notes_list.add(i);
        }
        if (arr_notes_list.isEmpty) {
          setState(() {
            str_main_loader = 'notes_data_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'notes_loader_stop';
          });
        }
        // get_category_list_WB();
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  //
  //
  Future search_notes_without_category_id_WB(
    String str_professional_type,
  ) async {
    print('=====> POST : NOTES 1');

    setState(() {
      str_main_loader = 'notes_loader_start';
    });
    //
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
          'action': 'notelist',
          'userId': prefs.getInt('userId').toString(),
          // 'categoryId': str_category_id.toString(),
          'profesionalType': str_professional_type.toString(),
          'pageNo': '',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arr_notes_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          arr_notes_list.add(i);
        }
        if (arr_notes_list.isEmpty) {
          setState(() {
            str_main_loader = 'notes_data_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'notes_loader_stop';
          });
        }
        // get_category_list_WB();
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
