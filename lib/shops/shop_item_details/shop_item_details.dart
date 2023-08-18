// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class ShopitemDetailsScreen extends StatefulWidget {
  const ShopitemDetailsScreen(
      {super.key, this.getFullDataOfproduct, this.strProfileNumber});

  final strProfileNumber;
  final getFullDataOfproduct;

  @override
  State<ShopitemDetailsScreen> createState() => _ShopitemDetailsScreenState();
}

class _ShopitemDetailsScreenState extends State<ShopitemDetailsScreen> {
  @override
  void initState() {
    if (kDebugMode) {
      print('=====> PRODUCT DETAILS <=====');
      print(widget.strProfileNumber);
      print(widget.getFullDataOfproduct);
      // print(widget.getFullDataOfproduct['image'].toString());
    }

    super.initState();
  }

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
      ),
      body: Column(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      // width: 100,

                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(170, 200, 240, 1),
                        border: Border.all(width: 0.2),
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
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
                              'Buy Now',
                              Colors.black,
                              14.0,
                            ),
                          ],
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
                      ),
                      child: Center(
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
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}
