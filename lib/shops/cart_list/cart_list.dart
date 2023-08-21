import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/shops/payment_list/buy_cart_products.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopCartListScreen extends StatefulWidget {
  const ShopCartListScreen({super.key});

  @override
  State<ShopCartListScreen> createState() => _ShopCartListScreenState();
}

class _ShopCartListScreenState extends State<ShopCartListScreen> {
  //
  var strSummSalePrice = 0.0;
  var arrCartItemCount = [];
  var strTotalPrice = '';
  //
  @override
  void initState() {
    //
    funcGetCartListWB();
    super.initState();
  }

  funcGetCartListWB() async {
    if (kDebugMode) {
      print('=====> POST : GET CART');
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
          'action': 'getcarts',
          'userId': prefs.getInt('userId').toString(),
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      // print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        //

        for (var i = 0; i < getData['data'].length; i++) {
          arrCartItemCount = getData['data'];
        }
        //
        // print(arrCartItemCount);
        funcGetTotalPrice();
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

  funcGetTotalPrice() {
    //
    if (kDebugMode) {
      // print(arrCartItemCount);
    }
    //

    for (int i = 0; i < arrCartItemCount.length; i++) {
      //
      strSummSalePrice =
          (double.parse(arrCartItemCount[i]['salePrice'].toString()) *
                  double.parse(arrCartItemCount[i]['quantity'].toString())) +
              strSummSalePrice;
    }
    //
    if (kDebugMode) {
      print(strSummSalePrice);
    }
    setState(() {});
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          'Cart List',
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
      body: Stack(
        children: [
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: arrCartItemCount.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    14.0,
                  ),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.network(
                      arrCartItemCount[index]['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                trailing: text_bold_style_custom(
                  //
                  '\$${arrCartItemCount[index]['salePrice']} x ${arrCartItemCount[index]['quantity'].toString()} ',
                  Colors.green,
                  14.0,
                ),
                title: text_regular_style_custom(
                  //
                  '${arrCartItemCount[index]['productName']} ( ${arrCartItemCount[index]['quantity'].toString()} )',
                  Colors.black,
                  14.0,
                ),
              );
            },
          ),
          //
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                //
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (strSummSalePrice == 0.0)
                        ? text_regular_style_custom(
                            'calculating...',
                            Colors.black,
                            14.0,
                          )
                        : GestureDetector(
                            onTap: () {
                              //
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuyCartProductsScreen(
                                    strTotalPrice: strSummSalePrice.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 100,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: text_bold_style_custom(
                                      'Checkout ',
                                      Colors.black,
                                      20.0,
                                    ),
                                  ),
                                  text_regular_style_custom(
                                    '\$$strSummSalePrice',
                                    Colors.black,
                                    14.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
