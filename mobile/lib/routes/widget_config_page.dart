import 'package:flutter/material.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:mobile/routes/dashboard_page.dart';
import 'package:mobile/components/widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class WidgetConfigPage extends StatefulWidget {
  const WidgetConfigPage({Key? key}) : super(key: key);

  @override
  _WidgetConfigPageState createState() => _WidgetConfigPageState();
}

String actionValue = 'Gmail - receive mail';
String reactionValue = 'Gmail - sends you a mail';

var actionText = 'Do not need input';
var reactionText = 'Mail Adress';

class _WidgetConfigPageState extends State<WidgetConfigPage> {
  var actionConfig = '';
  var reactionConfig = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Widget Configuration"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text("Action"),
            trailing: DropdownButton<String>(
              value: actionValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  actionValue = newValue!;
                  switch (actionValue
                      .substring(0, actionValue.indexOf(' '))
                      .toLowerCase()) {
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
                      actionText = 'Do not need an input';
                      break;
                    default:
                      actionText = 'Unknown';
                      break;
                  }
                });
              },
              items: <String>[
                'Gmail - receive mail',
                'Calendar - event incoming',
                'Reddit - receive message',
                'Github - push on repository',
                'Twitch - new followers',
                'Drive - receive answer',
                'Alarm - set a daily alarm',
                'Water - Reminder to drink water every hour'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
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
          ListTile(
            title: const Text("Reaction"),
            trailing: DropdownButton<String>(
              value: reactionValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  reactionValue = newValue!;
                  switch (reactionValue
                      .substring(0, reactionValue.indexOf(' '))
                      .toLowerCase()) {
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
                });
              },
              items: <String>[
                'Gmail - sends you a mail',
                'Reddit - sends you a message',
                'Discord - sends you a message',
                'Sms - sends you a sms',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
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
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: OutlinedButton(
                  onPressed: () async {
                    final action = actionValue
                        .substring(0, actionValue.indexOf(' '))
                        .toLowerCase();
                    final reaction = reactionValue
                        .substring(0, reactionValue.indexOf(' '))
                        .toLowerCase();
                    if ((action == 'gmail' || reaction == 'gmail') &&
                        globals.googleConnected == false) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                              content: Text(
                                  'Please authenticate with your google account first'));
                        },
                      );
                    } else if ((action == 'reddit' || reaction == 'reddit') &&
                        globals.redditConnected == false) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                              content: Text(
                                  'Please authenticate with your reddit account first'));
                        },
                      );
                    } else if ((action == 'discord' || reaction == 'discord') &&
                        globals.discordConnected == false) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                              content: Text(
                                  'Please authenticate with your discord account first'));
                        },
                      );
                    } else if ((action == 'github' || reaction == 'github') &&
                        globals.githubConnected == false) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                              content: Text(
                                  'Please authenticate with your github account first'));
                        },
                      );
                    } else if ((action == 'twitch' || reaction == 'twitch') &&
                        globals.twitchConnected == false) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                              content: Text(
                                  'Please authenticate with your twitch account first'));
                        },
                      );
                    } else if ((action == 'messenger' ||
                            reaction == 'messenger') &&
                        globals.messengerConnected == false) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                              content: Text(
                                  'Please authenticate with your messenger account first'));
                        },
                      );
                    } else if (actionConfig == '' &&
                        reactionConfig == '' &&
                        actionText != 'Do not need an input' &&
                        reactionText != 'Do not need an input') {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text('Please fill the empty fields'),
                          );
                        },
                      );
                    } else {
                      final response = await http.post(
                        Uri.parse(globals.localIp + '/area/create'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                          HttpHeaders.authorizationHeader: globals.jwt,
                        },
                        body: jsonEncode(<String, String>{
                          'action': action,
                          'reaction': reaction,
                          'action_config': actionConfig,
                          'reaction_config': reactionConfig,
                        }),
                      );
                      if (response.statusCode != 200) {
                        throw Exception('Failed to create widget');
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const DashboardPage()));
                      }
                    }
                  },
                  child: const Text("Add Widget"),
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
