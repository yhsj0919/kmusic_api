part of '../module.dart';

/*
* 新专辑、新碟
 */
Handler newAlbum = (Map query, cookie) {
  final num = query['num'] ?? 20;
  final page = query['page'] ?? 1;
  final start = (page - 1) * num;

  final data = {
    "data": json.encode({
      "new_album": {
        "module": "newalbum.NewAlbumServer",
        "method": "get_new_album_info",
        "param": {"area": 1, "start": start, "num": num}
      },
      "new_album_tag": {
        "module": "newalbum.NewAlbumServer",
        "method": "get_new_album_area",
        "param": {},
      },
      "comm": {"ct": 24, "cv": 0}
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};

Handler albumSongList = (Map query, cookie) {
  final num = query['num'] ?? 20;
  final page = query['page'] ?? 1;
  final start = (page - 1) * num;

  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 10000},
      "albumSonglist": {
        "method": "GetAlbumSongList",
        "param": {
          "albumMid": "002U17Aa0K2dUD",
          "albumID": 0,
          "begin": start,
          "num": num,
          "order": 2,
        },
        "module": "music.musichallAlbum.AlbumSongList"
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

Handler albumInfo = (Map query, cookie) {
  final num = query['num'] ?? 60;
  final page = query['page'] ?? 1;
  final start = (page - 1) * num;

  final data = {
    "data": json.encode({
      //该歌手其他专辑
      "req_0": {
        "module": "music.musichallAlbum.OtherAlbumList",
        "method": "OtherAlbumList",
        "param": {
          "albumMid": "002U17Aa0K2dUD",
          "order": 0,
          "num": 6
        }
      },
      //专辑信息
      "req_1": {
        "module": "music.musichallAlbum.AlbumInfoServer",
        "method": "GetAlbumDetail",
        "param": {
          "albumMid": "002U17Aa0K2dUD"
        }
      },
      //专辑歌曲
      "req_2": {
        "module": "music.musichallAlbum.AlbumSongList",
        "method": "GetAlbumSongList",
        "param": {
          "albumMid": "002U17Aa0K2dUD",
          "begin": start,
          "num": num,
          "order": 2
        }
      },
      //是否收藏？
      "req_3": {
        "module": "music.musicasset.AlbumFavRead",
        "method": "IsAlbumFan",
        "param": {
          "v_albumMid": ["002U17Aa0K2dUD"]
        }
      },
      "req_4": {
        "method": "QueryAlbumDetail",
        "param": {
          "albummid": "002U17Aa0K2dUD"
        },
        "module": "mall.MusicMallSvr"
      },
      "comm": {
        "g_tk": 709041629,
        "uin": "0",
        "format": "json",
        "ct": 20,
        "cv": 1803,
        "platform": "wk_v17"
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