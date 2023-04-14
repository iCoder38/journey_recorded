// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class EditInventoryScreen extends StatefulWidget {
  const EditInventoryScreen({super.key});

  @override
  State<EditInventoryScreen> createState() => _EditInventoryScreenState();
}

class _EditInventoryScreenState extends State<EditInventoryScreen> {
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
            backgroundColor: navigation_color,
            title: Text(
              ///
              navigation_title_edit_inventory,

              ///
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.lime,
              isScrollable: true,
              // labelColor: Colors.amber,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Edit',
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
                    'Sell',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              tabbar_EDIT_ui(context),

              // tab 2
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 10.0,
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                                color: const Color.fromRGBO(
                                  235,
                                  235,
                                  235,
                                  1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    18.0,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'SALES PRICE',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                                color: const Color.fromRGBO(
                                  235,
                                  235,
                                  235,
                                  1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(
                                    18.0,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'INTEREST',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 0.0,
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                                color: const Color.fromRGBO(
                                  255,
                                  255,
                                  255,
                                  1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                    18.0,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Lost or Gain',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                                color: const Color.fromRGBO(
                                  255,
                                  255,
                                  255,
                                  1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(
                                    18.0,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '\$1.000',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    // height: 40,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Text(
                      'If monthly payment the item will stay in the transferer inventory until fully paid. And will send a duplicate to the buyer.',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView tabbar_EDIT_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            color: Colors.amber,
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  height: 120,
                  width: 120,
                  color: Colors.deepPurple,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    height: 120,
                    width: 120,
                    color: const Color.fromRGBO(
                      240,
                      20,
                      74,
                      1,
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'FINANCE, SOCIAL',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                // flex: 2,
                                child: Center(
                                  child: Text(
                                    '18',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '\$300.',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Text(
                                    'Other',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Text(
                                    '-\$400',
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
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      'PURCHASE \$',
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Impr.',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Text(
                                      'Total',
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Name of item:',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  'VIN# 1838849KF833',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Purchase Date : ',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  'VALUE AT PURCHASE',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 40.0,
          ),
          Card(
            elevation: 50,
            shadowColor: Colors.black,
            color: Colors.greenAccent[100],
            child: SizedBox(
              width: 300,
              // height: 500,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green[500],
                      radius: 108,
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"), //NetworkImage
                        radius: 100,
                      ), //CircleAvatar
                    ), //CircleAvatar
                    const SizedBox(
                      height: 10,
                    ), //SizedBox
                    Text(
                      'GeeksforGeeks',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.green[900],
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ), //Text
                    const SizedBox(
                      height: 10,
                    ), //SizedBox
                    const Text(
                      'GeeksforGeeks is a computer science portal for geeks at geeksforgeeks.org. It contains well written, well thought and well explained computer science and programming articles, quizzes, projects, interview experiences and much more!!GeeksforGeeks is a computer science portal for geeks at geeksforgeeks.org. It contains well written, well thought and well explained computer science and programming articles, quizzes, projects, interview experiences and much more!!GeeksforGeeks is a computer science portal for geeks at geeksforgeeks.org. It contains well written, well thought and well explained computer science and programming articles, quizzes, projects, interview experiences and much more!!GeeksforGeeks is a computer science portal for geeks at geeksforgeeks.org. It contains well written, well thought and well explained computer science and programming articles, quizzes, projects, interview experiences and much more!!',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                      ), //Textstyle
                    ), //Text
                    const SizedBox(
                      height: 10,
                    ), //SizedBox
                  ],
                ), //Column
              ), //Padding
            ), //SizedBox
          ),
          const SizedBox(
            height: 60.0,
          ),
        ],
      ),
    );
  }
}
