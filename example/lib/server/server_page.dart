import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kmusic_api/baidu_music.dart';
import 'package:kmusic_api/migu_music.dart';
import 'package:kmusic_api/netease_cloud_music.dart';
import 'package:kmusic_api/qq_music.dart';
import 'package:kmusic_api/utils/answer.dart';

class ServerPage extends StatefulWidget {
  @override
  _ServerPageState createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> with AutomaticKeepAliveClientMixin {
  HttpServer server;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text('服务能单独使用，输入本机ip端口号即可访问'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(FontAwesomeIcons.server),
              Container(
                width: 16,
              ),
              Container(
                width: 120,
                child: Text(
                  '${server?.address?.host ?? ''}:${server?.port ?? ''}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            child: TextButton(
              onPressed: () async {
                server = await _startServer(address: '0.0.0.0', port: 3001);
                setState(() {});
              },
              child: Text(
                '开启服务：3001',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              server?.close()?.then((value) {
                server = null;
                setState(() {});
              });
            },
            child: Text(
              '关闭服务',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

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
      answer = await cloudMusicApi(path.replaceAll("/netease", ""), parameter: request.uri.queryParameters, cookie: request.cookies).catchError((e, s) async {
        print(e.toString());
        print(s.toString());
        return const Answer();
      });
    } else if (path.startsWith("/baidu")) {
      answer = await baiduMusicApi(path.replaceAll("/baidu", ""), parameter: request.uri.queryParameters, auth: request.headers['auth']?.first ?? '').catchError((e, s) async {
        print(e.toString());
        print(s.toString());
        return const Answer();
      });
    } else if (path.startsWith("/qq")) {
      answer = await qqMusicApi(path.replaceAll("/qq", ""), parameter: request.uri.queryParameters, cookie: request.cookies).catchError((e, s) async {
        print(e.toString());
        print(s.toString());
        return const Answer();
      });
    } else if (path.startsWith("/migu")) {
      answer = await miguApi(path.replaceAll("/migu", ""), parameter: request.uri.queryParameters, cookie: request.cookies).catchError((e, s) async {
        print(e.toString());
        print(s.toString());
        return const Answer();
      });
    } else {
      answer = Answer().copy(body: {'code': 500, 'msg': '仅支持“/netease”、“/baidu”、“/qq”、“/migu”开头的接口'});
    }

    request.response.statusCode = answer.status;
    request.response.cookies.addAll(answer.cookie);
    request.response.write(json.encode(answer.body));
    request.response.close();

    print("request[${answer.status}] : ${request.uri}");
  }
}
