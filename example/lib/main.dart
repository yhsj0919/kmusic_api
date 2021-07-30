import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/utils/sp.dart';

import 'route/routes.dart';

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
      title: "纯音乐",
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
      getPages: Routes.routes,
      initialRoute: Routes.HOME,
      // home: TestPage(),
      // home: Scaffold(body: Container(color: Colors.blue,),),
      theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: "HarmonyOS_Sans_SC_Regular",
          appBarTheme: AppBarTheme(
              titleSpacing: 0,
              elevation: 0,
              titleTextStyle: TextStyle(
                fontSize: 18,
              ))),
    );
  }
}
