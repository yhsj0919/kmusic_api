part of '../module.dart';

/*
* 歌手
 */
Handler singer = (Map query, cookie) async {
  final data = {
    "tab": query['tab'],
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/bmw/singer-index/list/v1.0",
    data,
    cookies: cookie,
  );
};
/*
* 歌手标签
 */
Handler singerTabs = (Map query, cookie) async {
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/bmw/singer-index/tabs/v1.0",
    {},
    cookies: cookie,
  );
};

/*
* 歌手单曲
 */
Handler singerSongs = (Map query, cookie) async {
  final data = {
    "pageNo": query['page'] ?? 1,
    "pageSize": query['size'] ?? 50,
    "singerId": query['singerId'],
    "songType": 0,
    "templateVersion": 3,
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/song-list/release",
    data,
    cookies: cookie,
  );
};
/*
* 歌手单曲
 */
Handler singerInfo = (Map query, cookie) async {
  final data = {
    "resourceId": query['singerId'],
    "resourceType": 2002,
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do",
    data,
    cookies: cookie,
  );
};

/*
* 歌手专辑
 */
Handler singerAlbum = (Map query, cookie) async {
  final data = {
    "singerId": query['singerId'],
    "templateVersion": 2,
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/singerAlbum/release",
    data,
    cookies: cookie,
  );
};

/*
* 歌手专辑
 */
Handler singerMv = (Map query, cookie) async {
  final data = {
    "singerId": query['singerId'],
    "templateVersion": 2,
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/singerMv/release",
    data,
    cookies: cookie,
  );
};
