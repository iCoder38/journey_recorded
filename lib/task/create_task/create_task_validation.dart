// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/task/create_task/create_task_modal.dart';

class CreateTaskValidation {
  func_create_task_validation(
    String str_task_name,
    String str_due_date,
    String str_rewards,
    String str_deduct_rewards,
    String str_skills,
    String str_request,
    String str_add_reminder_date,
    String str_add_reminder_time,
    String str_add_reminder_warning,
    String str_task_details,
    String profesionalId,
    String profesionalType,
    // new
    String rewardType,
    String groupidMain,
    String groupidSub,
    BuildContext context,
  ) {
    if (str_task_name == '') {
      //
      _showMyDialog('Task name', context);
      //
    } else if (str_due_date == '') {
      //
      _showMyDialog('Due date', context);
      //
    } else if (str_rewards == '') {
      //
      _showMyDialog('Rewards', context);
      //
    } else if (str_deduct_rewards == '') {
      //
      _showMyDialog('Deduct rewards', context);
      //
    } else if (str_skills == '') {
      //
      _showMyDialog('Skills', context);
      //
    } else if (str_request == '') {
      //
      _showMyDialog('Reqeust assignment', context);
      //
    } else if (str_task_details == '') {
      //
      _showMyDialog('Task details', context);
      //
    } else if (str_add_reminder_date == '') {
      //
      _showMyDialog('Reminder Date', context);
      //
    } else if (str_add_reminder_time == '') {
      //
      _showMyDialog('Reminder Time', context);
      //
    } else if (str_add_reminder_warning == '') {
      //
      _showMyDialog('Reminde Warning', context);
      //
    } else {
      print('create task ');
      print(rewardType.toString());
      print(groupidMain.toString());
      print(groupidSub.toString());

      CreateTaskModal()
          .create_task_WB(
            str_task_name.toString(),
            str_task_details.toString(),
            str_due_date.toString(),
            str_rewards.toString(),
            str_deduct_rewards.toString(),
            str_request.toString(),
            str_skills.toString(),
            '$str_add_reminder_date $str_add_reminder_time',
            str_add_reminder_warning.toString(),
            profesionalId.toString(),
            profesionalType.toString(),
            //
            rewardType.toString(),
            groupidMain.toString(),
            groupidSub.toString(),
          )
          .then(
            (value) => {
              print('success 123'),
              Navigator.pop(
                context,
                'back_from_add_task',
              ),
            },
          );
    }
  }
}

// ALERT
Future<void> _showMyDialog(
  String str_message,
  BuildContext context,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Alert',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 16.0,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                //
                '$str_message should not be empty.',
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Dismiss',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 16.0,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
