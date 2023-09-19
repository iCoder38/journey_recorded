import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:journey_recorded/real_main_details/real_main_details.dart';
import 'package:journey_recorded/shop_order_history/shop_order_history_details/shop_order_history_details.dart';
import 'package:journey_recorded/shops/shop_all_view_details/shop_all_view_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class ShopHistoryScreen extends StatefulWidget {
  const ShopHistoryScreen({super.key});

  @override
  State<ShopHistoryScreen> createState() => _ShopHistoryScreenState();
}

class _ShopHistoryScreenState extends State<ShopHistoryScreen> {
  //
  var strScreenLoader = '0';
  var strUserClickWhichPanel = '1';
  //
  var arrAllDetails = [];
  //
  @override
  void initState() {
    //
    funcGetAllProductListWB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: navigation_color,
        title: text_bold_style_custom(
          'Shop History',
          Colors.white,
          16.0,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            color: navigation_color,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  (strUserClickWhichPanel == '1')
                      ? GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserClickWhichPanel = '1';
                              strScreenLoader = '0';
                              funcGetAllProductListWB();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            color: Colors.transparent,
                            child: Center(
                              child: text_bold_style_custom(
                                'Product'.toUpperCase(),
                                Colors.white,
                                18.0,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserClickWhichPanel = '1';
                              strScreenLoader = '0';
                              funcGetAllProductListWB();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            color: Colors.transparent,
                            child: Center(
                              child: text_regular_style_custom(
                                'Product',
                                Colors.white,
                                14.0,
                              ),
                            ),
                          ),
                        ),
                  /***********************************************/
                  /***********************************************/
                  (strUserClickWhichPanel == '2')
                      ? GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserClickWhichPanel = '2';
                              //
                              strScreenLoader = '0';
                              funcGetAllSkillListWB();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            color: Colors.transparent,
                            child: Center(
                              child: text_bold_style_custom(
                                'Skills'.toUpperCase(),
                                Colors.white,
                                18.0,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserClickWhichPanel = '2';
                              //
                              strScreenLoader = '0';
                              funcGetAllSkillListWB();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            color: Colors.transparent,
                            child: Center(
                              child: text_regular_style_custom(
                                'Skills',
                                Colors.white,
                                14.0,
                              ),
                            ),
                          ),
                        ),
                  /***********************************************/
                  /***********************************************/
                  (strUserClickWhichPanel == '3')
                      ? GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserClickWhichPanel = '3'; //
                              strScreenLoader = '0';
                              funcGetAllGoalListWB();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            color: Colors.transparent,
                            child: Center(
                              child: text_bold_style_custom(
                                'Goal'.toUpperCase(),
                                Colors.white,
                                18.0,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserClickWhichPanel = '3'; //
                              strScreenLoader = '0';
                              funcGetAllGoalListWB();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            color: Colors.transparent,
                            child: Center(
                              child: text_regular_style_custom(
                                'Goal',
                                Colors.white,
                                14.0,
                              ),
                            ),
                          ),
                        ),
                  /***********************************************/
                  /***********************************************/
                  (strUserClickWhichPanel == '4')
                      ? GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserClickWhichPanel = '4'; //
                              strScreenLoader = '0';
                              funcGetAllMissionListWB();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            color: Colors.transparent,
                            child: Center(
                              child: text_bold_style_custom(
                                'MISSIONS',
                                Colors.white,
                                18.0,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserClickWhichPanel = '4'; //
                              strScreenLoader = '0';
                              funcGetAllMissionListWB();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            color: Colors.transparent,
                            child: Center(
                              child: text_regular_style_custom(
                                'Missions',
                                Colors.white,
                                14.0,
                              ),
                            ),
                          ),
                        ),
                  /***********************************************/
                  /***********************************************/
                  (strUserClickWhichPanel == '5')
                      ? GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserClickWhichPanel = '5'; //
                              strScreenLoader = '0';
                              funcGetAllQuestListWB();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            color: Colors.transparent,
                            child: Center(
                              child: text_bold_style_custom(
                                'Quest'.toUpperCase(),
                                Colors.white,
                                18.0,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strUserClickWhichPanel = '5'; //
                              strScreenLoader = '0';
                              funcGetAllQuestListWB();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            color: Colors.transparent,
                            child: Center(
                              child: text_regular_style_custom(
                                'Quest',
                                Colors.white,
                                14.0,
                              ),
                            ),
                          ),
                        ),
                  /***********************************************/
                  /***********************************************/
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    if (strUserClickWhichPanel == '1') ...[
                      //
                      if (strScreenLoader == '0') ...[
                        const Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ] else ...[
                        for (int i = 0; i < arrAllDetails.length; i++) ...[
                          //
                          productListUI(context, i),
                          //
                          Container(
                            height: 0.4,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black,
                          ),
                        ]
                      ]
                    ] else if (strUserClickWhichPanel == '2') ...[
                      //
                      if (strScreenLoader == '0') ...[
                        const Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ] else ...[
                        //
                        for (int i = 0; i < arrAllDetails.length; i++) ...[
                          //
                          skillListUI(context, i),
                          //
                          Container(
                            height: 0.4,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black,
                          ),
                        ]
                      ],
                    ] else if (strUserClickWhichPanel == '3') ...[
                      //
                      if (strScreenLoader == '0') ...[
                        const Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ] else ...[
                        //
                        for (int i = 0; i < arrAllDetails.length; i++) ...[
                          //
                          goalListUI(context, i),
                          //
                          Container(
                            height: 0.4,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black,
                          ),
                        ]
                      ],
                    ] else if (strUserClickWhichPanel == '4') ...[
                      //
                      if (strScreenLoader == '0') ...[
                        const Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ] else ...[
                        //
                        for (int i = 0; i < arrAllDetails.length; i++) ...[
                          //
                          missionListUI(context, i),
                          //
                          Container(
                            height: 0.4,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black,
                          ),
                        ]
                      ],
                    ] else if (strUserClickWhichPanel == '5') ...[
                      //
                      if (strScreenLoader == '0') ...[
                        const Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ] else ...[
                        //
                        for (int i = 0; i < arrAllDetails.length; i++) ...[
                          //
                          questListUI(context, i),
                          //
                          Container(
                            height: 0.4,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black,
                          ),
                        ]
                      ],
                    ]
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector questListUI(BuildContext context, int i) {
    return GestureDetector(
      onTap: () {
        //
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RealMainDetailsScreen(
              str_navigation_title: 'Quest',
              str_category_name: arrAllDetails[i]['categoryName'].toString(),
              str_name: arrAllDetails[i]['name'].toString(),
              str_due_date: arrAllDetails[i]['deadline'].toString(),
              str_get_about_goal: arrAllDetails[i]['description'].toString(),
              str_get_goal_id: arrAllDetails[i]['questId'].toString(),
              str_category_id: arrAllDetails[i]['categoryId'].toString(),
              str_professional_type: 'Quest',
              str_tray_value: 'quest',
              str_parent_name: arrAllDetails[i]['parentName'].toString(),
              str_goal_cat_id: arrAllDetails[i]['questId'].toString(),
              str_image: arrAllDetails[i]['image'].toString(),
              strFromViewDetails: 'yes',
              fullData: arrAllDetails[i],
            ),
          ),
        );
      },
      child: ListTile(
        title: text_bold_style_custom(
          //
          arrAllDetails[i]['name'].toString(),
          Colors.black,
          16.0,
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                //
                text_bold_style_custom(
                  //
                  'Order date : ',
                  Colors.grey,
                  14.0,
                ),
                //
                text_regular_style_custom(
                  //
                  arrAllDetails[i]['created'].toString(),
                  Colors.black,
                  11.0,
                ),
              ],
            ),
            //
            Row(
              children: [
                //
                text_bold_style_custom(
                  //
                  'Price : ',
                  Colors.grey,
                  14.0,
                ),
                //
                text_regular_style_custom(
                  //
                  '\$${arrAllDetails[i]['price']}',
                  Colors.black,
                  12.0,
                ),
              ],
            ),
            //
          ],
        ),
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(
              30.0,
            ),
          ),
          child: (arrAllDetails[i]['image'].toString() != '')
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  child: Image.network(
                    arrAllDetails[i]['image'].toString(),
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  'assets/images/logo.png',
                ),
        ),
        //
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }

  GestureDetector missionListUI(BuildContext context, int i) {
    return GestureDetector(
      onTap: () {
        //
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RealMainDetailsScreen(
              str_navigation_title: 'Mission',
              str_category_name: arrAllDetails[i]['categoryName'].toString(),
              str_name: arrAllDetails[i]['name'].toString(),
              str_due_date: arrAllDetails[i]['deadline'].toString(),
              str_get_about_goal: arrAllDetails[i]['description'].toString(),
              str_get_goal_id: arrAllDetails[i]['missionId'].toString(),
              str_category_id: arrAllDetails[i]['categoryId'].toString(),
              str_professional_type: 'Mission',
              str_tray_value: 'mission',
              str_parent_name: arrAllDetails[i]['parentName'].toString(),
              str_goal_cat_id: arrAllDetails[i]['missionId'].toString(),
              str_image: arrAllDetails[i]['image'].toString(),
              strFromViewDetails: 'yes',
              fullData: arrAllDetails[i],
            ),
          ),
        );
      },
      child: ListTile(
        title: text_bold_style_custom(
          //
          arrAllDetails[i]['name'].toString(),
          Colors.black,
          16.0,
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                //
                text_bold_style_custom(
                  //
                  'Order date : ',
                  Colors.grey,
                  14.0,
                ),
                //
                text_regular_style_custom(
                  //
                  arrAllDetails[i]['created'].toString(),
                  Colors.black,
                  11.0,
                ),
              ],
            ),
            //
            Row(
              children: [
                //
                text_bold_style_custom(
                  //
                  'Price : ',
                  Colors.grey,
                  14.0,
                ),
                //
                text_regular_style_custom(
                  //
                  '\$${arrAllDetails[i]['price']}',
                  Colors.black,
                  12.0,
                ),
              ],
            ),
            //
          ],
        ),
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(
              30.0,
            ),
          ),
          child: (arrAllDetails[i]['image'].toString() != '')
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  child: Image.network(
                    arrAllDetails[i]['image'].toString(),
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  'assets/images/logo.png',
                ),
        ),
        //
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }

  GestureDetector goalListUI(BuildContext context, int i) {
    return GestureDetector(
      onTap: () {
        //
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShopAllViewDetailsScreen(
              getFullDataInViewDetails: arrAllDetails[i],
            ),
          ),
        );
      },
      child: ListTile(
        title: text_bold_style_custom(
          //
          arrAllDetails[i]['name'].toString(),
          Colors.black,
          16.0,
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                //
                text_bold_style_custom(
                  //
                  'Order date : ',
                  Colors.grey,
                  14.0,
                ),
                //
                text_regular_style_custom(
                  //
                  arrAllDetails[i]['created'].toString(),
                  Colors.black,
                  11.0,
                ),
              ],
            ),
            //
            Row(
              children: [
                //
                text_bold_style_custom(
                  //
                  'Price : ',
                  Colors.grey,
                  14.0,
                ),
                //
                text_regular_style_custom(
                  //
                  '\$${arrAllDetails[i]['price']}',
                  Colors.black,
                  12.0,
                ),
              ],
            ),
            //
          ],
        ),
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(
              30.0,
            ),
          ),
          child: (arrAllDetails[i]['image'].toString() != '')
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  child: Image.network(
                    arrAllDetails[i]['image'].toString(),
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  'assets/images/logo.png',
                ),
        ),
        //
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }

  GestureDetector skillListUI(BuildContext context, int i) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: ListTile(
        title: text_bold_style_custom(
          //
          arrAllDetails[i]['SkillName'].toString(),
          Colors.black,
          16.0,
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                //
                text_bold_style_custom(
                  //
                  'Order date : ',
                  Colors.grey,
                  14.0,
                ),
                //
                text_regular_style_custom(
                  //
                  arrAllDetails[i]['created'].toString(),
                  Colors.black,
                  11.0,
                ),
              ],
            ),
            //
            Row(
              children: [
                //
                text_bold_style_custom(
                  //
                  'Price : ',
                  Colors.grey,
                  14.0,
                ),
                //
                text_regular_style_custom(
                  //
                  '\$${arrAllDetails[i]['price']}',
                  Colors.black,
                  12.0,
                ),
              ],
            ),
            //
          ],
        ),
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(
              30.0,
            ),
          ),
          child: (arrAllDetails[i]['image'].toString() != '')
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  child: Image.network(
                    arrAllDetails[i]['image'].toString(),
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  'assets/images/logo.png',
                ),
        ),
        //
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }

  GestureDetector productListUI(BuildContext context, int i) {
    return GestureDetector(
      onTap: () {
        //
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ShopOrderHistoryDetailsScreen(getFullData: arrAllDetails[i]),
          ),
        );
      },
      child: ListTile(
        title: text_bold_style_custom(
          //
          arrAllDetails[i]['name'].toString(),
          Colors.black,
          16.0,
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                //
                text_bold_style_custom(
                  //
                  'Order date : ',
                  Colors.grey,
                  14.0,
                ),
                //
                text_regular_style_custom(
                  //
                  arrAllDetails[i]['purchaseDate'].toString(),
                  Colors.black,
                  11.0,
                ),
              ],
            ),
            //
            Row(
              children: [
                //
                text_bold_style_custom(
                  //
                  'Price : ',
                  Colors.grey,
                  14.0,
                ),
                //
                text_regular_style_custom(
                  //
                  '\$${arrAllDetails[i]['amount']}',
                  Colors.black,
                  12.0,
                ),
              ],
            ),
            //
          ],
        ),
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(
              30.0,
            ),
          ),
          child: (arrAllDetails[i]['productImage'].toString() != '')
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  child: Image.network(
                    arrAllDetails[i]['productImage'].toString(),
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  'assets/images/logo.png',
                ),
        ),
        //
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }

  //
  //
  //
  funcGetAllProductListWB() async {
    if (kDebugMode) {
      print('=====> POST : GET PRODUCT LIST');
    }

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
          'action': 'orderhistory',
          'pageNo': '1',
          'userId': prefs.getInt('userId').toString(),
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
        // get and parse data
        //
        arrAllDetails.clear();
        for (Map i in getData['data']) {
          arrAllDetails.add(i);
        }
        //
        if (kDebugMode) {
          // print(arrAllDetails.length);
          // print(arrAllDetails);
          // print(arrAllDetails['data']);
        }
        setState(() {
          strScreenLoader = '1';
        });
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

  //
  //
  funcGetAllSkillListWB() async {
    if (kDebugMode) {
      print('=====> POST : GET SKILL LIST');
    }

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
          'action': 'skilllist',
          'pageNo': '1',
          'history': 'Yes',
          'userId': prefs.getInt('userId').toString(),
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
        // get and parse data
        //
        arrAllDetails.clear();
        for (Map i in getData['data']) {
          arrAllDetails.add(i);
        }
        //
        if (kDebugMode) {
          // print(arrAllDetails.length);
          // print(arrAllDetails);
          // print(arrAllDetails['data']);
        }
        setState(() {
          strScreenLoader = '1';
        });
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

  //
  //
  funcGetAllGoalListWB() async {
    if (kDebugMode) {
      print('=====> POST : GET GOAL LIST');
    }

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
          'action': 'goallist',
          'userId': prefs.getInt('userId').toString(),
          'history': 'Yes',
          'pageNo': '1',
          'subGoal': '2',
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
        // get and parse data
        //
        arrAllDetails.clear();
        for (Map i in getData['data']) {
          arrAllDetails.add(i);
        }
        //
        if (kDebugMode) {
          // print(arrAllDetails.length);
          // print(arrAllDetails);
          // print(arrAllDetails['data']);
        }
        setState(() {
          strScreenLoader = '1';
        });
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

  //
  //
  funcGetAllMissionListWB() async {
    if (kDebugMode) {
      print('=====> POST : GET MISSION LIST');
    }

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
          'action': 'missionlist',
          'userId': prefs.getInt('userId').toString(),
          'history': 'Yes',
          'pageNo': '1'
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
        // get and parse data
        //
        arrAllDetails.clear();
        for (Map i in getData['data']) {
          arrAllDetails.add(i);
        }
        //
        if (kDebugMode) {
          // print(arrAllDetails.length);
          // print(arrAllDetails);
          // print(arrAllDetails['data']);
        }
        setState(() {
          strScreenLoader = '1';
        });
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

  //
  //
  funcGetAllQuestListWB() async {
    if (kDebugMode) {
      print('=====> POST : GET QUEST LIST');
    }

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
          'action': 'questlist',
          'userId': prefs.getInt('userId').toString(),
          'history': 'Yes',
          'pageNo': '1'
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
        // get and parse data
        //
        arrAllDetails.clear();
        for (Map i in getData['data']) {
          arrAllDetails.add(i);
        }
        //
        if (kDebugMode) {
          // print(arrAllDetails.length);
          // print(arrAllDetails);
          // print(arrAllDetails['data']);
        }
        setState(() {
          strScreenLoader = '1';
        });
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
