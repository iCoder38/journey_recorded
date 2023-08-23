import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:journey_recorded/shop_order_history/shop_order_history_details/shop_order_history_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/drawer.dart';

class ShopOrderHistoryScreen extends StatefulWidget {
  const ShopOrderHistoryScreen({super.key});

  @override
  State<ShopOrderHistoryScreen> createState() => _ShopOrderHistoryScreenState();
}

class _ShopOrderHistoryScreenState extends State<ShopOrderHistoryScreen> {
  //
  var arrOrderHistory = [];
  //
  @override
  void initState() {
    //
    funcGetCartListWB();
    super.initState();
  }

  //
  funcGetCartListWB() async {
    if (kDebugMode) {
      print('=====> POST : GET ORDER HISTORY');
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
          'userId': prefs.getInt('userId').toString(),
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

        for (var i = 0; i < getData['data'].length; i++) {
          arrOrderHistory = getData['data'];
        }
        setState(() {});
        //
        // print(arrCartItemCount);
        // funcGetTotalPrice();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        title: text_bold_style_custom(
          'Order History',
          Colors.white,
          16.0,
        ),
      ),
      drawer: const navigationDrawer(),
      body: Column(
        children: [
          for (int i = 0; i < arrOrderHistory.length; i++) ...[
            GestureDetector(
              onTap: () {
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopOrderHistoryDetailsScreen(
                        getFullData: arrOrderHistory[i]),
                  ),
                );
              },
              child: ListTile(
                title: text_bold_style_custom(
                  //
                  arrOrderHistory[i]['name'].toString(),
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
                          arrOrderHistory[i]['purchaseDate'].toString(),
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
                          '\$${arrOrderHistory[i]['amount']}',
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
                  child: (arrOrderHistory[i]['productImage'].toString() != '')
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                          child: Image.network(
                            arrOrderHistory[i]['productImage'].toString(),
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
            ),
            Container(
              height: 0.4,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
            ),
          ]
        ],
      ),
    );
  }
}
