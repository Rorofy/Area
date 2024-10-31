import 'package:flutter/material.dart';
import 'package:mobile/components/widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/routes/profile_page.dart';
import 'package:mobile/routes/widget_config_page.dart';
import 'package:mobile/routes/webviews/services_auth.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class WidgetsGet {
  List<dynamic> widgetList;

  WidgetsGet({required this.widgetList});

  factory WidgetsGet.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = [];
    for (var i = 0; i < json["areas"].length; i++) {
      list.add(json["areas"][i]);
    }

    return WidgetsGet(widgetList: list);
  }

  set widgetSet(List<dynamic> list) {
    for (var i = 0; i < list.length; i++) {
      widgetList.add(list[i]);
    }
  }
}

Future<WidgetsGet> fetchWidgets() async {
  final response =
      await http.get(Uri.parse(globals.localIp + '/area/getAll'), headers: {
    'Content-Type': 'application/json',
    HttpHeaders.authorizationHeader: globals.jwt,
  });

  if (response.statusCode == 200) {
    return WidgetsGet.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get widgets');
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<WidgetsGet> futureWidgets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Area"),
        leading: IconButton(
          onPressed: () async {
            checkConnections();
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfilePage()));
          },
          icon: const FaIcon(FontAwesomeIcons.userAlt, size: 20),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const WidgetConfigPage()));
            },
            icon: const FaIcon(FontAwesomeIcons.plus, size: 20),
          ),
        ],
      ),

      // List of buttons to connect to services
      body: FutureBuilder<WidgetsGet>(
        future: fetchWidgets(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.widgetList.length == 0) {
              return const Center(
                  child: Text("Tap on the + button to add an AREA"));
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.widgetList.length,
                itemBuilder: (BuildContext context, int index) {
                  return MyWidget(
                      snapshot.data.widgetList[index]['action'],
                      snapshot.data.widgetList[index]['reaction'],
                      snapshot.data.widgetList[index]['id']);
                },
              );
            }
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
