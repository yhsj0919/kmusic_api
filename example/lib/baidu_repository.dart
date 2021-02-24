import 'dart:async';

import 'package:kmusic_api/baidu_music.dart';
import 'package:kmusic_api/utils/answer.dart';

class BaiduRepository {
  static const bool _SUCCESS = true;

  //身份认证在登录的时候返回
  Future<String> _loadAuth() async {
    return "";
  }

  _saveAuth(String auth) async {}

  Future<dynamic> _doRequest(String path, {Map<String, dynamic> params}) async {
    String auth = await _loadAuth();
    Answer answer;
    try {
      answer = await baiduMusicApi(path, parameter: params, auth: auth);
    } catch (e, stacktrace) {
      Future.error('request error:$e', stacktrace);
    }

    // if (answer.status == HttpStatus.ok) {
    //   _saveCookies("answer.cookie");
    // }

    final map = answer.body;
    if (map == null) {
      return Future.error('请求失败了');
    } else if (map['errmsg'].toString().contains('请登陆')) {
      return Future.error('需要登陆才能访问哦~');
    } else if (map['state'] != _SUCCESS) {
      return Future.error(map['errmsg'] ?? '请求失败了~');
    }
    return Future.value(map);
  }

  //测试接口
  Future<dynamic> test() {
    return _doRequest('/song/info', params: {"tsId": 'T10053430210'});
  }
}
