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

  Future<dynamic> openScreen() {
    return _doRequest('/openScreen', params: {});
  }

  Future<dynamic> index() {
    return _doRequest('/index', params: {});
  }

  Future<dynamic> albumList() {
    return _doRequest('/album/list', params: {});
  }

  Future<dynamic> albumInfo() {
    return _doRequest('/album/info', params: {'albumAssetCode': 'P10003719628'});
  }

  Future<dynamic> songList() {
    return _doRequest('/song/list', params: {});
  }

  Future<dynamic> songInfo() {
    return _doRequest('/song/info', params: {'tsId': 'T10059893321', 'rate': '320'});
  }

  Future<dynamic> songDownload() {
    return _doRequest('/song/download', params: {'tsId': 'T10059893321', 'rate': '320'});
  }

  Future<dynamic> artistList() {
    return _doRequest('/artist/list', params: {});
  }

  Future<dynamic> artistInfo() {
    return _doRequest('/artist/info', params: {'artistCode': 'A10047720'});
  }

  Future<dynamic> artistSong() {
    return _doRequest('/artist/song', params: {'artistCode': 'A10047720'});
  }

  Future<dynamic> artistAlbum() {
    return _doRequest('/artist/album', params: {'artistCode': 'A10047720'});
  }

  Future<dynamic> search() {
    return _doRequest('/search', params: {'word': '薛之谦', 'type': '1'});
  }

  Future<dynamic> searchSug() {
    return _doRequest('/search/sug', params: {'word': '薛之谦'});
  }

  Future<dynamic> bdType() {
    return _doRequest('/bd/type', params: {});
  }

  Future<dynamic> bdList() {
    return _doRequest('/bd/list', params: {"bdid": '257851'});
  }

  Future<dynamic> tracklistType() {
    return _doRequest('/tracklist/type', params: {});
  }

  Future<dynamic> tracklistList() {
    return _doRequest('/tracklist/list', params: {'subCateId': '2368'});
  }

  Future<dynamic> tracklistInfo() {
    return _doRequest('/tracklist/info', params: {'id': '279904'});
  }

  Future<dynamic> videoList() {
    return _doRequest('/video/list', params: {});
  }

  Future<dynamic> videoInfo() {
    return _doRequest('/video/info', params: {'assetCode': 'V10000002283'});
  }

  Future<dynamic> videoRecommend() {
    return _doRequest('/video/recommend', params: {});
  }

  Future<dynamic> videoDownload() {
    return _doRequest('/video/download', params: {'assetCode': 'V10000002283'});
  }
}
