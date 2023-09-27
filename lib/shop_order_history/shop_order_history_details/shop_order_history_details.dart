// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:readmore/readmore.dart';

class ShopOrderHistoryDetailsScreen extends StatefulWidget {
  const ShopOrderHistoryDetailsScreen({super.key, this.getFullData});

  final getFullData;

  @override
  State<ShopOrderHistoryDetailsScreen> createState() =>
      _ShopOrderHistoryDetailsScreenState();
}

class _ShopOrderHistoryDetailsScreenState
    extends State<ShopOrderHistoryDetailsScreen> {
  @override
  void initState() {
    if (kDebugMode) {
      print('=================================');
      print('=================================');
      print(widget.getFullData);
      print('=================================');
      print('=================================');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            //
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        backgroundColor: navigation_color,
        title: text_bold_style_custom(
          'Details',
          Colors.white,
          16.0,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //
            const SizedBox(
              height: 20,
            ),
            //
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    150.0,
                  ),
                ),
                child: (widget.getFullData['productImage'].toString() != '')
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                          24.0,
                        ),
                        child: Image.network(
                          widget.getFullData['productImage'].toString(),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/images/logo.png',
                      ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                // height: 200,
                width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                  border: Border.all(
                    width: 0.4,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: text_bold_style_custom(
                          'Name',
                          Colors.black,
                          16.0,
                        ),
                      ),
                      //
                      Align(
                        alignment: Alignment.centerLeft,
                        child: text_regular_style_custom(
                          //
                          widget.getFullData['name'].toString(),
                          Colors.black,
                          14.0,
                        ),
                      ),
                      //
                      const SizedBox(
                        height: 20,
                      ),
                      //
                      Align(
                        alignment: Alignment.centerLeft,
                        child: text_bold_style_custom(
                          'Purchase Date',
                          Colors.black,
                          16.0,
                        ),
                      ),
                      //
                      Align(
                        alignment: Alignment.centerLeft,
                        child: text_regular_style_custom(
                          //
                          widget.getFullData['purchaseDate'].toString(),
                          Colors.black,
                          14.0,
                        ),
                      ),
                      //
                      const SizedBox(
                        height: 20,
                      ),
                      //
                      Align(
                        alignment: Alignment.centerLeft,
                        child: text_bold_style_custom(
                          'Price',
                          Colors.black,
                          16.0,
                        ),
                      ),
                      //
                      Align(
                        alignment: Alignment.centerLeft,
                        child: text_regular_style_custom(
                          //
                          '\$${widget.getFullData['amount']}',
                          Colors.black,
                          14.0,
                        ),
                      ),
                      //
                      const SizedBox(
                        height: 20,
                      ),
                      //
                      Align(
                        alignment: Alignment.centerLeft,
                        child: text_bold_style_custom(
                          'Total Amount',
                          Colors.black,
                          16.0,
                        ),
                      ),
                      //
                      Align(
                        alignment: Alignment.centerLeft,
                        child: text_regular_style_custom(
                          //
                          '\$${widget.getFullData['totalAmount']}',
                          Colors.black,
                          14.0,
                        ),
                      ),
                      //
                      const SizedBox(
                        height: 20,
                      ),
                      //
                      Align(
                        alignment: Alignment.centerLeft,
                        child: text_bold_style_custom(
                          'Description',
                          Colors.black,
                          16.0,
                        ),
                      ),
                      //
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReadMoreText(
                          '${widget.getFullData['description']}',
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
                    ],
                  ),
                ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                // height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                  border: Border.all(
                    width: 0.4,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    text_bold_style_custom(
                      'Shipping Info',
                      Colors.black,
                      16.0,
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          text_bold_style_custom(
                            'Name : ',
                            Colors.black,
                            16.0,
                          ),
                          text_regular_style_custom(
                            //
                            widget.getFullData['ShippingName'].toString(),
                            Colors.black,
                            14.0,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          text_bold_style_custom(
                            'Address : ',
                            Colors.black,
                            16.0,
                          ),
                          text_regular_style_custom(
                            //
                            widget.getFullData['ShippingAddress'].toString(),
                            Colors.black,
                            14.0,
                          ),
                        ],
                      ),
                    ), //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          text_bold_style_custom(
                            'Phone : ',
                            Colors.black,
                            16.0,
                          ),
                          text_regular_style_custom(
                            //
                            widget.getFullData['ShippingPhone'].toString(),
                            Colors.black,
                            14.0,
                          ),
                        ],
                      ),
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          text_bold_style_custom(
                            'Postal Code : ',
                            Colors.black,
                            16.0,
                          ),
                          text_regular_style_custom(
                            //
                            widget.getFullData['ShippingZipcode'].toString(),
                            Colors.black,
                            14.0,
                          ),
                        ],
                      ),
                    ),
                    //

                    //
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
