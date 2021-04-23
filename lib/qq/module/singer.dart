part of '../module.dart';

/*
 * 歌手列表
 */
Handler singerList = (Map query, cookie) {
  final page = query['page'] ?? 1;
  final sin = (page - 1) * 80;

  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 10000},
      "singerList": {
        "module": "Music.SingerListServer",
        "method": "get_singer_list",
        "param": {"area": query['area'] ?? -100, "sex": query['sex'] ?? -100, "genre": query['genre'] ?? -100, "index": query['index'] ?? -100, "sin": sin, "cur_page": page}
      }
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};

/*
* 歌手信息
*/
Handler singerInfo = (Map query, cookie) {
  final data = {
    'singermid': query['singerMid'],
    'utf8': 1,
    'outCharset': 'utf-8',
    'format': 'xml',
    'r': DateTime.now().millisecondsSinceEpoch,
  };
  return request(
    'GET',
    "https://c.y.qq.com/splcloud/fcgi-bin/fcg_get_singer_desc.fcg",
    data,
    cookies: cookie,
    contentType: 'xml',
  );
};

/*
* 歌手热门音乐
*/
Handler singerSong = (Map query, cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 0},
      "singerSongList": {
        "module": "musichall.song_list_server",
        "method": "GetSingerSongList",
        "param": {"order": 1, "singerMid": query["singerMid"], "begin": (query['page'] - 1) * 20, "num": 20}
      }
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};

/*
* 歌手专辑
*/
Handler singerAlbum = (Map query, cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 0},
      "singerSongList": {
        "method": "GetAlbumList",
        "module": "music.musichallAlbum.AlbumListServer",
        "param": {
          "singerMid": query["singerMid"],
          "order": 0,
          "begin": ((query['page'] ?? 1) - 1) * 20,
          "num": 20,
          "songNumTag": 0,
          "singerID": query['singerId'] ?? 0,
        }
      }
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};

/*
* 歌手MV
*/
Handler singerMV = (Map query, cookie) {
  final data = {
    'format': 'json',
    'platform': 'yqq.json',
    'needNewCode': 0,
    'singermid': query['singerMid'],
    'outCharset': 'utf-8',
    'order': 'listen', //listen,time两种排序
    "begin": ((query['page'] ?? 1) - 1) * 20,
    "num": 20,
    "cid": '205360581',
    "cmd": 0, //0,官方mv，1粉丝上传
  };
  return request(
    'GET',
    "https://c.y.qq.com/mv/fcgi-bin/fcg_singer_mv.fcg",
    data,
    cookies: cookie,
  );
};

/*
* 相似歌手
*/
Handler singerSimilarSinger = (Map query, cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 10000},
      "similarSingerList": {
        "method": "GetSimilarSingerList",
        "module": "music.SimilarSingerSvr",
        "param": {
          "singerMid": query["singerMid"],
          "num": 5,
          "singerId": query['singerId'] ?? 0,
        }
      }
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};
