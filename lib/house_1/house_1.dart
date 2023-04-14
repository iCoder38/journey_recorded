import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

import 'package:flutter_markdown/flutter_markdown.dart';

class House1Screen extends StatefulWidget {
  const House1Screen({super.key});

  @override
  State<House1Screen> createState() => _House1ScreenState();
}

class _House1ScreenState extends State<House1Screen> {
  //
  var style = MarkdownStyleSheet(
    textAlign: WrapAlignment.center,
    h1Align: WrapAlignment.center,
  );
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          navigation_title_house_1,

          ///
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Column(
        children: [
          for (var i = 0; i < 2; i++) ...[
            Container(
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name of item:',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'VIN# 1838849KF833',
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
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.amber,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '2014 dodge ram vin# 174gies829344',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
            ),
            height: 160,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                14.0,
              ),
              color: Colors.red,
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
            child: Column(
              children: <Widget>[
                // Expanded(
                //   child: Container(
                //     margin: const EdgeInsets.only(
                //       top: 20.0,
                //     ),
                //     child: Text(
                //       'ADDRESS OF PROPERTY:',
                //       style: TextStyle(
                //         fontFamily: font_style_name,
                //         fontSize: 18.0,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  // flex: 2,
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(
                      top: 0.0,
                    ),
                    child: Markdown(
                      styleSheet: style,
                      data:
                          '# ADDRESS OF PROPERTY: \n12800 Whitewater Drive, Suite 100 Minnetonka, MN 55343',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
            ),
            height: 160,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                14.0,
              ),
              color: const Color.fromRGBO(
                225,
                225,
                225,
                1,
              ),
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
            child: Column(
              children: <Widget>[
                // Expanded(
                //   child: Container(
                //     margin: const EdgeInsets.only(
                //       top: 20.0,
                //     ),
                //     child: Text(
                //       'ADDRESS OF PROPERTY:',
                //       style: TextStyle(
                //         fontFamily: font_style_name,
                //         fontSize: 18.0,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  // flex: 2,
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Markdown(
                      styleSheet: style,
                      data:
                          '# DETAILED INFORMATION. \nI want to buy this house and keep it for 12 months. Sell it for a profit of 25,000.',
                    ),
                    /*Align(
                      alignment: Alignment.center,
                      child: 
                      Text(
                        ,
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),*/
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
