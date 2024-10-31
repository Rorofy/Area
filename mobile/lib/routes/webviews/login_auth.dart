import 'package:flutter/material.dart';
import 'package:mobile/routes/dashboard_page.dart';
import 'package:mobile/routes/login_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginAuth extends StatefulWidget {
  final String url;
  const LoginAuth({required this.url, Key? key}) : super(key: key);

  @override
  _LoginAuthState createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
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
        title: const Text('AREA Google Login'),
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
                  code = request.url.substring(request.url.indexOf('code=') + 5,
                      request.url.indexOf('&scope'));
                  final response = await http.get(Uri.parse(
                      globals.localIp + '/oauth/google/login?code=' + code));
                  if (response.statusCode == 200) {
                    Map<String, dynamic> body = jsonDecode(response.body);
                    globals.jwt = body['jwt'];
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DashboardPage()));
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginPage()));
                    showDialog(
                      context: context,
                      builder: (context) {
                        Map<String, dynamic> body = jsonDecode(response.body);
                        return AlertDialog(
                          content: Text(body['message']),
                        );
                      },
                    );
                  }
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
