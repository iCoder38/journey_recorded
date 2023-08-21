// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:badges/badges.dart' as badges;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/shops/cart_list/cart_list.dart';
import 'package:journey_recorded/shops/payment_list/buy_now_payment_screen.dart';

import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopitemDetailsScreen extends StatefulWidget {
  const ShopitemDetailsScreen(
      {super.key, this.getFullDataOfproduct, this.strProfileNumber});

  final strProfileNumber;
  final getFullDataOfproduct;

  @override
  State<ShopitemDetailsScreen> createState() => _ShopitemDetailsScreenState();
}

class _ShopitemDetailsScreenState extends State<ShopitemDetailsScreen> {
  //
  var strQuantityCounter = 1;
  var strTotalPriceIs = '';
  var strCartCount = '0';
  var strCartLoader = '0';
  var strAddToCartLoader = '1';
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('=====> PRODUCT DETAILS <=====');
      print(widget.strProfileNumber);
      print(widget.getFullDataOfproduct);
      // print(widget.getFullDataOfproduct['image'].toString());
    }
    //
    strTotalPriceIs = '${widget.getFullDataOfproduct['salePrice']}';

    //
    funcGetCartListWB();
    super.initState();
  }

  funcAddOneQuantity() {
    strQuantityCounter += 1;

    funcCalculateTotalPrice();
  }

  funcMinusOneQuantity() {
    if (strQuantityCounter != 1) {
      strQuantityCounter -= 1;

      funcCalculateTotalPrice();
    }
  }

  funcCalculateTotalPrice() {
    if (kDebugMode) {
      print('total price ===> $strTotalPriceIs');
    }
    //
    var calculate = double.parse(strQuantityCounter.toString()) *
        double.parse('${widget.getFullDataOfproduct['salePrice']}');
    if (kDebugMode) {
      print(calculate);
    }
    //
    strTotalPriceIs = calculate.toString();
    //
    setState(() {
      if (kDebugMode) {
        // print(strQuantityCounter);
      }
      //
    });
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
      print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        //
        var strCartItemCount = [];
        for (var i = 0; i < getData['data'].length; i++) {
          strCartItemCount.add(getData['data']);
        }
        //
        strCartCount = strCartItemCount.length.toString();
        setState(() {
          strCartLoader = '1';
          strAddToCartLoader = '1';
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
  funcAddToCartListWB() async {
    if (kDebugMode) {
      print('=====> POST : ADD TO CART');
    }
    setState(() {
      strAddToCartLoader = '0';
    });

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
          'action': 'addcart',
          'userId': prefs.getInt('userId').toString(),
          'productId': widget.getFullDataOfproduct['productId'].toString(),
          'quantity': strQuantityCounter.toString(),
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
        strCartCount = getData['totalCartItem'].toString();
        //
        funcGetCartListWB();
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
        title: text_bold_style_custom(
          //
          'Product Details',
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
        actions: [
          (strCartLoader == '0')
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.circle,
                      badgeColor: Colors.blue,
                      padding: const EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(1),
                      borderSide: const BorderSide(
                        color: Colors.pinkAccent,
                        width: 2,
                      ),
                      elevation: 0,
                    ),
                    badgeContent: text_regular_style_custom(
                      //,
                      strCartCount.toString(),
                      Colors.white,
                      10.0,
                    ),
                    onTap: () {
                      //
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShopCartListScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //

            if (widget.strProfileNumber == '2') ...[
              // product
              Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    0,
                  ),
                  child: Image.network(
                    //
                    widget.getFullDataOfproduct['image_1'].toString(),
                    fit: BoxFit.contain,
                    //
                  ),
                ),
              ),
              //
              text_bold_style_custom(
                //
                widget.getFullDataOfproduct['name'].toString(),
                Colors.black,
                20.0,
              ),
              //
              const SizedBox(
                height: 20,
              ),
              text_regular_style_custom(
                //
                'Price : \$${widget.getFullDataOfproduct['salePrice']}',
                Colors.black,
                16.0,
              ),
              //
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      //
                      funcMinusOneQuantity();
                    },
                    icon: const Icon(
                      Icons.remove,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  text_regular_style_custom(
                    //
                    strQuantityCounter,
                    //
                    Colors.black,
                    16.0,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      //
                      funcAddOneQuantity();
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BuyNowPaymentScreen(
                                strProductId: widget
                                    .getFullDataOfproduct['productId']
                                    .toString(),
                                strTotalPrice: strTotalPriceIs,
                                strProductName: widget
                                    .getFullDataOfproduct['name']
                                    .toString(),
                                strProductQuantity:
                                    strQuantityCounter.toString(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 60,
                          // width: 100,

                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(170, 200, 240, 1),
                            border: Border.all(width: 0.2),
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 6.0,
                              )
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.credit_card),
                                const SizedBox(
                                  width: 10,
                                ),
                                text_bold_style_custom(
                                  'Buy Now \$$strTotalPriceIs',
                                  Colors.black,
                                  14.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: 60,
                        // width: 100,
                        decoration: BoxDecoration(
                          color: Colors.orange[300],
                          border: Border.all(width: 0.2),
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 6.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: (strAddToCartLoader == '0')
                              ? SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                      color: navigation_color),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    //
                                    funcAddToCartListWB();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.add_shopping_cart),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      text_bold_style_custom(
                                        'Add To Cart',
                                        Colors.black,
                                        14.0,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )
            ],
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: ReadMoreText(
                '${widget.getFullDataOfproduct['description']}',
                trimLines: 6,
                colorClickableText: Colors.pink,
                style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: '...Show less',
                lessStyle: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                moreStyle: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            //
            const SizedBox(
              width: 40,
            ),
          ],
        ),
      ),
    );
  }
}
