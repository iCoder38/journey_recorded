// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

// import 'package:journey_recorded/all_quotes_list/all_notes_in_quotes.dart';
// import 'package:journey_recorded/all_quotes_list/all_quotes_in_quotes.dart';

class AllQuotesListScreen extends StatefulWidget {
  const AllQuotesListScreen(
      {super.key,
      required this.str_cateogry_name,
      required this.str_cateogry_id,
      this.dictGetData,
      required this.str_message});

  final String str_cateogry_id;
  final String str_cateogry_name;
  final String str_message;
  final dictGetData;

  @override
  State<AllQuotesListScreen> createState() => _AllQuotesListScreenState();
}

class _AllQuotesListScreenState extends State<AllQuotesListScreen> {
  //
  var strUserSelectProfile = '1';
  var arrCategoryList = [];
  var strName = '';
  var strImage = '';
  //
  @override
  void initState() {
    //
    if (kDebugMode) {
      print('==================================');
      print(widget.dictGetData);
      print(widget.str_message);
      print('==================================');
    }
    allApiWB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: text_bold_style_custom(
              //
              widget.str_cateogry_name.toString(),
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
            backgroundColor: navigation_color,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                headerUI(context),
                //
                allTabsUI(context),
                //
                if (strUserSelectProfile == '1') ...[
                  for (int i = 0; i < arrCategoryList.length; i++) ...[
                    //
                    skillUI(i),
                    //
                    Container(
                      height: 0.4,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                    ),
                    //
                  ],
                ] else if (strUserSelectProfile == '2') ...[
                  if (arrCategoryList.isNotEmpty) ...[
                    STATSui(context),
                  ]
                ] else if (strUserSelectProfile == '3') ...[
                  if (arrCategoryList.isNotEmpty) ...[
                    for (int i = 0; i < arrCategoryList.length; i++) ...[
                      quotesUI(i),
                    ]
                  ]
                ] else if (strUserSelectProfile == '4') ...[
                  if (arrCategoryList.isNotEmpty) ...[
                    notesUI(),
                  ]
                ] else if (strUserSelectProfile == '5') ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        border: Border.all(
                          width: 0.4,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: text_bold_style_custom(
                              'Description',
                              Colors.black,
                              16.0,
                            ),
                          ),
                          //
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: text_bold_style_custom(
                              //,
                              widget.str_message.toString(),
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView notesUI() {
    return ListView.separated(
      // scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: arrCategoryList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            //
          },
          child: ListTile(
            //
            title: text_bold_style_custom(
              //
              arrCategoryList[index]['created'].toString(),
              Colors.black,
              16.0,
            ),
            subtitle: Container(
              margin: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
              child: text_regular_style_custom(
                //
                arrCategoryList[index]['message'].toString(),
                Colors.black,
                14.0,
              ),
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  ListTile skillUI(int i) {
    return ListTile(
      title: text_regular_style_custom(
        //
        arrCategoryList[i]['SkillName'].toString(),
        Colors.black,
        16.0,
      ),
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(
            14.0,
          ),
        ),
        child: (arrCategoryList[i]['image'].toString() == '')
            ? ClipRRect(
                borderRadius: BorderRadius.circular(
                  2.0,
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(
                  14.0,
                ),
                child: Image.network(
                  //
                  arrCategoryList[i]['image'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
      ),
      trailing: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(
            14.0,
          ),
        ),
        child: Center(
          child: text_regular_style_custom(
            'Level : ${arrCategoryList[i]['currentLavel'].toString()}',
            Colors.white,
            14.0,
          ),
        ),
      ),
    );
  }

  Padding quotesUI(int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                top: 0.0,
                left: 20.0,
                right: 10.0,
              ),
              // height: 70,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(
                  2,
                  24,
                  72,
                  1,
                ),
                borderRadius: BorderRadius.circular(
                  12.0,
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
              child: Padding(
                padding: const EdgeInsets.all(
                  12.0,
                ),
                child: Text(
                  //
                  arrCategoryList[i]['description'].toString(),
                  //
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding STATSui(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12.0,
          ),
          border: Border.all(
            width: 0.4,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: text_bold_style_custom(
                'STATS LVS',
                Colors.black,
                16.0,
              ),
            ),
            //
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: text_bold_style_custom(
                //,
                arrCategoryList[0]['TStats'].toString(),
                Colors.black,
                14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container allTabsUI(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: navigation_color,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                //
                setState(() {
                  strUserSelectProfile = '1';
                });
                allApiWB();
                arrCategoryList.clear();
              },
              child: SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: (strUserSelectProfile == '1')
                        ? text_bold_style_custom(
                            'Skills',
                            Colors.white,
                            18.0,
                          )
                        : text_regular_style_custom(
                            'Skills',
                            Colors.white,
                            14.0,
                          ),
                  ),
                ),
              ),
            ),
            //
            Container(
              height: 40,
              width: 0.4,
              color: Colors.white,
            ),
            //
            GestureDetector(
              onTap: () {
                //
                setState(() {
                  strUserSelectProfile = '2';
                });
                allApiWB();
                arrCategoryList.clear();
              },
              child: SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: (strUserSelectProfile == '2')
                        ? text_bold_style_custom(
                            'Stats',
                            Colors.white,
                            18.0,
                          )
                        : text_regular_style_custom(
                            'Stats',
                            Colors.white,
                            14.0,
                          ),
                  ),
                ),
              ),
            ),
            //
            Container(
              height: 40,
              width: 0.4,
              color: Colors.white,
            ),
            //
            GestureDetector(
              onTap: () {
                //
                setState(() {
                  strUserSelectProfile = '3';
                });
                allApiWB();
                arrCategoryList.clear();
              },
              child: SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: (strUserSelectProfile == '3')
                        ? text_bold_style_custom(
                            'Quotes',
                            Colors.white,
                            18.0,
                          )
                        : text_regular_style_custom(
                            'Quotes',
                            Colors.white,
                            14.0,
                          ),
                  ),
                ),
              ),
            ),
            //
            Container(
              height: 40,
              width: 0.4,
              color: Colors.white,
            ),
            //
            GestureDetector(
              onTap: () {
                //
                setState(() {
                  strUserSelectProfile = '4';
                });
                allApiWB();
                arrCategoryList.clear();
              },
              child: SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: (strUserSelectProfile == '4')
                        ? text_bold_style_custom(
                            'Notes',
                            Colors.white,
                            18.0,
                          )
                        : text_regular_style_custom(
                            'Notes',
                            Colors.white,
                            14.0,
                          ),
                  ),
                ),
              ),
            ),
            //
            Container(
              height: 40,
              width: 0.4,
              color: Colors.white,
            ),
            //
            GestureDetector(
              onTap: () {
                //
                setState(() {
                  strUserSelectProfile = '5';
                });
                print('object 2');
                // allApiWB();
                // arrCategoryList.clear();
              },
              child: SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: (strUserSelectProfile == '5')
                        ? text_bold_style_custom(
                            'Info',
                            Colors.white,
                            18.0,
                          )
                        : text_regular_style_custom(
                            'Info',
                            Colors.white,
                            14.0,
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

  Container headerUI(BuildContext context) {
    return Container(
      // height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(
              54,
              30,
              107,
              1,
            ),
            Color.fromRGBO(
              92,
              21,
              93,
              1,
            ),
            Color.fromRGBO(
              138,
              0,
              70,
              1,
            ),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              child: (strImage == '')
                  ? Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      child: Image.network(
                        strImage.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                height: 120,
                // width: 120,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text_regular_style_custom(
                      //
                      strName.toString(),
                      Colors.white,
                      16.0,
                    ),
                    //
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      // height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: text_bold_style_custom(
                            'Level : 0 ',
                            Colors.black,
                            16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  //
  allApiWB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response;
    // strUserSelectProfile
    if (strUserSelectProfile == '1') {
      if (kDebugMode) {
        print('=====> POST : SKILL LIST');
      }
      response = await http.post(
        Uri.parse(
          application_base_url,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'action': 'skilllist',
            'userId': prefs.getInt('userId').toString(),
            'categoryId': widget.dictGetData['categoryId'].toString(),
            'pageNo': '1',
          },
        ),
      );
    } else if (strUserSelectProfile == '2') {
      if (kDebugMode) {
        print('=====> POST : TRAINING LIST');
      }
      response = await http.post(
        Uri.parse(
          application_base_url,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'action': 'traininglist',
            'userId': prefs.getInt('userId').toString(),
            'categoryId': widget.dictGetData['categoryId'].toString(),
            'pageNo': '1',
          },
        ),
      );
    } else if (strUserSelectProfile == '3') {
      if (kDebugMode) {
        print('=====> POST : QUOTES LIST');
      }
      response = await http.post(
        Uri.parse(
          application_base_url,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'action': 'quotlist',
            'userId': prefs.getInt('userId').toString(),
            'categoryId': widget.dictGetData['categoryId'].toString(),
            'pageNo': '1',
          },
        ),
      );
    } else if (strUserSelectProfile == '4') {
      if (kDebugMode) {
        print('=====> POST : NOTES LIST');
      }
      response = await http.post(
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
            'categoryId': widget.dictGetData['categoryId'].toString(),
            'pageNo': '1',
          },
        ),
      );
    }

    // convert data to dict
    var get_data = jsonDecode(response.body);
    if (kDebugMode) {
      print(get_data);
    }

    if (response.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          //
          arrCategoryList.add(get_data['data'][i]);
          //
        }
        //

        if (strUserSelectProfile == '1') {
          strName = arrCategoryList[0]['userName'].toString();
          strImage = arrCategoryList[0]['image'].toString();
        }
        setState(() {});
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
