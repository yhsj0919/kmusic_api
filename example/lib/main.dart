import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

import 'dart:async';

import 'package:kmusic_api_example/net_repository.dart';

import 'baidu_repository.dart';

void main() {
  // var path = Directory.current.path;
  // Hive.init(path);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = '';
  NetRepository netEase;
  BaiduRepository baiduRepository;

  @override
  void initState() {
    super.initState();
    // initPlatformState();
    netEase = NetRepository();
    baiduRepository = BaiduRepository();
  }

  Future<void> initPlatformState() async {
    netEase.loginByPhone("18612345678", '123456').then((value) {
      print(">>>>>>>>>>>>>>>>>");
      setState(() {
        _platformVersion = value.toString();

        print(_platformVersion);
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> status() async {
    netEase.loginStatus().then((value) {
      print(">>>>>>>>>>>>>>>>>");
      setState(() {
        _platformVersion = value.toString();

        print(_platformVersion);
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> songUrl(String id) async {
    netEase.songurl(id).then((value) {
      print(">>>>>>>>>>>>>>>>>");
      setState(() {
        _platformVersion = value.toString();

        print(_platformVersion);
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> baidu() async {
    baiduRepository.test().then((value) {
      print(">>>>>>>>>>>>>>>>>");
      setState(() {
        _platformVersion = value.toString();

        print(_platformVersion);
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            TextButton(
              onPressed: () {
                initPlatformState();
              },
              child: Text('login'),
            ),
            TextButton(
              onPressed: () {
                status();
              },
              child: Text('status'),
            ),
            TextButton(
              onPressed: () {
                songUrl('1498342485');
              },
              child: Text('SongUrl'),
            ),
            TextButton(
              onPressed: () {
                baidu();
              },
              child: Text('百度测试'),
            ),
          ],
        ),
      ),
    );
  }
}
