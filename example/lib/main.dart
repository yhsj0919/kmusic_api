import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/home/home_page.dart';
import 'package:kmusic_api_example/player/player_page.dart';
import 'package:kmusic_api_example/test_page.dart';
import 'package:kmusic_api_example/utils/sp.dart';

void main() {
  Sp.init();
  runApp(MyApp());
  if (Platform.isAndroid) {
    final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // home: TestPage(),
      // home: Scaffold(body: Container(color: Colors.blue,),),
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}
