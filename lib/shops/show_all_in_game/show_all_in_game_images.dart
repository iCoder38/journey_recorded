// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/shops/shop_item_details/shop_item_details.dart';

class ShowAllInGameImagesScreen extends StatefulWidget {
  const ShowAllInGameImagesScreen(
      {super.key, required this.getNumberToParse, this.getFullData});

  final getFullData;
  final String getNumberToParse;

  @override
  State<ShowAllInGameImagesScreen> createState() =>
      _ShowAllInGameImagesScreenState();
}

class _ShowAllInGameImagesScreenState extends State<ShowAllInGameImagesScreen> {
  //
  var strNavigationTitleName = '';
  var strShowLoader = '0';
  var arrAllInOneArray = [];

  var arrGoalList = [];
  var arrMissionList = [];
  var arrQuestList = [];
  //
  var arrSkillFullData;
  //
  @override
  void initState() {
    if (kDebugMode) {
      print(widget.getNumberToParse);
    }
    if (widget.getNumberToParse == '1') {
      strNavigationTitleName = 'Skills';
    } else if (widget.getNumberToParse == '2') {
      strNavigationTitleName = 'Products';
    } else if (widget.getNumberToParse == '3') {
      strNavigationTitleName = 'Goals';
    } else if (widget.getNumberToParse == '4') {
      strNavigationTitleName = 'Missions';
    } else if (widget.getNumberToParse == '5') {
      strNavigationTitleName = 'Quests';
    }
    //
    allInOneWB();

    super.initState();
  }

  // product list
  allInOneWB() async {
    if (kDebugMode) {
      print('=====> POST : ALL');
    }

    setState(() {
      strShowLoader = '0';
    });

    var resposne;
    if (widget.getNumberToParse == '1') {
      resposne = await http.post(
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
          },
        ),
      );
    } else if (widget.getNumberToParse == '2') {
      resposne = await http.post(
        Uri.parse(
          application_base_url,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'action': 'productlist',
            'pageNo': '1',
          },
        ),
      );
    } else if (widget.getNumberToParse == '3') {
      resposne = await http.post(
        Uri.parse(
          application_base_url,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'action': 'goallist',
            'subGoal': '2',
            'pageNo': '1',
          },
        ),
      );
    } else if (widget.getNumberToParse == '4') {
      resposne = await http.post(
        Uri.parse(
          application_base_url,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'action': 'missionlist',
            'profesionalType': 'Profile',
            'pageNo': '1',
          },
        ),
      );
    } else if (widget.getNumberToParse == '5') {
      resposne = await http.post(
        Uri.parse(
          application_base_url,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'action': 'questlist',
            'profesionalType': 'Profile',
            'pageNo': '1',
          },
        ),
      );
    }

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      // print(getData);
    }

    if (resposne.statusCode == 200) {
      //
      arrAllInOneArray.clear();
      //
      if (getData['status'].toString().toLowerCase() == 'success') {
        funcManageAllDataForOne(getData);
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

  funcManageAllDataForOne(data) {
    if (kDebugMode) {
      print('====================================');
      print('====================================');
      print('MANAGE DATA FROM HERE');

      print(data);
      print(widget.getNumberToParse);

      if (widget.getNumberToParse == '1') {
        print('skilllllllllls');
        print(data['data'][0]);
        arrSkillFullData = data['data'];
      }
    }
    if (widget.getNumberToParse == '1') {
      //
      for (Map i in data['data']) {
        var custom = {
          'image': i['image'].toString(),
          'name': i['SkillName'].toString(),
          'price': i['price'].toString(),
          'description': i['description'].toString(),
          'Quantity': i['Quantity'].toString(),
          'productId': i['skillId'].toString(),
        };

        //
        arrAllInOneArray.add(custom);
      }
      //
    } else if (widget.getNumberToParse == '2') {
      //
      for (Map i in data['data']) {
        var custom = {
          'image': i['image_1'].toString(),
          'name': i['name'].toString(),
          'price': i['salePrice'].toString(),
          'description': i['description'].toString(),
          'Quantity': i['Quantity'].toString(),
          'productId': i['productId'].toString(),
          'category': i['categoryName'].toString(),
        };

        //
        arrAllInOneArray.add(custom);
      }
      //
    } else if (widget.getNumberToParse == '3') {
      //
      for (Map i in data['data']) {
        var custom = {
          'image': i['image'].toString(),
          'name': i['name'].toString(),
          'price': i['price'].toString(),
          'description': i['aboutGoal'].toString(),
          'Quantity': i['Quantity'].toString(),
          'productId': i['goalId'].toString(),
          'category': i['categoryName'].toString(),
        };

        //
        arrAllInOneArray.add(custom);
        //
        arrGoalList.add(i);
      }
      //
    } else if (widget.getNumberToParse == '4') {
      //
      for (Map i in data['data']) {
        var custom = {
          'image': i['image'].toString(),
          'name': i['name'].toString(),
          'price': i['price'].toString(),
          'description': i['description'].toString(),
          'Quantity': i['Quantity'].toString(),
          'productId': i['missionId'].toString(),
          'category': i['categoryName'].toString(),
        };

        //
        arrAllInOneArray.add(custom);
        //
        arrMissionList.add(i);
      }
      //
    } else if (widget.getNumberToParse == '5') {
      //
      for (Map i in data['data']) {
        var custom = {
          'image': i['image'].toString(),
          'name': i['name'].toString(),
          'price': i['price'].toString(),
          'description': i['description'].toString(),
          'Quantity': i['Quantity'].toString(),
          'productId': i['questId'].toString(),
          'category': i['categoryName'].toString(),
        };

        //
        arrAllInOneArray.add(custom);
        //
        arrQuestList.add(i);
      }
      //
    }
    //
    if (kDebugMode) {
      print('OUTPUT IS');
      print(arrAllInOneArray);
      // print(arrAllInOneArray[1]);
      print(arrAllInOneArray.length);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          strNavigationTitleName,
          //
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
              //

              GridView.count(
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  for (int i = 0; i < arrAllInOneArray.length; i++) ...[
                    GestureDetector(
                      onTap: () {
                        //
                        if (widget.getNumberToParse == '3') {
                          //
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopitemDetailsScreen(
                                getFullDataOfproduct: arrAllInOneArray[i],
                                strProfileNumber: 'actions',
                                getAnotherFullDataToPush: arrGoalList[i],
                              ),
                            ),
                          );
                        } else if (widget.getNumberToParse == '4') {
                          //
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopitemDetailsScreen(
                                getFullDataOfproduct: arrAllInOneArray[i],
                                strProfileNumber: 'missions',
                                getAnotherFullDataToPush: arrMissionList[i],
                              ),
                            ),
                          );
                        } else if (widget.getNumberToParse == '5') {
                          //
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopitemDetailsScreen(
                                getFullDataOfproduct: arrAllInOneArray[i],
                                strProfileNumber: 'quests',
                                getAnotherFullDataToPush: arrQuestList[i],
                              ),
                            ),
                          );
                        } else if (widget.getNumberToParse == '2') {
                          //
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopitemDetailsScreen(
                                getFullDataOfproduct: arrAllInOneArray[i],
                                strProfileNumber: '2',
                              ),
                            ),
                          );
                        } else if (widget.getNumberToParse == '1') {
                          //
                          //
                          if (kDebugMode) {
                            print('YOU PRESSED SKILL');
                            print(arrSkillFullData[i]);
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopitemDetailsScreen(
                                getFullDataOfproduct: arrAllInOneArray[i],
                                strProfileNumber: '1',
                                getSkillRealFullData: arrSkillFullData[i],
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 200,
                        // width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.4),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                  child: (arrAllInOneArray[i]['image']
                                              .toString() ==
                                          '')
                                      ? Image.asset('assets/images/logo.png')
                                      : Image.network(
                                          //
                                          arrAllInOneArray[i]['image']
                                              .toString(),
                                          fit: BoxFit.cover,
                                          //
                                        ),
                                ),
                              ),
                            ),
                            //
                            Align(
                              alignment: Alignment.center,
                              child: text_regular_style_custom(
                                //
                                arrAllInOneArray[i]['name'].toString(),
                                //
                                Colors.black,
                                16.0,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: text_bold_style_custom(
                                //
                                '\$${arrAllInOneArray[i]['price'].toString()}',
                                //
                                Colors.black,
                                14.0,
                              ),
                            ),
                            //
                          ],
                        ),
                      ),
                    ),
                  ]
                ],
              ),
              /*for (int i = 0; i < arrAllInOneArray.length; i++) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 200,
                          // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.4),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                    child: Image.network(
                                      //
                                      arrAllInOneArray[i]['image'].toString(),
                                      fit: BoxFit.cover,
                                      //
                                    ),
                                  ),
                                ),
                              ),
                              //
                              Align(
                                alignment: Alignment.center,
                                child: text_regular_style_custom(
                                  //
                                  arrAllInOneArray[i]['name'].toString(),
                                  //
                                  Colors.black,
                                  16.0,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: text_bold_style_custom(
                                  //
                                  '\$${arrAllInOneArray[i]['price'].toString()}',
                                  //
                                  Colors.black,
                                  14.0,
                                ),
                              ),
                              //
                            ],
                          ),
                        ),
                      ),
                      //
                      const SizedBox(
                        width: 12.0,
                      ),
                      //
                      /*Expanded(
                        child: Container(
                          height: 200,
                          // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(width: 0.4),
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                    child: Image.network(
                                      //
                                      arrAllInOneArray[i]['image'].toString(),
                                      fit: BoxFit.cover,
                                      //
                                    ),
                                  ),
                                ),
                              ),
                              //
                              Align(
                                alignment: Alignment.center,
                                child: text_regular_style_custom(
                                  //
                                  arrAllInOneArray[i]['name'],
                                  //
                                  Colors.black,
                                  16.0,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: text_bold_style_custom(
                                  //
                                  '\$${arrAllInOneArray[i]['price'].toString()}',
                                  //
                                  Colors.black,
                                  14.0,
                                ),
                              ),
                              //
                            ],
                          ),
                        ),
                      ),*/
                      //
                    ],
                  ),
                )
              ],*/

              //

              ///
              ///
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: 0.2,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          )),
    );
  }
}
