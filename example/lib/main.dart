import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/home/home_page.dart';
import 'package:kmusic_api_example/utils/sp.dart';

void main() {
  Sp.init();
  runApp(MyApp());

  if (Platform.isAndroid) {
    final SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
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
      builder: (context, child) => Scaffold(
        // 全局隐藏键盘
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: child,
        ),
      ),
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
