import 'package:flutter/material.dart';
import 'package:kmusic_api_example/home_page.dart';
import 'package:kmusic_api_example/utils/sp.dart';

void main() {
  Sp.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
