import 'package:flutter/material.dart';

class GuildChatScreen extends StatefulWidget {
  const GuildChatScreen({super.key});

  @override
  State<GuildChatScreen> createState() => _GuildChatScreenState();
}

class _GuildChatScreenState extends State<GuildChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //
          // guild_information_UI(context, i),
          //
          Container(
            margin: const EdgeInsets.all(10.0),
            color: Colors.amber[600],
            width: 48.0,
            height: 48.0,
          ),
        ],
      ),
    );
  }
}
