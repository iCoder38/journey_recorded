// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/mission/add_note_in_mission/add_note_in_mission_modal.dart';

class AddNoteInMission extends StatefulWidget {
  const AddNoteInMission(
      {super.key,
      required this.str_profession_id,
      required this.str_profession_type});

  final String str_profession_id;
  final String str_profession_type;

  @override
  State<AddNoteInMission> createState() => _AddNoteInMissionState();
}

class _AddNoteInMissionState extends State<AddNoteInMission> {
  //
  TextEditingController cont_add_note_text = TextEditingController();
  //
  AddNoteMissionModal add_note_service = AddNoteMissionModal();
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Note 2',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(
            context,
          ),
        ),
        backgroundColor: navigation_color,
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
                hintText: 'Text',
                labelText: 'Text',
              ),
              maxLines: 5,
            ),
          ),
          InkWell(
            onTap: () {
              print('mission => add note click');
              add_note_service
                  .add_note_WB(
                cont_add_note_text.text,
                widget.str_profession_id,
                widget.str_profession_type,
              )
                  .then((value) {
                print('do something');
                // Navigator.pop(context);
                Navigator.pop(context, 'get_back_from_add_notes'.toString());
              });
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
                  '+ Add Note',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
