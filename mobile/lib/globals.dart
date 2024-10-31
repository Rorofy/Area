import 'package:flutter/material.dart';
import 'package:mobile/components/widget.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(34, 40, 49, .1),
  100: const Color.fromRGBO(34, 40, 49, .2),
  200: const Color.fromRGBO(34, 40, 49, .3),
  300: const Color.fromRGBO(34, 40, 49, .4),
  400: const Color.fromRGBO(34, 40, 49, .5),
  500: const Color.fromRGBO(34, 40, 49, .6),
  600: const Color.fromRGBO(34, 40, 49, .7),
  700: const Color.fromRGBO(34, 40, 49, .8),
  800: const Color.fromRGBO(34, 40, 49, .9),
  900: const Color.fromRGBO(34, 40, 49, 1),
};

MaterialColor myColor = MaterialColor(0xFF222831, color);

List<WidgetArgs> widgetList = [];

var googleConnected = false;
var githubConnected = false;
var redditConnected = false;
var twitchConnected = false;
var discordConnected = false;
var messengerConnected = false;

String localIp = "http://10.0.2.2:8080";
//TODO : Change IP to EPITECH before last commit : 10.41.154.137
String jwt = "";
