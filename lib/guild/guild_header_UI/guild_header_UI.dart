import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/guild/my_guild_members/my_guild_members.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils.dart';

class GuildHeaderUIScreen extends StatefulWidget {
  const GuildHeaderUIScreen({super.key, this.dict_value});

  final dict_value;

  @override
  State<GuildHeaderUIScreen> createState() => _GuildHeaderUIScreenState();
}

class _GuildHeaderUIScreenState extends State<GuildHeaderUIScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(10.0),
      // color: Colors.amber[600],
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(
              54,
              30,
              107,
              1,
            ),
            Color.fromRGBO(
              92,
              21,
              93,
              1,
            ),
            Color.fromRGBO(
              138,
              0,
              70,
              1,
            ),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      // height: 48.0,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            // color: Colors.amber[800],
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(),
            ),
            child: Image.network(
              widget.dict_value['imge'].toString(),
              fit: BoxFit.cover,
            ),
          ),

          //
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              color: Colors.transparent,
              // width: 48.0,
              height: 120,
              child: Column(
                children: [
                  Container(
                    // margin: const EdgeInsets.all(10.0),
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: '',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: widget.dict_value['name'].toString(),
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            // TextSpan(text: ' world!'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //
                  Container(
                    // margin: const EdgeInsets.all(10.0),
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        //
                        widget.dict_value['subject'].toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  //
                  Container(
                    // margin: const EdgeInsets.all(10.0),
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Stack(
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/btn_round.png',
                            height: 140,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                8,
                              ),
                            ),
                            // border: Border.all(),
                          ),
                        ),
                        Positioned(
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                if (kDebugMode) {
                                  print(widget.dict_value['userId']);
                                  print(prefs.getInt('userId').toString());
                                }

                                (prefs.getInt('userId').toString() ==
                                        widget.dict_value['userId'].toString())
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyGuildMembersScreen(
                                            str_guild_id: widget
                                                .dict_value['gluidId']
                                                .toString(),
                                            str_remove_member: 'yes',
                                          ),
                                        ),
                                      )
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyGuildMembersScreen(
                                            str_guild_id: widget
                                                .dict_value['gluidId']
                                                .toString(),
                                            str_remove_member: 'no',
                                          ),
                                        ),
                                      );
                                // print();

                                /**/
                              },
                              child: Text(
                                //
                                'Max Member : ${widget.dict_value['maxNumber']}',
                                //
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: font_style_name,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // top: 45,
                          // left: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
        ],
      ),
    );
  }
}
