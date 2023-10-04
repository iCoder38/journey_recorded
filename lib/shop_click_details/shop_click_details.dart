// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/shop_click_details/create_item/create_item.dart';
import 'package:journey_recorded/task/create_task/create_task.dart';

class ShopClickDetailsScreen extends StatefulWidget {
  const ShopClickDetailsScreen({super.key, this.getFullData});

  final getFullData;

  @override
  State<ShopClickDetailsScreen> createState() => _ShopClickDetailsScreenState();
}

class _ShopClickDetailsScreenState extends State<ShopClickDetailsScreen> {
  //
  var strSpecialClick = '0';
  var strServiceClick = '0';
  var strItemsClick = '0';
  var strContactInfoClick = '0';
  var strEmplyeeClick = '0';
  var strReviewClick = '0';
  //
  var dictProfileData;
  //
  var strLoader = '0';
  var arr_notes = [];
  //
  var arrOutGame = [];
  //
  var custom_dict = [
    {
      'date': '5-December-2022',
    },
    {
      'date': '6-December-2022',
    },
    {
      'date': '7-December-2022',
    },
  ];
  var arr_demo = ['qwerty', 'qwerty', 'qwerty'];
  //

  var arr_contact_info = [
    {
      'title': 'Phone',
      'message': '(948) 948-9485',
    },
    {
      'title': 'Fax',
      'message': '(384)839-8392',
    },
    {
      'title': 'Email',
      'message': 'Nevadains@gmai.Com',
    },
    {
      'title': 'Website',
      'message': 'www.Nevadainsurance.Com',
    },
    {
      'title': 'Location 1',
      'message': '(948) 948-94853847 s maryland pkwy ste 8 las vegas nv, 89283',
    },
    {
      'title': 'Location 2',
      'message': '(948) 994-17331717 N 14th street # 17 Las Vegas NV 89170',
    },
  ];
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('=================');
      print('=================');
      print(widget.getFullData);
      print('=================');
      print('=================');
    }
    funcSpecialListWB('Special');
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
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: navigation_color,
            title: text_bold_style_custom(
              'Business',
              Colors.white,
              16.0,
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                //
                header_UI(context),
                //
                tabsUI(context),
                //
                if (strSpecialClick == '1') ...[
                  //

                  (strLoader == '0')
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        )
                      : tabbar_SPECIAL_ui(),
                ] else if (strServiceClick == '1') ...[
                  //
                  (strLoader == '0')
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        )
                      : tabbar_SERVICES_ui(context),
                ] else if (strItemsClick == '1') ...[
                  //
                  if (arrOutGame.isEmpty)
                    ...[]
                  else ...[
                    tabbar_CONTACT_INFO_ui(),
                  ],

                  //
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    height: 0.2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  //
                ] else if (strContactInfoClick == '1') ...[
                  //
                  //
                  tabbar_all_contact_info_ui(context),
                ] else if (strReviewClick == '1') ...[
                  //
                  //
                  for (int i = 0; i < arrOutGame.length; i++) ...[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(
                                  30.0,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  30.0,
                                ),
                                child: Image.network(
                                  arrOutGame[i]['profile_picture'].toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            trailing: text_regular_style_custom(
                              //
                              arrOutGame[i]['created'].toString(),
                              Colors.black,
                              10.0,
                            ),
                            title: text_bold_style_custom(
                              //
                              arrOutGame[i]['userName'].toString(),
                              Colors.black,
                              16.0,
                            ),
                            subtitle: Row(
                              children: [
                                if (arrOutGame[i]['star'].toString() ==
                                    '0') ...[
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                ] else if (arrOutGame[i]['star'].toString() ==
                                    '2') ...[
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                ] else if (arrOutGame[i]['star'].toString() ==
                                    '3') ...[
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                ] else if (arrOutGame[i]['star'].toString() ==
                                    '4') ...[
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                ] else if (arrOutGame[i]['star'].toString() ==
                                    '5') ...[
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16.0,
                                  ),
                                  //

                                  //
                                ]
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                ] else if (strEmplyeeClick == '1') ...[
                  //

                  (strLoader == '0')
                      ? const Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: CircularProgressIndicator(
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              for (var j = 0; j < arrOutGame.length; j++) ...[
                                ListTile(
                                  leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                    ),
                                  ),
                                  title: text_bold_style_custom(
                                    //
                                    arrOutGame[j]['From_userName'],
                                    Colors.black,
                                    14.0,
                                  ),
                                  subtitle: text_regular_style_custom(
                                    //
                                    arrOutGame[j]['From_userAddress'],
                                    Colors.black,
                                    12.0,
                                  ),
                                ),
                              ]
                            ],
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

  Padding tabbar_all_contact_info_ui(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 100,
        width: MediaQuery.of(context).size.width,

        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.2,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text_bold_style_custom(
                    'Phone : ',
                    Colors.black,
                    14.0,
                  ),
                  (dictProfileData == null)
                      ? text_regular_style_custom(
                          'please wait...',
                          Colors.black,
                          12.0,
                        )
                      : text_regular_style_custom(
                          //
                          dictProfileData['businessPhone'].toString(),
                          Colors.black,
                          12.0,
                        ),
                ],
              ),
            ),
            //
            Container(
              height: 0.2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text_bold_style_custom(
                    'FAX : ',
                    Colors.black,
                    14.0,
                  ),
                  (dictProfileData == null)
                      ? text_regular_style_custom(
                          'please wait...',
                          Colors.black,
                          12.0,
                        )
                      : text_regular_style_custom(
                          //
                          dictProfileData['businessFax'].toString(),
                          Colors.black,
                          12.0,
                        ),
                ],
              ),
            ),
            //
            Container(
              height: 0.2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text_bold_style_custom(
                    'E-mail Address : ',
                    Colors.black,
                    14.0,
                  ),
                  (dictProfileData == null)
                      ? text_regular_style_custom(
                          'please wait...',
                          Colors.black,
                          12.0,
                        )
                      : text_regular_style_custom(
                          //
                          dictProfileData['businessEmail'].toString(),
                          Colors.black,
                          12.0,
                        ),
                ],
              ),
            ),
            //
            Container(
              height: 0.2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text_bold_style_custom(
                    'Web Address : ',
                    Colors.black,
                    14.0,
                  ),
                  (dictProfileData == null)
                      ? text_regular_style_custom(
                          'please wait...',
                          Colors.black,
                          12.0,
                        )
                      : text_regular_style_custom(
                          //
                          dictProfileData['businessWebSite'].toString(),
                          Colors.black,
                          12.0,
                        ),
                ],
              ),
            ),
            //
            Container(
              height: 0.2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text_bold_style_custom(
                    'Address : ',
                    Colors.black,
                    14.0,
                  ),
                  (dictProfileData == null)
                      ? text_regular_style_custom(
                          'please wait...',
                          Colors.black,
                          12.0,
                        )
                      : text_regular_style_custom(
                          //
                          dictProfileData['businessAddress'].toString(),
                          Colors.black,
                          12.0,
                        ),
                ],
              ),
            ),
            //
          ],
        ),
      ),
    );
  }

  Column tabbar_CONTACT_INFO_ui() {
    return Column(
      children: [
        for (var j = 0; j < arrOutGame.length; j++) ...[
          ListTile(
            leading: (arrOutGame[j]['image_1'] == '')
                ? SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  )
                : SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.network(
                      arrOutGame[j]['image_1'],
                      fit: BoxFit.cover,
                    ),
                  ),
            title: text_regular_style_custom(
              //
              arrOutGame[j]['name'],
              Colors.black,
              14.0,
            ),
            trailing: Container(
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(
                  250,
                  0,
                  60,
                  1,
                ),
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
              child: Center(
                child: text_bold_style_custom(
                  //
                  '\$ ${arrOutGame[j]['salePrice']}',
                  Colors.white,
                  14.0,
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }

  Container tabsUI(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: const Color.fromRGBO(
        250,
        0,
        60,
        1,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            /************************************/
            /************************************/
            GestureDetector(
              onTap: () {
                //
                setState(() {
                  strSpecialClick = '1';
                  strServiceClick = '0';
                  strItemsClick = '0';
                  strContactInfoClick = '0';
                  strEmplyeeClick = '0';
                  strReviewClick = '0';
                });
                //
                funcSpecialListWB('Special');
              },
              child: Container(
                height: 60,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: (strSpecialClick == '0')
                        ? text_regular_style_custom(
                            'Special',
                            Colors.white,
                            16.0,
                          )
                        : text_bold_style_custom(
                            'Special',
                            Colors.white,
                            18.0,
                          ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              height: 60,
              width: 0.6,
              color: Colors.white,
            ),
            /************************************/
            /************************************/
            GestureDetector(
              onTap: () {
                //
                setState(() {
                  strServiceClick = '1';
                  strSpecialClick = '0';
                  strReviewClick = '0';
                  strItemsClick = '0';
                  strContactInfoClick = '0';
                  strEmplyeeClick = '0';
                });
                //
                funcSpecialListWB('Service');
              },
              child: Container(
                height: 60,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: (strServiceClick == '0')
                        ? text_regular_style_custom(
                            'Service',
                            Colors.white,
                            16.0,
                          )
                        : text_bold_style_custom(
                            'Service',
                            Colors.white,
                            18.0,
                          ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              height: 60,
              width: 0.6,
              color: Colors.white,
            ),
            /************************************/
            /************************************/
            GestureDetector(
              onTap: () {
                //
                setState(() {
                  strItemsClick = '1';
                  strSpecialClick = '0';
                  strServiceClick = '0';
                  strReviewClick = '0';
                  strContactInfoClick = '0';
                  strEmplyeeClick = '0';
                });
                //
                funcBusinessProductListWB();
              },
              child: Container(
                height: 60,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: (strItemsClick == '0')
                        ? text_regular_style_custom(
                            'Items',
                            Colors.white,
                            16.0,
                          )
                        : text_bold_style_custom(
                            'Items',
                            Colors.white,
                            18.0,
                          ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              height: 60,
              width: 0.6,
              color: Colors.white,
            ),
            /************************************/
            /************************************/
            GestureDetector(
              onTap: () {
                //
                setState(() {
                  strContactInfoClick = '1';
                  strSpecialClick = '0';
                  strServiceClick = '0';
                  strItemsClick = '0';
                  strReviewClick = '0';
                  strEmplyeeClick = '0';
                });
                //
                funcProfileWB();
              },
              child: Container(
                height: 60,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: (strContactInfoClick == '0')
                        ? text_regular_style_custom(
                            'Contact Info',
                            Colors.white,
                            16.0,
                          )
                        : text_bold_style_custom(
                            'Contact Info',
                            Colors.white,
                            18.0,
                          ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              height: 60,
              width: 0.6,
              color: Colors.white,
            ),
            /************************************/
            /************************************/
            GestureDetector(
              onTap: () {
                //
                setState(() {
                  strSpecialClick = '0';
                  strServiceClick = '0';
                  strItemsClick = '0';
                  strContactInfoClick = '0';
                  strEmplyeeClick = '1';
                  strReviewClick = '0';
                });
                //
                funcEmployeeWB();
              },
              child: Container(
                height: 60,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: (strEmplyeeClick == '0')
                        ? text_regular_style_custom(
                            'Employee',
                            Colors.white,
                            16.0,
                          )
                        : text_bold_style_custom(
                            'Employee',
                            Colors.white,
                            18.0,
                          ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              height: 60,
              width: 0.6,
              color: Colors.white,
            ),
            /************************************/
            /************************************/
            GestureDetector(
              onTap: () {
                //
                setState(() {
                  strSpecialClick = '0';
                  strServiceClick = '0';
                  strItemsClick = '0';
                  strContactInfoClick = '0';
                  strEmplyeeClick = '0';
                  strReviewClick = '1';
                });
                //
                reviewListWB();
              },
              child: Container(
                height: 60,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: (strReviewClick == '0')
                        ? text_regular_style_custom(
                            'Reviews',
                            Colors.white,
                            16.0,
                          )
                        : text_bold_style_custom(
                            'Reviews',
                            Colors.white,
                            18.0,
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

  SingleChildScrollView tabbar_SERVICES_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          for (var i = 0; i < arrOutGame.length; i++) ...[
            ExpansionTile(
              title: text_bold_style_custom(
                //
                arrOutGame[i]['name'],
                Colors.black,
                16.0,
              ),
              subtitle: text_regular_style_custom(
                //
                'Service type : ${arrOutGame[i]['serviceType']}',
                Colors.black,
                14.0,
              ),
              children: <Widget>[
                for (var j = 0;
                    j < arrOutGame[i]['subServices'].length;
                    j++) ...[
                  ListTile(
                    title: text_regular_style_custom(
                      //
                      arrOutGame[i]['subServices'][j]['name'],
                      Colors.black,
                      14.0,
                    ),
                    trailing: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          250,
                          0,
                          60,
                          1,
                        ),
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      child: Center(
                        child: text_bold_style_custom(
                          //
                          '\$ ${arrOutGame[i]['subServices'][j]['price']}',
                          Colors.white,
                          14.0,
                        ),
                      ),
                    ),
                  ),
                  //
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    height: 0.2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  //
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  SingleChildScrollView tabbar_EMPLOYEE_ui() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // scrollDirection: Axis.vertical,
            //shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 0.0,
                  ),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Card(
                    child: ListTile(
                      leading: const FlutterLogo(size: 72.0),
                      title: Text(
                        '2017 Doge Ram',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      /*subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.',
                      ),*/
                      trailing: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                            250,
                            0,
                            60,
                            1,
                          ),
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '\$500',
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      subtitle: Text(
                        'Skills: English, Teaching...',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // isThreeLine: true,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /*Column tabbar_ITEMS_ui() {
    return Column(
      children: [
        /*InkWell(
          onTap: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateItemScreen(),
              ),
            );*/
          },
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.amber,
            child: Center(
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  children: [
                    const TextSpan(
                      text: ' ',
                    ),
                    const WidgetSpan(
                      child: Icon(
                        Icons.add,
                        size: 18.0,
                      ),
                    ),
                    TextSpan(
                      text: ' Create item',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),*/
        /*ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          // scrollDirection: Axis.vertical,
          //shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 0.0,
                ),
                height: 80,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Card(
                  child: ListTile(
                    leading: const FlutterLogo(size: 72.0),
                    title: Text(
                      '2017 Doge Ram',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    /*subtitle: const Text(
                      'A sufficiently long subtitle warrants three lines.',
                    ),*/
                    trailing: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          250,
                          0,
                          60,
                          1,
                        ),
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '\$500',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // isThreeLine: true,
                  ),
                ),
              ),
            );
          },
        ),*/
      ],
    );
  }*/

  ListView tabbar_SPECIAL_ui() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // scrollDirection: Axis.vertical,
      //shrinkWrap: true,
      itemCount: arrOutGame.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            //
          },
          child: ListTile(
            leading: (arrOutGame[index]['image'] == '')
                ? SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  )
                : SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.network(
                      arrOutGame[index]['image'],
                    ),
                  ),
            title: text_bold_style_custom(
              //
              arrOutGame[index]['name'],
              Colors.black,
              16.0,
            ),
            subtitle: text_regular_style_custom(
              //
              'Service type : ${arrOutGame[index]['serviceType']}',
              Colors.black,
              12.0,
            ),
            trailing: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(
                  250,
                  0,
                  60,
                  1,
                ),
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
              child: Center(
                child: text_bold_style_custom(
                  //
                  '\$ ${arrOutGame[index]['price']}',
                  Colors.white,
                  14.0,
                ),
              ),
            ),
            // isThreeLine: true,
          ),
        );
      },
    );
  }

  Container header_UI(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 220,
      color: Colors.black,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  height: 120,
                  color: Colors.transparent,
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: text_bold_style_custom(
                              //
                              widget.getFullData['fullName'].toString(),
                              Colors.white,
                              18.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: text_regular_style_custom(
                              //
                              'Phone : ${widget.getFullData['contactNumber']}',
                              Colors.orange,
                              14.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: text_regular_style_custom(
                              //
                              'E-mail Address : ${widget.getFullData['businessEmail']}',
                              Colors.orange,
                              14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*Container(
                margin: const EdgeInsets.only(
                  right: 20.0,
                  top: 20.0,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: app_yellow_color,
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.badge,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: app_yellow_color,
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.badge,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: app_yellow_color,
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.badge,
                      ),
                    ),
                  ],
                ),
              )*/
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(
                left: 20.0,
              ),
              width: 120,
              height: 30,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(
                  250,
                  50,
                  64,
                  1,
                ),
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              child: Center(
                child: text_bold_style_custom(
                  //
                  'Rate : ${widget.getFullData['AVGRating'].toString()}',
                  Colors.white,
                  14.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  //
  // action list
  funcSpecialListWB(serviceType) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print('POST ====> $serviceType');
    }

    setState(() {
      strLoader = '0';
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
          'action': 'speciallist',
          'userId': widget.getFullData['userId']
              .toString(), // prefs.getInt('userId').toString(),
          'serviceType': serviceType.toString(),
          'pageNo': '1'
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
      arrOutGame.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arrOutGame.add(i);
          //
        }
        setState(() {
          strLoader = '1';
        });
        //
        // Navigator.pop(context);
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
  // action list
  funcBusinessProductListWB() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print('POST ====> ITEM LIST');
    }

    setState(() {
      strLoader = '0';
    });

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'action': 'businessproductlist',
          'userId': widget.getFullData['userId'].toString(),
          'forSell': '1'.toString(),
          'pageNo': '1'.toString()
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
      arrOutGame.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arrOutGame.add(i);
          //
        }
        setState(() {
          strLoader = '1';
        });
        //
        // Navigator.pop(context);
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
  // action list
  funcProfileWB() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print('POST ====> PROFILE');
    }

    // setState(() {
    //   strLoader = '0';
    // });

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'profile',
          'userId': widget.getFullData['userId'].toString(),
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
      // arrOutGame.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        /*for (Map i in get_data['data']) {
          //
          arrOutGame.add(i);
          //
        }*/
        //
        dictProfileData = get_data['data'];
        setState(() {
          strLoader = '1';
        });
        //
        // Navigator.pop(context);
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
  // action list
  funcEmployeeWB() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print('POST ====> EMPLOYEE');
    }

    setState(() {
      strLoader = '0';
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
          'action': 'invitelist',
          'userId': widget.getFullData['userId'].toString(),
          'status': '1'
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
      arrOutGame.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arrOutGame.add(i);
          //
        }
        //

        setState(() {
          strLoader = '1';
        });
        //
        // Navigator.pop(context);
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
  // action list
  reviewListWB() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print('POST ====> REVIEWS');
    }

    setState(() {
      strLoader = '0';
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
          'action': 'reviewlist',
          'userId': widget.getFullData['userId'].toString(),
          'pageNo': '1'
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
      arrOutGame.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arrOutGame.add(i);
          //
        }
        //

        setState(() {
          strLoader = '1';
        });
        //
        // Navigator.pop(context);
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
