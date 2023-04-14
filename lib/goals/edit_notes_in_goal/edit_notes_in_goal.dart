// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/edit_notes_in_goal/edit_note_in_goal_modal.dart';

/*
action: addnote
noteId:
userId:
message:
profesionalId:
profesionalType:  // Goal  Mission  Quotes
*/
class EditNotesInGoalScreen extends StatefulWidget {
  const EditNotesInGoalScreen(
      {super.key,
      required this.str_note_id,
      required this.str_message,
      required this.str_professional_id,
      required this.str_professional_type});

  final String str_note_id;

  final String str_message;
  final String str_professional_id;
  final String str_professional_type;

  @override
  State<EditNotesInGoalScreen> createState() => _EditNotesInGoalScreenState();
}

class _EditNotesInGoalScreenState extends State<EditNotesInGoalScreen> {
  //
  EditNoteModal edit_note_service = EditNoteModal();
  //
  TextEditingController cont_edit_note_text = TextEditingController();
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cont_edit_note_text.text = widget.str_message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Note',
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
              controller: cont_edit_note_text,
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
              print('goal => edit note click');

              edit_note_service
                  .edit_note_WB(
                widget.str_note_id.toString(),
                cont_edit_note_text.text.toString(),
                widget.str_professional_id.toString(),
                widget.str_professional_type.toString(),
              )
                  .then((value) {
                print('do something');
                // Navigator.pop(context);
                Navigator.pop(context, 'get_back_from_edit_notes'.toString());
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
                  'Edit Note',
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
