import 'package:flutter/material.dart';
import 'package:mobile/routes/dashboard_page.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class WidgetConfigPage2 extends StatefulWidget {
  final String action;
  final String reaction;
  final int id;

  const WidgetConfigPage2({
    Key? key,
    required this.action,
    required this.reaction,
    required this.id,
  }) : super(key: key);

  @override
  _WidgetConfigPage2State createState() => _WidgetConfigPage2State();
}

class _WidgetConfigPage2State extends State<WidgetConfigPage2> {
  var actionConfig = '';
  var reactionConfig = '';

  @override
  Widget build(BuildContext context) {
    String actionText;
    String reactionText;

    switch (widget.action) {
      case 'calendar':
        actionText = 'Time before reaction in minutes';
        break;
      case 'gmail':
        actionText = 'Do not need an input';
        break;
      case 'reddit':
        actionText = 'Do not need an input';
        break;
      case 'github':
        actionText = 'Github Repository';
        break;
      case 'twitch':
        actionText = 'Streamer name';
        break;
      case 'drive':
        actionText = 'Do not need an input';
        break;
      case 'alarm':
        actionText = 'Alarm time in hh:mm format';
        break;
      case 'water':
        actionText = 'Every hour, do not need input';
        break;
      default:
        actionText = 'Unknown';
        break;
    }
    switch (widget.reaction) {
      case 'gmail':
        reactionText = 'Mail Adress';
        break;
      case 'reddit':
        reactionText = 'Do not need an input';
        break;
      case 'discord':
        reactionText = 'Webhook Url';
        break;
      case 'sms':
        reactionText = 'Phone Number';
        break;
      default:
        reactionText = 'Unknown';
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Widget Configuration"),
      ),
      body: Column(
        children: <Widget>[
          const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('Action',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)))),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: TextField(
              onChanged: (text) {
                actionConfig = text;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: actionText,
              ),
            ),
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('Reaction',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              onChanged: (text) {
                reactionConfig = text;
              },
              decoration: InputDecoration(
                  border: const OutlineInputBorder(), labelText: reactionText),
            ),
          ),
          OutlinedButton(
            child: const Text('End Configuration'),
            onPressed: () async {
              final response = await http.patch(
                Uri.parse(
                    globals.localIp + '/area/update/' + widget.id.toString()),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  HttpHeaders.authorizationHeader: globals.jwt,
                },
                body: jsonEncode(<String, String>{
                  "key": "action_config",
                  "value": actionConfig
                }),
              );
              if (response.statusCode != 200) {
                showDialog(
                  context: context,
                  builder: (context) {
                    Map<String, dynamic> body = jsonDecode(response.body);
                    return AlertDialog(
                      content: Text(body['message']),
                    );
                  },
                );
                throw Exception('Failed to update widget');
              }
              final response2 = await http.patch(
                Uri.parse(
                    globals.localIp + '/area/update/' + widget.id.toString()),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  HttpHeaders.authorizationHeader: globals.jwt,
                },
                body: jsonEncode(<String, String>{
                  "key": "reaction_config",
                  "value": reactionConfig
                }),
              );
              if (response2.statusCode != 200) {
                showDialog(
                  context: context,
                  builder: (context) {
                    Map<String, dynamic> body = jsonDecode(response2.body);
                    return AlertDialog(
                      content: Text(body['message']),
                    );
                  },
                );
                throw Exception('Failed to update widget');
              }
              if (response.statusCode == 200 && response2.statusCode == 200) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const DashboardPage()));
              }
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1.0, color: Colors.black),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: OutlinedButton(
                  onPressed: () async {
                    await http.delete(
                      Uri.parse(globals.localIp +
                          '/area/delete/' +
                          widget.id.toString()),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        HttpHeaders.authorizationHeader: globals.jwt,
                      },
                    );
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DashboardPage()));
                  },
                  child: const Text('Delete'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: Colors.black),
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
