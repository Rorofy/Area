import 'package:flutter/material.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:mobile/routes/dashboard_page.dart';
import 'package:mobile/routes/register_page.dart';
import 'package:mobile/routes/profile_page.dart';
import 'package:mobile/routes/webviews/login_auth.dart';
import 'dart:convert';

Future<Url> fetchLoginUrl() async {
  final response =
      await http.get(Uri.parse(globals.localIp + '/oauth/google/urlLogin'));

  if (response.statusCode == 200) {
    return Url.fromHtml(response.body);
  } else {
    throw Exception('Failed to get Url');
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwdController = TextEditingController();
  late Future<Url> googleLoginUrlFetched;

  @override
  void initState() {
    super.initState();
    googleLoginUrlFetched = fetchLoginUrl();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                child: Text('Area', style: TextStyle(fontSize: 40)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 25, bottom: 0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: passwdController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            const Padding(padding: EdgeInsets.all(15)),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: globals.myColor,
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  final response = await http.post(
                    Uri.parse(globals.localIp + '/user/login'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'email': emailController.text,
                      'password': passwdController.text,
                    }),
                  );
                  if (response.statusCode == 200) {
                    Map<String, dynamic> body = jsonDecode(response.body);
                    globals.jwt = body['jwt'];
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DashboardPage()));
                  } else {
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
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            FutureBuilder<Url>(
              future: googleLoginUrlFetched,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 30,
                        left: MediaQuery.of(context).size.width * 0.35,
                        bottom: 0,
                        right: 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    LoginAuth(url: snapshot.data!.url)));
                      },
                      child: Row(
                        children: <Widget>[
                          const Text('Log in with Google  '),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 20,
                              minHeight: 20,
                              maxWidth: 20,
                              maxHeight: 20,
                            ),
                            child: Image.asset("assets/google.png",
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  ('${snapshot.error}');
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(
              height: 80,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
              child: Text(
                'New User? Create an Account',
                style: TextStyle(color: globals.myColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
