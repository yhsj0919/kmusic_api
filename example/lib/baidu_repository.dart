import 'dart:async';

import 'package:kmusic_api/baidu_music.dart';
import 'package:kmusic_api/utils/answer.dart';

class BaiduRepository {
  static const int _NEED_LOGIN = 301;
  static const int _SUCCESS = 200;

  NetRepository() {}

  Future<String> _loadCookies() async {
    return "";
  }

  _saveCookies(String auth) async {}

  Future<dynamic> _doRequest(String path, {Map<String, dynamic> params}) async {
    // String cookies = await _loadCookies();
    Answer answer;
    try {
      answer = await baiduMusicApi(path, parameter: params, auth: "cookies");
    } catch (e, stacktrace) {
      Future.error('request error:$e', stacktrace);
    }

    // if (answer.status == HttpStatus.ok) {
    //   _saveCookies("answer.cookie");
    // }

    final map = answer.body;
    // if (map == null) {
    //   return Future.error('请求失败了');
    // } else if (map['code'] == _NEED_LOGIN) {
    //   return Future.error('需要登陆才能访问哦~');
    // } else if (map['code'] != _SUCCESS) {
    //   return Future.error(map['msg'] ?? '请求失败了~');
    // }
    return Future.value(map);
  }

  ///banner
  Future<dynamic> test() {
    return _doRequest('/test', params: {"type": 0});
  }
}
