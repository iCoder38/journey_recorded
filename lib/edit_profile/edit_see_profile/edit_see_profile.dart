// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:journey_recorded/custom_files/drawer.dart';
import 'package:journey_recorded/edit_profile/edit_profile.dart';
import 'package:journey_recorded/training/training_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class EdtiSeeProfileScreen extends StatefulWidget {
  const EdtiSeeProfileScreen({super.key});

  @override
  State<EdtiSeeProfileScreen> createState() => _EdtiSeeProfileScreenState();
}

class _EdtiSeeProfileScreenState extends State<EdtiSeeProfileScreen> {
  //
  var saveLoginUserFullDetails;
  var strImage = '';
  var strUserSelectProfile = '1';
  //
  var strContactInfoUpdateLoader = '0';
  //
  var pageNumber = 1;
  var arrCategoryList = [];
  var strContactInfoName = '';
  var strContactInfoEMailAddress = '';
  var strContactInfoPhone = '';
  var strContactInfoAddress = '';
  var strContactInfoSkills = '';
  var strContactInfoImage = '';

  //
  //
  @override
  void initState() {
    super.initState();

    //
    allApiWB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        title: text_bold_style_custom(
          'Profile',
          Colors.white,
          16.0,
        ),
        actions: [
          IconButton(
            onPressed: () {
              //
              pushToEditProfile(context);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: const navigationDrawer(),
      body: NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification is UserScrollNotification) {
            final metrics = notification.metrics;
            if (metrics.atEdge) {
              bool isTop = metrics.pixels == 0;
              if (isTop) {
                if (kDebugMode) {
                  print('At the top new');
                  // print(metrics.pixels);
                }
                //
                // strScrollOnlyOneTime = '0';
              } else if (notification.direction == ScrollDirection.forward) {
                //
                if (kDebugMode) {
                  print('scroll down');
                }
                //
                // strBottomScroll = '0';
                // strScrollOnlyOneTime = '0';
              } else if (notification.direction == ScrollDirection.reverse) {
                // Handle scroll up.
                if (kDebugMode) {
                  print('scroll up');
                }
              } else {
                //
                // if (strScrollOnlyOneTime == 'start_scrolling')
                if (kDebugMode) {
                  print('Bottom');
                  // print(metrics.pixels);
                }
                //
                pageNumber += 1;
                if (kDebugMode) {
                  print(pageNumber);
                }

                allApiWB();
              }
            }
          }

          return true;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              headerUI(context),
              //
              allFourTabsUI(context),
              //
              if (strUserSelectProfile == '1') ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: 140,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text_bold_style_custom(
                                  'Name',
                                  Colors.black,
                                  16.0,
                                ),
                                //
                                (strContactInfoUpdateLoader == '0')
                                    ? text_regular_style_custom(
                                        //
                                        'please wait...',
                                        Colors.black,
                                        14.0,
                                      )
                                    : text_regular_style_custom(
                                        //
                                        strContactInfoName.toString(),
                                        Colors.black,
                                        14.0,
                                      ),
                                //
                              ],
                            ),
                          ),
                          //
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text_bold_style_custom(
                                  'E-Mail address',
                                  Colors.black,
                                  16.0,
                                ),
                                //
                                text_regular_style_custom(
                                  //
                                  strContactInfoEMailAddress.toString(),
                                  Colors.black,
                                  12.0,
                                ),
                                //
                              ],
                            ),
                          ),
                          //
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text_bold_style_custom(
                                  'Phone',
                                  Colors.black,
                                  16.0,
                                ),
                                //
                                (strContactInfoUpdateLoader == '0')
                                    ? text_regular_style_custom(
                                        //
                                        'please wait...',
                                        Colors.black,
                                        14.0,
                                      )
                                    : text_regular_style_custom(
                                        //
                                        strContactInfoPhone.toString(),
                                        Colors.black,
                                        12.0,
                                      ),
                                //
                              ],
                            ),
                          ),
                          //
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text_bold_style_custom(
                                  'Address',
                                  Colors.black,
                                  16.0,
                                ),
                                //
                                (strContactInfoUpdateLoader == '0')
                                    ? text_regular_style_custom(
                                        //
                                        'please wait...',
                                        Colors.black,
                                        14.0,
                                      )
                                    : text_regular_style_custom(
                                        //
                                        strContactInfoAddress.toString(),
                                        Colors.black,
                                        12.0,
                                      ),
                                //
                              ],
                            ),
                          ),
                          //
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text_bold_style_custom(
                                  'Skills',
                                  Colors.black,
                                  16.0,
                                ),
                                //
                                (strContactInfoUpdateLoader == '0')
                                    ? text_regular_style_custom(
                                        //
                                        'please wait...',
                                        Colors.black,
                                        14.0,
                                      )
                                    : text_regular_style_custom(
                                        //
                                        strContactInfoSkills.toString(),
                                        Colors.black,
                                        12.0,
                                      ),
                                //
                              ],
                            ),
                          ),
                          //
                        ],
                      ),
                    ),
                  ),
                ),
              ] else if (strUserSelectProfile == '3') ...[
                if (arrCategoryList.isNotEmpty) ...[
                  notesUI(),
                ]
              ] else if (strUserSelectProfile == '4') ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            //
                            //

                            setState(() {
                              strUserSelectProfile = '4';
                            });
                            if (kDebugMode) {
                              print('object 2');
                            }
                            pageNumber = 1;
                            allApiWB();
                            arrCategoryList.clear();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                            ),
                            child: Center(
                              child: text_bold_style_custom(
                                'Skills',
                                Colors.black,
                                16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserSelectProfile = '5';
                            });
                            if (kDebugMode) {
                              print('QUOTES');
                            }
                            pageNumber = 1;
                            allApiWB();
                            arrCategoryList.clear();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                            ),
                            child: Center(
                              child: (strUserSelectProfile == '5')
                                  ? text_bold_style_custom(
                                      'Quotes',
                                      Colors.black,
                                      16.0,
                                    )
                                  : text_bold_style_custom(
                                      'Quotes',
                                      Colors.black,
                                      12.0,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (arrCategoryList.isNotEmpty) ...[
                  passionSkillsUI(),
                ]
              ] else if (strUserSelectProfile == '5') ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              strUserSelectProfile = '4';
                            });
                            if (kDebugMode) {
                              print('object 2');
                            }
                            pageNumber = 1;
                            allApiWB();
                            arrCategoryList.clear();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                            ),
                            child: Center(
                              child: (strUserSelectProfile == '4')
                                  ? text_bold_style_custom(
                                      'Skills',
                                      Colors.black,
                                      16.0,
                                    )
                                  : text_bold_style_custom(
                                      'Skills',
                                      Colors.black,
                                      12.0,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserSelectProfile = '5';
                            });
                            if (kDebugMode) {
                              print('QUOTES');
                            }
                            pageNumber = 1;
                            allApiWB();
                            arrCategoryList.clear();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                            ),
                            child: Center(
                              child: (strUserSelectProfile == '5')
                                  ? text_bold_style_custom(
                                      'Quotes',
                                      Colors.black,
                                      16.0,
                                    )
                                  : text_bold_style_custom(
                                      'Quotes',
                                      Colors.black,
                                      12.0,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (arrCategoryList.isNotEmpty) ...[
                  passionQuotesUI(),
                ]
              ],
              //
            ],
          ),
        ),
      ),
    );
  }

  Padding passionSkillsUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          //
          for (int i = 0; i < arrCategoryList.length; i++) ...[
            GestureDetector(
              onTap: () {
                //
                if (arrCategoryList[i]['TrainingCount'].toString() == '0') {
                  //
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      closeIconColor: Colors.amber,
                      content: Text(
                        'Training not added yet. Please add training from skill.',
                      ),
                    ),
                  );
                  //
                } else {
                  //
                  if (kDebugMode) {
                    print(arrCategoryList[i]);
                    print('object 2');
                  }
                  //
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrainingListScreen(
                        str_skill_id: arrCategoryList[i]['skillId'].toString(),
                        str_training_id: arrCategoryList[i]['TrainingList'][0]
                                ['trainingId']
                            .toString(),
                        strUserIdEnabled: 'yes',
                      ),
                    ),
                  );
                  //
                }
              },
              child: ListTile(
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
                      //
                      'Level : ${arrCategoryList[i]['currentLavel'].toString()}',
                      Colors.white,
                      14.0,
                    ),
                  ),
                ),
              ),
            ),
          ]

          //
        ],
      ),
    );
  }

  Padding passionQuotesUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          //
          for (int i = 0; i < arrCategoryList.length; i++) ...[
            Padding(
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
            ),
          ]

          //
        ],
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

  Container allFourTabsUI(BuildContext context) {
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
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: (strUserSelectProfile == '1')
                        ? text_bold_style_custom(
                            'Contact Info',
                            Colors.white,
                            16.0,
                          )
                        : text_regular_style_custom(
                            'Contact Info',
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
                            'Affinity',
                            Colors.white,
                            16.0,
                          )
                        : text_regular_style_custom(
                            'Affinity',
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
                            'Notes',
                            Colors.white,
                            16.0,
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
                if (kDebugMode) {
                  print('object 2');
                }
                pageNumber = 1;
                allApiWB();
                arrCategoryList.clear();
              },
              child: SizedBox(
                width: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: (strUserSelectProfile == '4' ||
                            strUserSelectProfile == '5')
                        ? text_bold_style_custom(
                            'Passions',
                            Colors.white,
                            16.0,
                          )
                        : text_regular_style_custom(
                            'Passions',
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
              child: (strContactInfoImage == '')
                  ? Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      child: Image.network(
                        //
                        strContactInfoImage.toString(),
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
                    (strContactInfoUpdateLoader == '0')
                        ? text_regular_style_custom(
                            //
                            'please wait...',
                            Colors.white,
                            14.0,
                          )
                        : text_regular_style_custom(
                            //
                            strContactInfoName.toString(),
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
                            //
                            strContactInfoSkills,
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

  Future<void> pushToEditProfile(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditProfileScreen(getLoginUserDetails: saveLoginUserFullDetails),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_edit_profile') {
      setState(() {
        allApiWB();
        strUserSelectProfile = '1';
        strContactInfoUpdateLoader = '0';
      });
    }
  }

  allApiWB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response;
    // strUserSelectProfile
    if (strUserSelectProfile == '1') {
      if (kDebugMode) {
        print('=====> POST : PROFILE');
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
            'action': 'profile',
            'userId': prefs.getInt('userId').toString(),
          },
        ),
      );
    } else if (strUserSelectProfile == '2') {
      if (kDebugMode) {
        print('=====> POST : AFFINITY LIST');
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
            'action': 'tasklist',
            'assignUserId': prefs.getInt('userId').toString(),
            'completed': '1,2,3'.toString(),
            'pageNo': '1',
          },
        ),
      );
    } else if (strUserSelectProfile == '3') {
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
          <String, dynamic>{
            'action': 'notelist',
            'userId': prefs.getInt('userId').toString(),
            'pageNo': pageNumber,
          },
        ),
      );
    } else if (strUserSelectProfile == '4') {
      if (kDebugMode) {
        print('=====> POST : PASSIONS LIST');
      }
      response = await http.post(
        Uri.parse(
          application_base_url,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'action': 'skilllist',
            'userId': prefs.getInt('userId').toString(),
            'pageNo': pageNumber,
          },
        ),
      );
    } else if (strUserSelectProfile == '5') {
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
          <String, dynamic>{
            'action': 'quotlist',
            'userId': prefs.getInt('userId').toString(),
            'pageNo': pageNumber,
          },
        ),
      );
    }
    //
    // convert data to dict
    var getData = jsonDecode(response.body);
    if (kDebugMode) {
      print(getData);
    }

    if (response.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        if (strUserSelectProfile == '1') {
          //
          strContactInfoName = getData['data']['fullName'].toString();
          strContactInfoEMailAddress = getData['data']['email'].toString();
          strContactInfoPhone = getData['data']['contactNumber'].toString();
          strContactInfoAddress = getData['data']['address'].toString();
          strContactInfoSkills = getData['data']['career'].toString();
          strContactInfoImage = getData['data']['image'].toString();
          //
          strContactInfoUpdateLoader = '1';
          //
          saveLoginUserFullDetails = getData['data'];
          //
        } else if (strUserSelectProfile == '2') {
          for (var i = 0; i < getData['data'].length; i++) {
            //
            arrCategoryList.add(getData['data'][i]);
          }
        } else if (strUserSelectProfile == '3') {
          for (var i = 0; i < getData['data'].length; i++) {
            //
            arrCategoryList.add(getData['data'][i]);
          }
        } else if (strUserSelectProfile == '4') {
          for (var i = 0; i < getData['data'].length; i++) {
            //
            arrCategoryList.add(getData['data'][i]);
          }
        } else if (strUserSelectProfile == '5') {
          for (var i = 0; i < getData['data'].length; i++) {
            //
            arrCategoryList.add(getData['data'][i]);
          }
        }

        setState(() {});
        //
      } else {
        if (kDebugMode) {
          print(
            '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
          );
        }
      }
    } else {
      // return postList;
      if (kDebugMode) {
        print('something went wrong');
      }
    }
  }
}
