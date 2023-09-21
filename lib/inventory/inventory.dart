// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/inventory/add_item_delivery/add_item_delivery.dart';
import 'package:journey_recorded/inventory/edit_inventory/edit_inventory.dart';
import 'package:journey_recorded/inventory/inventory_tabs_ui/inventory_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  //
  var strInventoryLoader = '';
  var arrInventory = [];
  var strUserSelectProfileStatus = '1';
  //
  var arr_inventory_header = [
    {'name': 'ASSETS'},
    {'name': 'LIABILITIES'},
    {'name': 'OTHER'},
  ];
  var arr_inventory_sub_tiles = [
    {'name': '2014 dodge ram'},
    {'name': 'Rent house 1'},
    {'name': 'Job'},
  ];
  //
  //

//
  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      print('========================');
    }
    //
    funcInventoryWB(
      '1',
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  funcInventoryWB(
    strType,
  ) async {
    if (kDebugMode) {
      print('=====> POST : INVENTORY LIST TYPE ==> $strType');
    }

    setState(() {
      strInventoryLoader = '0';
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
          'action': 'businessproductlist',
          'userId': prefs.getInt('userId').toString(),
          'type': strType.toString(),
          'pageNo': '1'
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(get_data);
    }
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arrInventory.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          arrInventory.add(i);
        }
        if (arrInventory.isEmpty) {
          setState(() {
            strInventoryLoader = '2';
          });
        } else {
          setState(() {
            strInventoryLoader = '1';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          'Inventory',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          pushToAddItem(context);
        },
        backgroundColor: navigation_color,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            tabUI(),
            //
            if (strInventoryLoader == '0') ...[
              const Center(
                child: CircularProgressIndicator(),
              )
            ] else if (strInventoryLoader == '2') ...[
              //
              const SizedBox(
                height: 200.0,
              ),

              //
              text_bold_style_custom(
                'No data found',
                Colors.black,
                16.0,
              ),
              //
            ] else ...[
              for (int i = 0; i < arrInventory.length; i++) ...[
                // assets ui
                GestureDetector(
                  onTap: () {
                    //
                    pushToEditItem(
                      context,
                      arrInventory[i],
                    );
                  },
                  child: ListTile(
                    title: text_bold_style_custom(
                      //
                      arrInventory[i]['name'].toString(),
                      Colors.black,
                      16.0,
                    ),
                    subtitle: text_regular_style_custom(
                      //
                      arrInventory[i]['purchaseDate'].toString(),
                      Colors.black,
                      10.0,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
              ]
            ],
          ],
        ),
      ),
    );
  }

  Container tabUI() {
    return Container(
      color: Colors.blue[900],
      child: Row(
        children: [
          //
          Expanded(
            child: GestureDetector(
              onTap: () {
                //
                arrInventory.clear();
                setState(() {
                  strUserSelectProfileStatus = '1';
                }); //
                funcInventoryWB(
                  '1',
                );
              },
              child: (strUserSelectProfileStatus == '1')
                  ? Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.pink,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: text_bold_style_custom(
                          'Assets',
                          Colors.white,
                          18.0,
                        ),
                      ),
                    )
                  : Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Center(
                        child: text_regular_style_custom(
                          'Assets',
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
          Expanded(
            child: GestureDetector(
              onTap: () {
                //
                arrInventory.clear();
                setState(() {
                  strUserSelectProfileStatus = '2';
                });
                //
                funcInventoryWB(
                  '2',
                );
              },
              child: (strUserSelectProfileStatus == '2')
                  ? Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.pink,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: text_bold_style_custom(
                          'Liabilities',
                          Colors.white,
                          18.0,
                        ),
                      ),
                    )
                  : Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Center(
                        child: text_regular_style_custom(
                          'Liabilities',
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
          Expanded(
            child: GestureDetector(
              onTap: () {
                //
                arrInventory.clear();
                setState(() {
                  strUserSelectProfileStatus = '3';
                });
                //
                funcInventoryWB(
                  '3',
                );
              },
              child: (strUserSelectProfileStatus == '3')
                  ? Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.pink,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: text_bold_style_custom(
                          'Other',
                          Colors.white,
                          18.0,
                        ),
                      ),
                    )
                  : Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Center(
                        child: text_regular_style_custom(
                          'Other',
                          Colors.white,
                          14.0,
                        ),
                      ),
                    ),
            ),
          ),
          //
        ],
      ),
    );
  }

  Column category_finance_UI(BuildContext context) {
    return Column(
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
                        'Category',
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
                        'Finance',
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
                          0.0,
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
                          0.0,
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
                        'Finance',
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
                        'Monthly',
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
      ],
    );
  }

// push = add item
  Future<void> pushToAddItem(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddItemDeliveryScreen(),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

    if (!mounted) return;

    if (result == '1') {
      strUserSelectProfileStatus = '1';
      funcInventoryWB(
        '1',
      );
    }
  }

  // push = edit item
  Future<void> pushToEditItem(BuildContext context, fulldata) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditInventoryScreen(
          dictGetInventoryDetails: fulldata,
        ),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

    if (!mounted) return;

    if (result == '1') {
      strUserSelectProfileStatus = '1';
      funcInventoryWB(
        '1',
      );
    }
  }
}
