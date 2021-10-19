part of '../module.dart';

// 歌手专辑列表
Handler artistAlbum = (Map query, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/weapi/artist/albums/${query['id']}",
    {'limit': query['limit'] ?? 30, 'offset': query['offset'] ?? 0, 'total': true},
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};

//歌手介绍
Handler artistDesc = (query, cookie) => request(
      'POST',
      'https://music.163.com/weapi/artist/introduction',
      {'id': query['id']},
      crypto: Crypto.weapi,
      cookies: cookie,
    );

//歌手介详情
Handler artistDetail = (query, cookie) => request(
      'POST',
      'https://music.163.com/api/artist/head/info/get',
      {'id': query['id']},
      crypto: Crypto.weapi,
      cookies: cookie,
    );

//歌手分类

/*
  initial 取值 a-z/A-Z
  type 取值
  1:男歌手
  2:女歌手
  3:乐队

  area 取值
  -1:全部
  7华语
  96欧美
  8:日本
  16韩国
  0:其他
 */
Handler artistList = (Map query, List<Cookie> cookie) {
  return request(
      'POST',
      'https://music.163.com/api/v1/artist/list',
      {
        'initial': (query['initial'] as String).toUpperCase().codeUnitAt(0),
        'offset': query['offset'] ?? 0,
        'limit': query['limit'] ?? 30,
        'total': true,
        'type': query['type'] ?? '1',
        'area': query['area']
      },
      cookies: cookie,
      crypto: Crypto.weapi);
};

// 歌手相关MV
Handler artistMv = (query, cookie) => request(
    'POST', 'https://music.163.com/weapi/artist/mvs', {'artistId': query['id'], 'limit': query['limit'], 'offset': query['offset'], 'total': true},
    crypto: Crypto.weapi, cookies: cookie);

// 歌手新MV
Handler artistNewMv = (Map query, List<Cookie> cookie) {
  cookie.add(Cookie("os", 'ios'));
  cookie.add(Cookie("appver", '8.1.20'));

  return request(
      'POST',
      'https://music.163.com/api/sub/artist/new/works/mv/list',
      {
        'limit': query['limit'] ?? 20,
        'startTimestamp': query['before'] ?? DateTime.now(),
      },
      cookies: cookie,
      crypto: Crypto.weapi);
};

// 歌手新歌
Handler artistNewSong = (Map query, List<Cookie> cookie) {
  cookie.add(Cookie("os", 'ios'));
  cookie.add(Cookie("appver", '8.1.20'));

  return request(
      'POST',
      'https://music.163.com/api/sub/artist/new/works/song/list',
      {
        'limit': query['limit'] ?? 20,
        'startTimestamp': query['before'] ?? DateTime.now(),
      },
      cookies: cookie,
      crypto: Crypto.weapi);
};

// 歌手歌曲
Handler artistSongs = (Map query, List<Cookie> cookie) {
  cookie.add(Cookie("os", 'pc'));

  return request(
      'POST',
      'https://music.163.com/api/v1/artist/songs',
      {
        'id': query['id'],
        'private_cloud': true,
        'work_type': 1,
        'order': query['order'] ?? 'hot', //hot,time
        'offset': query['offset'] ?? 0,
        'limit': query['limit'] ?? 100,
      },
      cookies: cookie,
      crypto: Crypto.weapi);
};

// 收藏与取消收藏歌手
Handler artistSub = (Map query, List<Cookie> cookie) {
  final type = query['t'] == 1 ? 'sub' : 'unsub';

  return request(
      'POST',
      'https://music.163.com/weapi/artist/$type',
      {
        'artistId': query['id'],
        'artistIds': '[${query['id']}]',
      },
      cookies: cookie,
      crypto: Crypto.weapi);
};

// 关注歌手列表
Handler artistSubList = (Map query, List<Cookie> cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/artist/sublist',
      {
        'limit': query['limit'] ?? 25,
        'offset': query['offset'] ?? 0,
        'total': true,
      },
      cookies: cookie,
      crypto: Crypto.weapi);
};

// 歌手热门 50 首歌曲
Handler artistTopSong = (Map query, List<Cookie> cookie) {
  return request(
      'POST',
      'https://music.163.com/api/artist/top/song',
      {
        'id': query['id'],
      },
      cookies: cookie,
      crypto: Crypto.weapi);
};

// 歌手单曲
Handler artists = (Map query, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/v1/artist/${query["id"]}',
    {},
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};

// 歌手粉丝
Handler artistFans = (Map query, List<Cookie> cookie) {
  final data = {
    'id': query['id'],
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/artist/${query["id"]}',
    data,
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};
