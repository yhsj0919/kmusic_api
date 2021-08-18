import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:kmusic_api/migu_music.dart';
import 'package:kmusic_api/utils/answer.dart';
import 'package:kmusic_api_example/entity/album_entity.dart';
import 'package:kmusic_api_example/entity/play_list_entity.dart';
import 'package:kmusic_api_example/entity/singer_entity.dart';
import 'package:kmusic_api_example/entity/song_entity.dart';
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

  Future<List<AlbumEntity>> albumNewWeb() {
    return _doRequest('/album/new/web', params: {}).then((value) {
      var list = (value['result']['results'] as List).map((e) => e['albumData']).toList();

      var resp = list.map((e) {
        return AlbumEntity(
          id: e["albumId"],
          name: e["albumName"],
          img: e["albumsSmallUrl"],
        );
      }).toList();

      return Future.value(resp);
    });
  }

  Future<dynamic> albumNewType() {
    return _doRequest('/album/new/type', params: {});
  }

  Future<dynamic> albumNew() {
    return _doRequest('/album/new', params: {});
  }

  Future<List<SongEntity>> albumSong({required String albumId, required String type, int pageNo = 1, int pageSize = 50}) {
    return _doRequest('/album/song', params: {'albumId': albumId, "type": type, "page": pageNo, "size": pageSize}).then((value) {
      var list = (value["resource"] as List?)?.first["songItems"] as List?;

      var resp = list?.map((e) {
        var newRateFormats = e["newRateFormats"] as List?;
        var singerList = e["miguImgItems"] as List?;
        return SongEntity(
          id: e["songId"],
          name: e["songName"],
          img: (e["albumImgs"] as List?)?.last["img"],
          lrc: e["lrcUrl"],
          hasMv: e["hasMv"] == "1",
          singer: (e["singerImg"] as Map?)
              ?.entries
              .map((e) => SingerEntity(
                    id: e.key,
                    name: e.value["singerName"],
                    img: singerList?.isEmpty == true ? null : singerList?.last["img"],
                  ))
              .toList(),
          url: (newRateFormats != null && newRateFormats.length > 0) ? (newRateFormats.first?["url"]) : null,
        );
      }).toList();

      return Future.value(resp);
    });
  }

  Future<List<SongEntity>> albumSong2({required String albumId, required String type, int pageNo = 1, int pageSize = 50}) {
    return _doRequest('/album/song2', params: {'albumId': albumId, "type": type, "page": pageNo, "size": pageSize}).then((value) {
      var list = value['data']['songList'] as List;
      var resp = list.map((e) {
        return SongEntity(
          id: e["songId"],
          name: e["songName"],
          img: "http://d.musicapp.migu.cn" + e["img1"],
          singer: (e["singerList"] as List).map((e) => SingerEntity(id: e['id'], name: e["name"], img: "http://d.musicapp.migu.cn" + e["img"])).toList(),
          // url: e["listenUrl"],
        );
      }).toList();
      return Future.value(resp);
    });
  }

  Future<AlbumEntity> albumInfo({required String albumId, required String type}) {
    return _doRequest('/album/info', params: {'albumId': albumId, "type": type}).then((value) {
      var resource = (value["resource"] as List?)?.first;
      var data = AlbumEntity(
        id: resource?["albumId"],
        name: resource?["title"],
        img: (resource?["imgItems"] as List?)?.first["img"],
        desc: resource?["summary"].toString().trim(),
        singer: [SingerEntity(id: resource?["singerId"], name: resource?["singer"])],
        time: resource?["publishTime"],
        company: resource?["publishCompany"],
        musicNum: resource?["totalCount"],
        language: resource?["language"],
        albumClass: resource?["albumClass"],
      );
      return Future.value(data);
    });
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

  Future<List<PlayListEntity>> playListNewWeb() {
    return _doRequest('/playList/new/web', params: {}).then((value) {
      var list = value['msg'] as List;

      var resp = list.map((e) {
        return PlayListEntity(
          id: e["playlistId"],
          name: e["playlistName"],
          img: e["image"],
        );
      }).toList();
      return Future.value(resp);
    });
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

  Future<PlayListEntity> playListInfo({required String id, String? type}) {
    return _doRequest('/playList/info', params: {'id': id, 'type': type ?? DateTime.now().year}).then((value) {
      var resource = (value["resource"] as List?)?.first;
      var playList = PlayListEntity(
        id: resource["musicListId"],
        name: resource["title"],
        img: resource["imgItem"]["img"],
        intro: resource["summary"],
        keepNum: resource["opNumItem"]["keepNumDesc"],
        musicNum: "${resource["musicNum"]}",
        type: resource["resourceType"],
        playNum: resource["opNumItem"]["playNumDesc"],
        tags: (resource["tags"] as List?)?.map((e) => e["tagName"].toString()).toList(),
        userId: resource["ownerId"],
        userName: resource["ownerName"],
      );
      return Future.value(playList);
    });
  }

  Future<List<SongEntity>> playListSong({required String id, int pageNo = 1, int pageSize = 50}) {
    return _doRequest('/playList/song', params: {'id': id, "size": pageSize, "page": pageNo}).then((value) {
      var list = value['data']['songList'] as List;
      var resp = list.map((e) {
        return SongEntity(
          id: e["songId"],
          name: e["songName"],
          img: e["img1"],
          singer: (e["singerList"] as List).map((e) => SingerEntity(id: e['id'], name: e["name"], img: "http://d.musicapp.migu.cn" + e["img"])).toList(),
          url: e["listenUrl"],
        );
      }).toList();

      return Future.value(resp);
    });
  }

  Future<List<SongEntity>> songNewWeb() {
    return _doRequest('/song/new/web', params: {}).then((value) {
      var list = value['result']['results'] as List;

      var resp = list.map((e) => e['songData']).map((e) {
        var singerId = (e["singerId"] as List);
        var singerName = (e["singerName"] as List);
        return SongEntity(
            id: e["songId"],
            img: e["picS"],
            name: e["songName"],
            singer: singerId.map((e) => SingerEntity(id: e, name: singerName[singerId.indexOf(e)])).toList(),
            url: e["listenUrl"]);
      }).toList();
      return Future.value(resp);
    });
  }

  Future<dynamic> songNewType() {
    return _doRequest('/song/new/type', params: {});
  }

  Future<dynamic> songNew() {
    return _doRequest('/song/new', params: {});
  }

  Future<SongEntity> playUrl(String songId) {
    return _doRequest('/song/url', params: {'songId': songId, 'toneFlag': 'PQ'}).then((value) {
      if (value["code"] != "000000") {
        return Future.value(SongEntity(code: value["code"], msg: value["info"]));
      }

      final result = value['data'];

      if (result["dialogInfo"] != null && result["song"] == null) {
        return Future.value(SongEntity(code: result["cannotCode"] ?? "004400", msg: result["dialogInfo"]["text"]));
      }
      final playSong = result["song"];
      var song = SongEntity(
        code: value["code"],
        msg: value["info"],
        id: playSong["songId"],
        name: playSong["songName"],
        lrc: result["lrcUrl"],
        url: result["url"].toString().replaceAll("MP3_128_16_Stero", "MP3_320_16_Stero").replaceAll("ftp://218.200.160.122:21", "http://freetyst.nf.migu.cn"),
        img: "http://d.musicapp.migu.cn" + playSong["img1"],
        singer: (playSong["singerList"] as List?)?.map((e) => SingerEntity(id: e['id'], name: e["name"], img: "http://d.musicapp.migu.cn" + e["img"])).toList(),
        album: playSong["album"],
        albumId: playSong["albumId"],
        mvId: playSong["mvId"],
        hasMv: playSong["mvId"] != null,
      );

      return Future.value(song);
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
