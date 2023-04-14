// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/shop_click_details/create_item/create_item.dart';
import 'package:journey_recorded/task/create_task/create_task.dart';

class ShopClickDetailsScreen extends StatefulWidget {
  const ShopClickDetailsScreen({super.key});

  @override
  State<ShopClickDetailsScreen> createState() => _ShopClickDetailsScreenState();
}

class _ShopClickDetailsScreenState extends State<ShopClickDetailsScreen> {
  //
  var arr_notes = [];
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
            bottom: TabBar(
              indicatorColor: Colors.lime,
              isScrollable: true,
              // labelColor: Colors.amber,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Specials',
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
                    'Services',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Items',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Contact Info',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Employee',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: navigation_color,
            title: Text(
              ///
              navigation_title_nevada_insurance,

              ///
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            /*actions: [
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
            ],*/
          ),
          body: TabBarView(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    header_UI(context),
                    tabbar_SPECIAL_ui(),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    header_UI(context),
                    tabbar_SERVICES_ui(context),

                    const SizedBox(
                      height: 20,
                    ),
                    // arr_demo
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    header_UI(context),
                    tabbar_ITEMS_ui(),

                    const SizedBox(
                      height: 20,
                    ),
                    // arr_demo
                  ],
                ),
              ),
              // tabbar_EMPLOYEE_ui
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    header_UI(context),

                    for (var i = 0; i < arr_contact_info.length; i++) ...[
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        //scrollDirection: Axis.vertical,
                        //shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 10.0,
                                        right: 10.0,
                                      ),
                                      color: Colors.transparent,
                                      // height: 30,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          //
                                          arr_contact_info[i]['title']
                                              .toString(),
                                          //
                                          style: TextStyle(
                                            fontFamily: font_style_name,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          // top: 10.0,
                                          left: 10.0,
                                          right: 10.0,
                                          bottom: 0.0,
                                        ),
                                        color: Colors.transparent,
                                        // height: 30,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            //
                                            arr_contact_info[i]['message']
                                                .toString(),
                                            //
                                            style: TextStyle(
                                              fontFamily: font_style_name,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),
                    ],

                    const SizedBox(
                      height: 20,
                    ),
                    // arr_demo
                  ],
                ),
              ),
              // tabbar_in_games_UI(context),
              // tabbar_OUT_GAMES_ui(context),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    header_UI(context),
                    tabbar_EMPLOYEE_ui(),

                    const SizedBox(
                      height: 20,
                    ),
                    // arr_demo
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column tabbar_SERVICES_ui(BuildContext context) {
    return Column(
      children: <Widget>[
        for (var i = 0; i < custom_dict.length; i++) ...[
          Container(
            // height: 60,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(
              244,
              244,
              244,
              1,
            ),
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      //
                      custom_dict[i]['date'].toString(),
                      //
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (var i = 0; i < arr_demo.length; i++) ...[
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(
                255,
                255,
                255,
                1,
              ),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        //
                        arr_demo[i],
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
        ],
      ],
    );
  }

  Column tabbar_EMPLOYEE_ui() {
    return Column(
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
    );
  }

  Column tabbar_ITEMS_ui() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateItemScreen(),
              ),
            );
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
        ),
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
                    // isThreeLine: true,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  ListView tabbar_SPECIAL_ui() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // scrollDirection: Axis.vertical,
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
                isThreeLine: true,
              ),
            ),
          ),
        );
      },
    );
  }

  Container header_UI(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
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
                            child: Text(
                              'Nevada Insurance',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Phone: #702-772- 7224',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '2nd Phone: #702-772-7224',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
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
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(
                left: 20.0,
              ),
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(
                  250,
                  50,
                  64,
                  1,
                ),
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: Center(
                child: Text(
                  'Rate : 10',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: font_style_name,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
