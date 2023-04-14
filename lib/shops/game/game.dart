// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/shop_click_details/shop_click_details.dart';
import 'package:journey_recorded/shops/shop_item_details/shop_item_details.dart';
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
  var arr_product_list = [];
  //
  @override
  void initState() {
    super.initState();
    product_list_WB();
  }

  // product list
  product_list_WB() async {
    print('=====> POST : SERVICE LIST');

    setState(() {
      str_main_loader = '0';
    });

    //
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //

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
          // 'userId': prefs.getInt('userId').toString(),
          'categoryId': '',
          'forSell': '1',
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
      arr_product_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arr_product_list.add(i);
          //
        }
        if (arr_product_list.isEmpty) {
          setState(() {
            str_main_loader = '1';
          });
        } else {
          setState(() {
            str_main_loader = '2';
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

  // business list
  business_list_WB() async {
    print('=====> POST : BUSINESS LIST');

    setState(() {
      str_main_loader = '0';
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
      arr_product_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arr_product_list.add(i);
          //
        }
        if (arr_product_list.isEmpty) {
          setState(() {
            str_main_loader = '1';
          });
        } else {
          setState(() {
            str_main_loader = '2';
          });
        }
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
                  child: Text(
                    'In Game',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Out Game',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Actions',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),*/
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
                  onTap: () {},
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: TabBarView(
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
      child: Column(
        children: [
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
          //
          for (int i = 0; i < arr_product_list.length; i++) ...[
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopClickDetailsScreen(),
                  ),
                );
              },
              //
              // https://demo4.evirtualservices.net/journey/img/uploads/1674210674image_picker_A2D06B8E-5731-4C64-B8B3-5E0C83B5FF7A-33908-0000007423B30F37.jpg
              //
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                height: 120,
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
                    Container(
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: (arr_product_list[i]['profile_picture']
                                    .toString() ==
                                '')
                            ? Image.asset('assets/images/logo.png')
                            : FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loader.gif',
                                image: arr_product_list[i]['profile_picture']
                                    .toString(),
                              ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 20.0,
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
                                child: Text(
                                  //
                                  arr_product_list[i]['businessName']
                                      .toString(),
                                  //
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: " ",
                                      ),
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.list,
                                          size: 18,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' ${arr_product_list[i]['contactNumber']}',
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
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: " ",
                                      ),
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.list,
                                          size: 14,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${arr_product_list[i]['businessAddress']}',
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
      ),
    );
  }
}
