part of '../module.dart';

/*
* 新专辑、新碟
 */
Handler albumNew = (Map query, cookie) {
  final data = {
    "pageSize": 10,
    "nid": 23831003,
    "pageNo": 0,
    "type": 2006,
  };
  return request(
    'GET',
    "http://m.music.migu.cn/migu/remoting/cms_list_tag",
    data,
    cookies: cookie,
  );
};

/*
* 专辑歌曲
 */
Handler albumSong = (Map query, cookie) {
  final data = {
    "albumId": query['albumId'],
    "pageNo": 1,
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/resource/album/song/v2.0",
    data,
    cookies: cookie,
  );
};

/*
* 专辑歌曲
 */
Handler albumInfo = (Map query, cookie) {
  final data = {
    "albumId": query['albumId'],
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/resource/album/v2.0",
    data,
    cookies: cookie,
  );
};


