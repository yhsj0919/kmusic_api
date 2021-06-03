// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:kmusic_api/qq_music.dart';
import 'package:kmusic_api/utils/answer.dart';

import 'baidu_music.dart';
import 'migu_music.dart';
import 'netease_cloud_music.dart';

class KMusic {

 static HttpServer _server;

  static Future startServer({address = "0.0.0.0", int port = 3000}) {
    return HttpServer.bind(address, port, shared: true).then((tmpServer) {
      print("start listen at: http://$address:$port");
      tmpServer.listen((request) {
        _handleRequest(request);
      });
      _server=tmpServer;
      return ;
    });
  }

  static Future stopServer(){
   return _server?.close()?.then((value) {
     _server = null;
    });
  }

 static String ip()  {
   return _server?.address?.host??"0.0.0.0";
 }

 static String  port(){
   return '${_server?.port??"NA"}';
 }

  static void _handleRequest(HttpRequest request) async {
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
