import 'package:flutter/material.dart';
import 'package:mobile/routes/profile_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void checkConnections() async {
  final connectedServices =
      await http.get(Uri.parse(globals.localIp + '/token/getAll'), headers: {
    'Content-Type': 'application/json',
    HttpHeaders.authorizationHeader: globals.jwt,
  });
  if (jsonDecode(connectedServices.body)['google'] != null) {
    globals.googleConnected = true;
  } else {
    globals.googleConnected = false;
  }
  if (jsonDecode(connectedServices.body)['github'] != null) {
    globals.githubConnected = true;
  } else {
    globals.githubConnected = false;
  }
  if (jsonDecode(connectedServices.body)['reddit'] != null) {
    globals.redditConnected = true;
  } else {
    globals.redditConnected = false;
  }
  if (jsonDecode(connectedServices.body)['twitch'] != null) {
    globals.twitchConnected = true;
  } else {
    globals.twitchConnected = false;
  }
  if (jsonDecode(connectedServices.body)['discord'] != null) {
    globals.discordConnected = true;
  } else {
    globals.discordConnected = false;
  }
  if (jsonDecode(connectedServices.body)['messenger'] != null) {
    globals.messengerConnected = true;
  } else {
    globals.messengerConnected = false;
  }
}

class ServiceAuth extends StatefulWidget {
  final String url;
  const ServiceAuth({required this.url, Key? key}) : super(key: key);

  @override
  _ServiceAuthState createState() => _ServiceAuthState();
}

class _ServiceAuthState extends State<ServiceAuth> {
  String newUrl = "";
  String code = "";
  String service = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AREA Services Login'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: WebView(
              userAgent: "random",
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (request) async {
                if (request.url.contains('localhost:8000')) {
                  service = request.url.substring(
                      request.url.indexOf('oauth/') + 6,
                      request.url.indexOf('?'));

                  if (service == 'github' || service == 'reddit') {
                    code = request.url.substring(
                        request.url.indexOf('code=') + 5, request.url.length);
                  } else if (service == 'google' || service == 'twitch') {
                    code = request.url.substring(
                        request.url.indexOf('code=') + 5,
                        request.url.indexOf('&scope'));
                  } else if (service == 'discord' || service == 'messenger') {
                    code = request.url.substring(
                        request.url.indexOf('code=') + 5,
                        request.url.indexOf('&state'));
                  }
                  final response = await http.get(Uri.parse(
                      globals.localIp + '/oauth/' + service + '?code=' + code));
                  await http.post(Uri.parse(globals.localIp + '/token/set'),
                      body: jsonEncode(<String, String>{
                        'service': service,
                        'token': response.body
                      }),
                      headers: {
                        'Content-Type': 'application/json',
                        HttpHeaders.authorizationHeader: globals.jwt,
                      });
                  checkConnections();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()));
                }
                return NavigationDecision.navigate;
              },
            ),
          ),
        ],
      ),
    );
  }
}
