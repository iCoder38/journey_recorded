// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class AddDescriptionScreen extends StatefulWidget {
  const AddDescriptionScreen(
      {super.key,
      required this.strProfessionalId,
      required this.strProfessionalType});

  final String strProfessionalId;
  final String strProfessionalType;

  @override
  State<AddDescriptionScreen> createState() => _AddDescriptionScreenState();
}

class _AddDescriptionScreenState extends State<AddDescriptionScreen> {
  //
  var loader = '0';
  TextEditingController cont_add_note_text = TextEditingController();
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('==================================');
      print(widget.strProfessionalId);
      print(widget.strProfessionalType);
      print('==================================');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        title: text_bold_style_custom(
          //
          'Description',
          Colors.white,
          16.0,
        ),
        leading: IconButton(
          onPressed: () {
            //
            Navigator.pop(context, 'added_description');
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
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
              controller: cont_add_note_text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'write description...',
                labelText: 'Write Description',
              ),
              maxLines: 5,
            ),
          ),
          GestureDetector(
            onTap: () {
              //
              get_category_list_WB();
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
              child: Center(
                child: (loader == '1')
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : text_regular_style_custom(
                        'Save and Continue',
                        Colors.white,
                        16.0,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //
  //
  get_category_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : add CATEGORY');
    }
    setState(() {
      loader = '1';
    });
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
          'action': 'addnote',
          'userId': prefs.getInt('userId').toString(),
          'message': cont_add_note_text.text.toString(),
          'profesionalId': widget.strProfessionalId.toString(),
          'profesionalType': 'category',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //

        setState(() {
          loader = '0';
        });
        //
        Navigator.pop(context, 'added_description');
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }
  //
}
