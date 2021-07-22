import 'dart:async';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:kmusic_api/migu_music.dart';
import 'package:kmusic_api/utils/answer.dart';
import 'package:kmusic_api_example/utils/cookie_storage.dart';

class MiGuRepository {
  static const int _NEED_LOGIN = 301;
  static const int _SUCCESS = 0;
  Completer<PersistCookieJar> _cookieJar = Completer();

  MiGuRepository() {
    scheduleMicrotask(() async {
      PersistCookieJar cookieJar = PersistCookieJar(storage: CookieStorage());
      _cookieJar.complete(cookieJar);
    });
  }

  Future<List<Cookie>> _loadCookies() async {
    var jar = await _cookieJar.future;
    if (jar == null) {
      return [];
    }
    final uri = Uri.parse('https://m.music.migu.cn');
    return jar.loadForRequest(uri);
  }

  _saveCookies(List<Cookie>? cookies) async {
    var jar = await _cookieJar.future;
    if (jar == null || cookies == null) {
      return;
    }
    final uri = Uri.parse('https://m.music.migu.cn');
    jar.saveFromResponse(uri, cookies);
  }

  Future<dynamic> _doRequest(String path, {Map<String, dynamic> params: const {}}) async {
    List<Cookie> cookies = await _loadCookies();
    Answer? answer;
    try {
      answer = await miguApi(path, parameter: params, cookie: cookies);
    } catch (e, stacktrace) {
      Future.error('request error:$e', stacktrace);
    }

    if (answer?.status == HttpStatus.ok) {
      _saveCookies(answer?.cookie);
    }

    final map = answer?.body;
    if (map == null) {
      return Future.error('请求失败了');
    }
    /*else if (map['errmsg'].toString().contains('请登陆')) {
      return Future.error('需要登陆才能访问哦~');
    } else if (map['data'] != null) {
      return Future.error(map['errmsg'] ?? '请求失败了~');
    }*/
    return Future.value(map);
  }

  Future<dynamic> banner() {
    return _doRequest('/banner', params: {});
  }

  Future<dynamic> albumNewWeb() {
    return _doRequest('/album/new/web', params: {});
  }

  Future<dynamic> albumNewType() {
    return _doRequest('/album/new/type', params: {});
  }

  Future<dynamic> albumNew() {
    return _doRequest('/album/new', params: {});
  }

  Future<dynamic> albumSong() {
    return _doRequest('/album/song', params: {'albumId': '1136495459'});
  }

  Future<dynamic> albumInfo() {
    return _doRequest('/album/info', params: {'albumId': '1136495459'});
  }

  Future<dynamic> mvResource() {
    return _doRequest('/mv/resource', params: {
      'mvId': '600906000000337596',
    });
  }

  Future<dynamic> mvPlayUrl() {
    return _doRequest('/mv/playUrl', params: {
      'mvId': "600906000000337596",
      'mvCopyrightId': "600846Y0958",
      'format': "050012",
      'size': "90945275",
      'url':
          "/PmeXt%2FJkph%2FGY9oGZIn%2BrnuIohQqAlHDNzPQW3eR0XClFjPwu50LmEzWRhw28uE7R5cJktVMTOzJXeMAMD4s6%2FHoohaZwztCZeX0%2F8V4SgKvOe9CTKEabthWaTmi1bnRY1CkU%2BF8w6Q7n9bzYo3zMsjcjimuJF%2BDSkO6UYVjmzWz97CQL6%2By771Gjr1Q0FfaBkhsIIPbf8bdbEaaJDQB2Q%3D%3D/600846Y0958033950.mp4?ec=2&flag=+&F=050012",
    });
  }

  Future<dynamic> mvRec() {
    return _doRequest('/mv/rec', params: {
      'mvId': "600906000000337596",
    });
  }

  Future<dynamic> playListNewWeb() {
    return _doRequest('/playList/new/web', params: {});
  }

  Future<dynamic> playListHotTag() {
    return _doRequest('/playList/hotTag', params: {});
  }

  Future<dynamic> playListRec() {
    return _doRequest('/playList/rec', params: {});
  }

  Future<dynamic> playListPlayNum() {
    return _doRequest('/playList/playNum', params: {
      'contentIds': ["196764163", "193392029"],
      'contentType': ["2021", "2021"],
    });
  }

  Future<dynamic> playList() {
    return _doRequest('/playList', params: {
      'page': '1',
      'tagId': '1003449727',
    });
  }

  Future<dynamic> playListTagList() {
    return _doRequest('/playList/tagList', params: {});
  }

  Future<dynamic> playListInfo() {
    return _doRequest('/playList/info', params: {
      'id': '181694965',
      'type': '2021',
    });
  }

  Future<dynamic> playListSong() {
    return _doRequest('/playList/song', params: {
      'id': '181694965',
    });
  }

  Future<dynamic> songNewWeb() {
    return _doRequest('/song/new/web', params: {});
  }

  Future<dynamic> songNewType() {
    return _doRequest('/song/new/type', params: {});
  }

  Future<dynamic> songNew() {
    return _doRequest('/song/new', params: {});
  }

  Future<dynamic> playUrl(String songId) {
    return _doRequest('/song/url', params: {
      // 'albumId': '1002508351',
      'songId': songId,
      'toneFlag': 'PQ',
    });
  }

  Future<dynamic> topList() {
    return _doRequest('/topList', params: {});
  }

  Future<dynamic> topListDetail() {
    return _doRequest('/topList/detail', params: {
      "columnId": '23189800',
    });
  }

  Future<dynamic> singerTabs() {
    return _doRequest('/singer/tabs', params: {});
  }

  Future<dynamic> singer() {
    return _doRequest('/singer', params: {'tab': 'tuijian-renqi'});
  }

  Future<dynamic> singerInfo() {
    return _doRequest('/singer/info', params: {'singerId': '1212'});
  }

  Future<dynamic> singerSongs() {
    return _doRequest('/singer/songs', params: {'singerId': '1212'});
  }

  Future<dynamic> singerAlbum() {
    return _doRequest('/singer/album', params: {'singerId': '1212'});
  }

  Future<dynamic> singerMv() {
    return _doRequest('/singer/mv', params: {'singerId': '1212'});
  }

  Future<dynamic> searchHotWord() {
    return _doRequest('/search/hotword');
  }

  Future<dynamic> search(String keyword, {int type = 0, int page = 1, int size = 20}) {
    return _doRequest('/search', params: {'keyword': keyword, 'type': type, 'page': page, 'size': size});
  }

  Future<dynamic> searchSuggest(String keyword) {
    return _doRequest('/search/suggest', params: {'keyword': keyword});
  }
}
