// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/shop_click_details/shop_click_details.dart';
import 'package:journey_recorded/shops/in_game_details/in_game_action_details.dart';
import 'package:journey_recorded/shops/shop_history/shop_history.dart';
import 'package:journey_recorded/shops/shop_item_details/shop_item_details.dart';
import 'package:journey_recorded/shops/show_all_in_game/show_all_in_game_images.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //
  var str_main_loader = '0';
  //
  var arr_action_list = [];
  var arr_skill_list = [];
  var arr_product_list = [];
  var arrOutGameList = [];
  //
  late final TextEditingController contSearchHere;
  //
  @override
  void initState() {
    contSearchHere = TextEditingController();
    actionList();
    super.initState();
  }

  @override
  void dispose() {
    contSearchHere.dispose();

    super.dispose();
  }

  // action list
  actionList() async {
    if (kDebugMode) {
      print('=====> POST : ACTION LIST');
    }

    setState(() {
      str_main_loader = '0';
    });

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
          'subGoal': '2',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      // print(get_data);
    }

    if (resposne.statusCode == 200) {
      //
      arr_action_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arr_action_list.add(i);
          //
        }
        //
        skillListWB();
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

  // product list
  skillListWB() async {
    if (kDebugMode) {
      print('=====> POST : SKILL LIST');
    }

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
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      // print(get_data);
    }

    if (resposne.statusCode == 200) {
      //
      arr_skill_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arr_skill_list.add(i);
          //
        }
        //
        product_list_WB();

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

// product list
  product_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : PRODUCT LIST');
    }

    setState(() {
      str_main_loader = '0';
    });

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'productlist',
          // 'pageNo': '1',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(get_data);
    }

    if (resposne.statusCode == 200) {
      //
      arr_product_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arr_product_list.add(i);
          //
        }
        //
        setState(() {
          // str_main_loader = '2';
        });
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

  // business list
  business_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : BUSINESS LIST');
    }
    setState(() {
      str_main_loader = '1';
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
          'action': 'businesslist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '1',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(get_data);
    }

    if (resposne.statusCode == 200) {
      //
      arrOutGameList.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arrOutGameList.add(i);
          //
        }
        //
        setState(() {
          str_main_loader = '0';
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
    }
  }

  // business list
  business_list_search_WB(textIs) async {
    if (kDebugMode) {
      print('=====> POST : BUSINESS LIST AFTER SEARCH');
    }

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
          'action': 'businesslist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '1',
          'keyword': textIs.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(get_data);
    }

    if (resposne.statusCode == 200) {
      //
      arrOutGameList.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arrOutGameList.add(i);
          //
        }
        //
        setState(() {
          str_main_loader = '0';
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
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: TabBar(
              indicatorColor: Colors.lime,
              isScrollable: true,
              // labelColor: Colors.amber,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'In Game',
                    Colors.white,
                    16.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'Out Game',
                    Colors.white,
                    16.0,
                  ),
                ),
              ],
              onTap: (value) {
                if (kDebugMode) {
                  print(value);
                }
                if (value == 0) {
                  product_list_WB();
                } else if (value == 1) {
                  business_list_WB();
                } else {}
              },
            ),
            backgroundColor: navigation_color,
            title: Text(
              ///
              navigation_title_shops,

              ///

              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: InkWell(
                  onTap: () {
                    //
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShopHistoryScreen(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.dashboard_customize_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: /*(str_main_loader == '0')
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : */
              TabBarView(
            children: <Widget>[
              //
              tabbar_in_games_UI(context),
              //
              tabbar_OUT_GAMES_ui(context),
              //
              /*ListView.builder(
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
                        top: 20.0,
                        bottom: 0.0,
                      ),
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: ListTile(
                        leading: const FlutterLogo(size: 72.0),
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Three-line ListTile',
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // subtitle: const Text(''),
                        /*trailing: Icon(
                      Icons.more_vert,
                      ),*/
                        // isThreeLine: true,
                      ),
                    ),
                  );
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView tabbar_OUT_GAMES_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: (str_main_loader == '1')
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.amber,
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
                  child: Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextField(
                      controller: contSearchHere,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Search here...',
                      ),
                      onSubmitted: (value) {
                        //
                        business_list_search_WB(value);
                      },
                    ),
                  ),
                ),
                //
                for (int i = 0; i < arrOutGameList.length; i++) ...[
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      push_to_Add_mission(context, i);
                    },
                    //
                    // https://demo4.evirtualservices.net/journey/img/uploads/1674210674image_picker_A2D06B8E-5731-4C64-B8B3-5E0C83B5FF7A-33908-0000007423B30F37.jpg
                    //
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          233,
                          233,
                          233,
                          1,
                        ),
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          (arrOutGameList[i]['profile_picture'].toString() ==
                                  '')
                              ? Container(
                                  margin: const EdgeInsets.all(
                                    10.0,
                                  ),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                      0,
                                    ),
                                  ),
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.all(
                                    10.0,
                                  ),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(
                                      14.0,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                    child: Image.network(
                                      arrOutGameList[i]['profile_picture']
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          /*Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                      ),
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                      ),
                      child: 
                      /*ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child:
                            (arrOutGameList[i]['profile_picture'].toString() ==
                                    '')
                                ? Image.asset('assets/images/logo.png')
                                : FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/loader.gif',
                                    image: arrOutGameList[i]['profile_picture']
                                        .toString(),
                                  ),
                      ),*/
                    ),*/
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 0.0,
                                right: 20.0,
                              ),
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: text_bold_style_custom(
                                        //
                                        arrOutGameList[i]['businessName']
                                            .toString(),
                                        Colors.black,
                                        18.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          color: Colors.black,
                                          size: 18.0,
                                        ),
                                        //
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        //
                                        text_regular_style_custom(
                                          //
                                          arrOutGameList[i]['contactNumber']
                                              .toString(),
                                          Colors.black,
                                          14.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.pin_drop,
                                          color: Colors.black,
                                          size: 18.0,
                                        ), //
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        //
                                        text_regular_style_custom(
                                          //
                                          arrOutGameList[i]['businessAddress']
                                              .toString(),
                                          Colors.black,
                                          14.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ],
            ),
    );
  }

  SingleChildScrollView tabbar_in_games_UI(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text_with_bold_style_black(
                      'Actions',
                    ),
                    //
                    GestureDetector(
                      onTap: () {
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const InGameActionDetailsScreen(
                                    // getAllGameData: arr_action_list,
                                    ),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        child: Center(
                          child: text_regular_style_custom(
                            'View',
                            Colors.black,
                            14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            // text_with_regular_style(arr_action_list.length),
            //
            if (arr_action_list.isEmpty) ...[
              //
              text_with_regular_style('please wait...'),
              //
            ] else if (arr_action_list.length == 1) ...[
              //
              for (int i = 0; i < arr_action_list.length; i++) ...[
                actionHaveOneDataUI(i)
              ]
              //
            ] else ...[
              //
              actionHaveTwoDataUI()
              //
            ],
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

            ///
            //
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text_with_bold_style_black(
                      'Skills',
                    ),
                    //
                    GestureDetector(
                      onTap: () {
                        //
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ShowAllInGameImagesScreen(
                              getNumberToParse: '1',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        child: Center(
                          child: text_regular_style_custom(
                            'View all',
                            Colors.black,
                            14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            // text_with_regular_style(arr_skill_list.length),
            //
            /*if (arr_skill_list.isEmpty) ...[
              //
              text_with_regular_style('please wait...'),
              //
            ] else if (arr_skill_list.length == 1) ...[
              //
              for (int i = 0; i < arr_skill_list.length; i++) ...[
                skillHaveOneDataUI(i),
              ]
              //
            ] else ...[*/
            //
            skillHaveMultipleDataUI(),
            //
            // ],

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

            ///
            //
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text_with_bold_style_black(
                      'Products',
                    ),
                    //
                    GestureDetector(
                      onTap: () {
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ShowAllInGameImagesScreen(
                              getNumberToParse: '2',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        child: Center(
                          child: text_regular_style_custom(
                            'View all',
                            Colors.black,
                            14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            // text_with_regular_style(arr_product_list.length),
            //
            //
            if (arr_product_list.isEmpty) ...[
              //
              text_with_regular_style('please wait...'),
              //
            ] else if (arr_product_list.length == 1) ...[
              //
              productSingleDataUI(),
              //
            ] else ...[
              //
              productMultipleDataUI(),
              //
            ],
            //

            const SizedBox(
              height: 20.0,
            ),
          ],
        )

        /*Column(
        children: <Widget>[
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.amber,
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
          ),
          (str_main_loader == '0')
              ? const CustomeLoaderPopUp(
                  str_custom_loader: 'please wait...',
                  str_status: '4',
                )
              : GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    mainAxisExtent: 200,
                    // childAspectRatio: 500,
                  ),
                  itemCount: arr_product_list.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // ss
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShopitemDetailsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                // height: MediaQuery.of(context).size.height,
                                height: 40,
                                color: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: (arr_product_list[index]['image']
                                              .toString() ==
                                          '')
                                      ? Image.asset('assets/images/logo.png')
                                      : FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/loader.gif',
                                          image: arr_product_list[index]
                                                  ['image']
                                              .toString(),
                                        ),
                                ),
                              ),
                            ),
                            Container(
                              // height: MediaQuery.of(context).size.height,
                              height: 40,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  //
                                  arr_product_list[index]['name'].toString(),
                                  //
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // height: MediaQuery.of(context).size.height,
                              height: 40,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  //
                                  '\$${arr_product_list[index]['salePrice']}',
                                  //
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
        ],
      ),*/
        );
  }

  funcProductManageToDetails(productClickedData) {
    if (kDebugMode) {
      print(productClickedData);
    }

    var custom = {
      'image': productClickedData['image_1'].toString(),
      'name': productClickedData['name'].toString(),
      'price': productClickedData['salePrice'].toString(),
      'description': productClickedData['description'].toString(),
      'Quantity': productClickedData['Quantity'].toString(),
      'productId': productClickedData['productId'].toString(),
      'image_1': productClickedData['image_1'].toString(),
      'image_2': productClickedData['image_2'].toString(),
      'image_3': productClickedData['image_3'].toString(),
      'image_4': productClickedData['image_4'].toString(),
      'image_5': productClickedData['image_5'].toString(),
    };

    //

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShopitemDetailsScreen(
          getFullDataOfproduct: custom,
          strProfileNumber: '2',
        ),
      ),
    );
  }

  Padding productMultipleDataUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                //
                funcProductManageToDetails(arr_product_list[0]);

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ShopitemDetailsScreen(
                //       getFullDataOfproduct: arr_product_list[0],
                //       strProfileNumber: '2',
                //     ),
                //   ),
                // );
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
                          child: Image.network(
                            //
                            arr_product_list[0]['image_1'].toString(),
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
                        arr_product_list[0]['name'].toString(),
                        //
                        Colors.black,
                        16.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: text_bold_style_custom(
                        //
                        '\$${arr_product_list[0]['salePrice']}',
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
          ),
          //
          const SizedBox(
            width: 12.0,
          ),
          //
          Expanded(
            child: GestureDetector(
              onTap: () {
                //
                funcProductManageToDetails(arr_product_list[1]);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ShopitemDetailsScreen(
                //       getFullDataOfproduct: arr_product_list[1],
                //       strProfileNumber: '2',
                //     ),
                //   ),
                // );
              },
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
                            arr_product_list[1]['image_1'].toString(),
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
                        arr_product_list[1]['name'].toString(),
                        //
                        Colors.black,
                        16.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: text_bold_style_custom(
                        //
                        '\$${arr_product_list[1]['salePrice']}',
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
          ),
          //
        ],
      ),
    );
  }

  Padding productSingleDataUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopitemDetailsScreen(
                      getFullDataOfproduct: arr_product_list[0],
                    ),
                  ),
                );
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
                          child: Image.network(
                            //
                            arr_product_list[0]['image_1'].toString(),
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
                        arr_product_list[0]['name'].toString(),
                        //
                        Colors.black,
                        16.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: text_bold_style_custom(
                        //
                        '\$${arr_product_list[0]['salePrice']}',
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
          ),
          //
          const SizedBox(
            width: 12.0,
          ),

          //
        ],
      ),
    );
  }

  funcSkillManageToDetails(skillClickedData) {
    if (kDebugMode) {
      print(skillClickedData);
    }

    var custom = {
      'image': skillClickedData['image'].toString(),
      'name': skillClickedData['SkillName'].toString(),
      'price': skillClickedData['price'].toString(),
      'description': skillClickedData['description'].toString(),
      'Quantity': skillClickedData['Quantity'].toString(),
      'productId': skillClickedData['skillId'].toString(),
    };

    // //

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShopitemDetailsScreen(
          getFullDataOfproduct: custom,
          strProfileNumber: '1',
          getSkillRealFullData: skillClickedData,
        ),
      ),
    );
  }

  Padding skillHaveMultipleDataUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < arr_skill_list.length; i++) ...[
              GestureDetector(
                onTap: () {
                  //
                  funcSkillManageToDetails(arr_skill_list[i]);
                },
                child: Container(
                  height: 200,
                  width: 200,
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
                              arr_skill_list[i]['image'].toString(),
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
                          arr_skill_list[i]['SkillName'].toString(),
                          //
                          Colors.black,
                          16.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: text_bold_style_custom(
                          //
                          '\$${arr_skill_list[i]['price'].toString()}',
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
              const SizedBox(
                width: 12.0,
              ),
            ]
            /*Expanded(
              child: GestureDetector(
                onTap: () {
                  //
                  funcSkillManageToDetails(arr_skill_list[0]);
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
                            child: Image.network(
                              //
                              arr_skill_list[0]['image'].toString(),
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
                          arr_skill_list[0]['SkillName'].toString(),
                          //
                          Colors.black,
                          16.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: text_bold_style_custom(
                          //
                          '\$${arr_skill_list[0]['price'].toString()}',
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
            ),*/
            //
            /*const SizedBox(
              width: 12.0,
            ),*/

            //
            /*Expanded(
              child: GestureDetector(
                onTap: () {
                  //
                  //
                  funcSkillManageToDetails(arr_skill_list[1]);
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
                            child: Image.network(
                              //
                              arr_skill_list[1]['image'].toString(),
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
                          arr_skill_list[1]['SkillName'].toString(),
                          //
                          Colors.black,
                          16.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: text_bold_style_custom(
                          //
                          '\$${arr_skill_list[1]['price'].toString()}',
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
            ),*/
          ],
        ),
      ),
    );
  }

  Padding skillHaveOneDataUI(int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                //
                //
                funcSkillManageToDetails(arr_skill_list[i]);
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
                          child: Image.network(
                            //
                            arr_skill_list[i]['image'].toString(),
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
                        arr_skill_list[i]['SkillName'].toString(),
                        //
                        Colors.black,
                        16.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: text_bold_style_custom(
                        //
                        '\$${arr_skill_list[i]['price']}',
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
          ),
          //
          const SizedBox(
            width: 12.0,
          ),

          //
        ],
      ),
    );
  }

  funcActionsManageToDetails(actionClickedData) {
    if (kDebugMode) {
      print(actionClickedData);
    }

    var custom = {
      'image': actionClickedData['image'].toString(),
      'name': actionClickedData['name'].toString(),
      'price': actionClickedData['price'].toString(),
      'description': actionClickedData['aboutGoal'].toString(),
      'Quantity': '1',
      'productId': actionClickedData['goalId'].toString(),
      'category': actionClickedData['categoryName'].toString(),
    };

    //
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShopitemDetailsScreen(
          getFullDataOfproduct: custom,
          strProfileNumber: 'actions',
          getAnotherFullDataToPush: actionClickedData,
        ),
      ),
    );
  }

  Padding actionHaveTwoDataUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                //
                funcActionsManageToDetails(arr_action_list[0]);
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
                          child: Image.network(
                            //
                            arr_action_list[0]['image'].toString(),
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
                        arr_action_list[0]['name'],
                        //
                        Colors.black,
                        16.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: text_bold_style_custom(
                        //
                        '\$${arr_action_list[0]['price']}',
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
          ),
          //
          const SizedBox(
            width: 12.0,
          ),
          //
          Expanded(
            child: GestureDetector(
              onTap: () {
                //
                funcActionsManageToDetails(arr_action_list[1]);
              },
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
                            arr_action_list[1]['image'].toString(),
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
                        arr_action_list[1]['name'],
                        //
                        Colors.black,
                        16.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: text_bold_style_custom(
                        //
                        '\$${arr_action_list[1]['price']}',
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
          ),
          //
        ],
      ),
    );
  }

  Padding actionHaveOneDataUI(i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                //
                funcActionsManageToDetails(arr_action_list[i]);
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
                          child: Image.network(
                            //
                            arr_action_list[i]['image'].toString(),
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
                        'Dishant Rajput',
                        Colors.black,
                        16.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: text_bold_style_custom(
                        //
                        arr_action_list[i]['price'].toString(),
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
          ),
          //

          //
        ],
      ),
    );
    //
  }

  Future<void> push_to_Add_mission(BuildContext context, i) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ShopClickDetailsScreen(getFullData: arrOutGameList[i]),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    if (kDebugMode) {
      print('result =====> ' + result);
    }

    if (!mounted) return;

    business_list_WB();
  }
}
