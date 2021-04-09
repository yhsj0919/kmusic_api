import 'dart:async';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:kmusic_api/qq_music.dart';
import 'package:kmusic_api/utils/answer.dart';

class QQRepository {
  static const int _NEED_LOGIN = 301;
  static const int _SUCCESS = 0;
  Completer<PersistCookieJar> _cookieJar = Completer();

  QQRepository() {
    scheduleMicrotask(() async {
      PersistCookieJar cookieJar = PersistCookieJar();
      _cookieJar.complete(cookieJar);
    });
  }

  Future<List<Cookie>> _loadCookies() async {
    var jar = await _cookieJar.future;
    if (jar == null) {
      return [];
    }
    final uri = Uri.parse('https://y.qq.com');
    return jar.loadForRequest(uri);
  }

  _saveCookies(List<Cookie> cookies) async {
    var jar = await _cookieJar.future;
    if (jar == null) {
      return;
    }
    final uri = Uri.parse('https://y.qq.com');
    jar.saveFromResponse(uri, cookies);
  }

  Future<dynamic> _doRequest(String path, {Map<String, dynamic> params}) async {
    List<Cookie> cookies = await _loadCookies();
    Answer answer;
    try {
      answer = await qqMusicApi(path, parameter: params, cookie: cookies);
    } catch (e, stacktrace) {
      Future.error('request error:$e', stacktrace);
    }

    if (answer.status == HttpStatus.ok) {
      _saveCookies(answer.cookie);
    }

    final map = answer.body;
    if (map == null) {
      return Future.error('请求失败了');
    } else if (map['errmsg'].toString().contains('请登陆')) {
      return Future.error('需要登陆才能访问哦~');
    } else if (map['code'] != _SUCCESS) {
      return Future.error(map['errmsg'] ?? '请求失败了~');
    }
    return Future.value(map);
  }

  //singerList
  Future<dynamic> singerList() {
    return _doRequest('/singer/list', params: {});
  }

  Future<dynamic> singerInfo() {
    return _doRequest('/singer/info', params: {});
  }

  Future<dynamic> singerSong() {
    return _doRequest('/singer/song', params: {});
  }

  Future<dynamic> singerAlbum() {
    return _doRequest('/singer/album', params: {"singermid": "002J4UUk29y8BY"});
  }

  Future<dynamic> singerMV() {
    return _doRequest('/singer/mv', params: {"singermid": "0025NhlN2yWrP4"});
  }

  Future<dynamic> similarSinger() {
    return _doRequest('/singer/similarSinger', params: {"singermid": "0025NhlN2yWrP4"});
  }

  Future<dynamic> songInfo() {
    return _doRequest('/song/info', params: {"singermid": "0039MnYb0qxYhV"});
  }

  Future<dynamic> songLyric() {
    return _doRequest('/song/lyric', params: {"songid": "97773"});
  }

  Future<dynamic> songMv() {
    return _doRequest('/song/mv', params: {"songmid": "0039MnYb0qxYhV"});
  }
  Future<dynamic> songListen() {
    return _doRequest('/song/listen', params: {"songmid": "0039MnYb0qxYhV"});
  }

  Future<dynamic> songDownload() {
    return _doRequest('/song/download', params: {"songmid": "0039MnYb0qxYhV"});
  }

  Future<dynamic> songPlayList() {
    return _doRequest('/song/playList', params: {"songid": 97773});
  }

  Future<dynamic> songComment() {
    return _doRequest('/song/comment', params: {"songid": 97773});
  }

  Future<dynamic> mvInfo() {
    return _doRequest('/mv/info', params: {"songid": 97773});
  }
  Future<dynamic> mvUrl() {
    return _doRequest('/mv/url', params: {"songid": 97773});
  }

  Future<dynamic> toplistInfo() {
    return _doRequest('/toplist/info', params: {"songid": 97773});
  }
  Future<dynamic> toplistDetail() {
    return _doRequest('/toplist/detail', params: {"songid": 97773});
  }

  Future<dynamic> playlist() {
    return _doRequest('/playlist', params: {"songid": 97773});
  }
  Future<dynamic> radioList() {
    return _doRequest('/radio/list', params: {});
  }
}
