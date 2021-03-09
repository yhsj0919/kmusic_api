import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kmusic_api/baidu_music.dart';
import 'package:kmusic_api/netease_cloud_music.dart';
import 'package:kmusic_api/utils/answer.dart';
// import 'package:hive/hive.dart';

import 'dart:async';

import 'package:kmusic_api_example/net_repository.dart';
import 'package:kmusic_api_example/qq_repository.dart';

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
  QQRepository qqRepository;
  HttpServer server;

  @override
  void initState() {
    super.initState();
    // initPlatformState();
    netEase = NetRepository();
    baiduRepository = BaiduRepository();
    qqRepository = QQRepository();
  }

  Future<void> initPlatformState() async {
    netEase.loginByPhone("18612345678", '123456').then((value) {
      print(">>>>>>>>>>>>>>>>>");
      setState(() {
        _platformVersion = value.toString();

        print(_platformVersion);
      });
    }).catchError((e) {
      setState(() {
        _platformVersion = e.toString();

        print(_platformVersion);
      });
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
      setState(() {
        _platformVersion = e.toString();

        print(_platformVersion);
      });
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
      setState(() {
        _platformVersion = e.toString();

        print(_platformVersion);
      });
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
      setState(() {
        _platformVersion = e.toString();
        print(_platformVersion);
      });
    });
  }

  Future<void> qq() async {
    qqRepository.songListen().then((value) {
      print(">>>>>>>>>>>>>>>>>");
      setState(() {
        _platformVersion = value.toString();
        print(_platformVersion);

      });
    }).catchError((e) {
      setState(() {
        _platformVersion = e.toString();
        print(_platformVersion);
      });
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
            Text('结果:'),
            Container(
              height: 300,
              child: SingleChildScrollView(
                child: Text('$_platformVersion'),
              ),
            ),
            Container(
              height: 16,
            ),
            Text('服务状态: ${server?.address?.host ?? ''}:${server?.port ?? ''}'),
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
            TextButton(
              onPressed: () {
                qq();
              },
              child: Text('qq测试'),
            ),
            TextButton(
              onPressed: () async {
                server = await _startServer(address: '0.0.0.0', port: 3001);

                setState(() {});
              },
              child: Text('开启服务：3001'),
            ),
            TextButton(
              onPressed: () async {
                server?.close()?.then((value) {
                  server = null;

                  setState(() {});
                });
              },
              child: Text('关闭服务'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<HttpServer> _startServer({address = "0.0.0.0", int port = 3000}) {
  return HttpServer.bind(address, port, shared: true).then((server) {
    print("start listen at: http://$address:$port");
    server.listen((request) {
      _handleRequest(request);
    });
    return server;
  });
}

void _handleRequest(HttpRequest request) async {
  Answer answer;

  String path = request.uri.path;

  if (path.startsWith("/netease")) {
    answer = await cloudMusicApi(path.replaceAll("/netease", ""),
            parameter: request.uri.queryParameters, cookie: request.cookies)
        .catchError((e, s) async {
      print(e.toString());
      print(s.toString());
      return const Answer();
    });
  } else if (path.startsWith("/baidu")) {
    answer = await baiduMusicApi(path.replaceAll("/baidu", ""),
            parameter: request.uri.queryParameters,
            auth: request.headers['auth']?.first ?? '')
        .catchError((e, s) async {
      print(e.toString());
      print(s.toString());
      return const Answer();
    });
  } else {
    answer = Answer()
        .copy(body: {'code': 500, 'msg': '仅支持“/netease”和“/baidu”开头的接口'});
  }

  request.response.statusCode = answer.status;
  request.response.cookies.addAll(answer.cookie);
  request.response.write(json.encode(answer.body));
  request.response.close();

  print("request[${answer.status}] : ${request.uri}");
}
