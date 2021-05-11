// import 'package:hive/hive.dart';

import 'package:flutter/material.dart';
import 'package:kmusic_api_example/baidu/baidu_music_page.dart';
import 'package:kmusic_api_example/home_page.dart';
import 'package:kmusic_api_example/qq/qqmusic_page.dart';
import 'package:kmusic_api_example/server/server_page.dart';

import 'netease/netease_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>  {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
