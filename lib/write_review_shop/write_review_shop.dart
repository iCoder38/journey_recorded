// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:journey_recorded/custom_files/language_translate_texts/language_translate_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class WriteReviewShopScreen extends StatefulWidget {
  const WriteReviewShopScreen({super.key, required this.ReviewTo});

  final String ReviewTo;

  @override
  State<WriteReviewShopScreen> createState() => _WriteReviewShopScreenState();
}

class _WriteReviewShopScreenState extends State<WriteReviewShopScreen> {
  //
  var str_screen_loader = '0';
  TextEditingController cont_add_mission_text = TextEditingController();
  //
  var str_star_rating = '1';
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
        title: text_bold_style_custom(
          'Write Review',
          Colors.white,
          16.0,
        ),
      ),
      body: Column(
        children: [
          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Row(
                children: [
                  if (str_star_rating == '1') ...[
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '1';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '2';
                          });
                        },
                        icon: const Icon(
                          Icons.star_border,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '3';
                          });
                        },
                        icon: const Icon(
                          Icons.star_border,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '4';
                          });
                        },
                        icon: const Icon(
                          Icons.star_border,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '5';
                          });
                        },
                        icon: const Icon(
                          Icons.star_border,
                        ),
                      ),
                    ),
                  ] else if (str_star_rating == '2') ...[
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '1';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '2';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '3';
                          });
                        },
                        icon: const Icon(
                          Icons.star_border,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '4';
                          });
                        },
                        icon: const Icon(
                          Icons.star_border,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '5';
                          });
                        },
                        icon: const Icon(
                          Icons.star_border,
                        ),
                      ),
                    ),
                  ] else if (str_star_rating == '3') ...[
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '1';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '2';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '3';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '4';
                          });
                        },
                        icon: const Icon(
                          Icons.star_border,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '5';
                          });
                        },
                        icon: const Icon(
                          Icons.star_border,
                        ),
                      ),
                    ),
                  ] else if (str_star_rating == '4') ...[
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '1';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '2';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '3';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '4';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '5';
                          });
                        },
                        icon: const Icon(
                          Icons.star_border,
                        ),
                      ),
                    ),
                  ] else if (str_star_rating == '5') ...[
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '1';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '2';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '3';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '4';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            str_star_rating = '5';
                          });
                        },
                        icon: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 20.0,
            ),
            // height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: TextFormField(
              controller: cont_add_mission_text,
              decoration: const InputDecoration(
                // border: OutlineInputBorder(),
                hintText: 'Text',
                labelText: 'Text',
              ),
              maxLines: 5,
            ),
          ),
          //
          GestureDetector(
            onTap: () {
              //
              funcValidationBeforeSendingReview();
            },
            child: Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                color: const Color.fromRGBO(
                  250,
                  42,
                  18,
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
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: (str_screen_loader == '1')
                  ? const Center(
                      child: SizedBox(
                        height: 40.0,
                        width: 40.0,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Center(
                      child: text_bold_style_custom(
                        'Send Review',
                        Colors.white,
                        14.0,
                      ),
                    ),
            ),
          )
          //
        ],
      ),
    );
  }

  funcValidationBeforeSendingReview() {
    //  str_star_rating
    if (str_star_rating == '5') {
      sendReviewWB();
    } else {
      // error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          closeIconColor: Colors.amber,
          content: text_regular_style_custom(
            'Please write some review',
            Colors.white,
            14.0,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //
  // NOTES
  Future sendReviewWB() async {
    if (kDebugMode) {
      print('=====> POST : SEND REVIEW');
    }

    setState(() {
      str_screen_loader = '1';
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
          'action': 'submitreview',
          'reviewTo': widget.ReviewTo.toString(),
          'reviewFrom': prefs.getInt('userId').toString(),
          'star': str_star_rating.toString(),
          'message': cont_add_mission_text.text.toString(),
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
      setState(() {
        str_screen_loader = '0';
      });
      Navigator.pop(context);
      Navigator.pop(context, 'submit_review');
    } else {
      // return postList;
    }
  }
  //
}
