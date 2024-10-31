import 'package:flutter/material.dart';
import 'package:mobile/routes/login_page.dart';
import 'package:mobile/routes/profile_page.dart';
import 'package:mobile/routes/register_page.dart';
import 'package:mobile/routes/dashboard_page.dart';
import 'package:mobile/globals.dart' as globals;

class RouteManager extends StatefulWidget {
  const RouteManager({Key? key}) : super(key: key);

  @override
  _RouteManagerState createState() => _RouteManagerState();
}

class _RouteManagerState extends State<RouteManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Area',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: globals.myColor),
        home: const LoginPage());
  }
}
