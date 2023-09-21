// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddRoutineScreen extends StatefulWidget {
  const AddRoutineScreen({super.key, required this.str_professional_id});

  // final String str_professional_id;
  //
  final String str_professional_id;
  //
  @override
  State<AddRoutineScreen> createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  //
  var str_save_continue_loader = '1';
  //
  late final TextEditingController cont_description;
  //
  @override
  void initState() {
    super.initState();
    cont_description = TextEditingController();
  }

  @override
  void dispose() {
    cont_description.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          'Routine',
          Colors.white,
          16.0,
        ),
        backgroundColor: navigation_color,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(
              10.0,
            ),
            child: TextFormField(
              controller: cont_description,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              maxLines: 5,
            ),
          ),
          (str_save_continue_loader == '1')
              ? InkWell(
                  onTap: () {
                    func_create_routine_WB();
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
                      child: Text(
                        'Save and Continue',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : const CircularProgressIndicator()
        ],
      ),
    );
  }

  // add routine
  // create training
  func_create_routine_WB() async {
    str_save_continue_loader = '0';
    setState(() {});
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
          'action': 'addroutine',
          'userId': prefs.getInt('userId').toString(),
          'message': cont_description.text.toString(),
          'profesionalId': widget.str_professional_id.toString(),
          'profesionalType': 'Training'.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);

    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        Navigator.pop(context, 'routine_added');
        //
      } else {
        str_save_continue_loader = '1';
        setState(() {});
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      str_save_continue_loader = '1';
      setState(() {});
    }
  }
}
