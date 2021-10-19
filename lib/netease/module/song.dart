part of '../module.dart';

const _keys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

// 歌曲详情
Handler songDetail = (query, cookie) {
  query['ids'] = query['ids'].toString().split(RegExp(r'\s*,\s*'));
  return request(
    'POST',
    'https://music.163.com/api/v3/song/detail',
    {
      'c': '[' + query['ids'].map((id) => ('{"id":' + id + '}')).join(',') + ']',
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 更新歌曲顺序
Handler songOrderUpdate = (query, cookie) {
  return request(
    'POST',
    'http://interface.music.163.com/api/playlist/manipulate/tracks',
    {
      'pid': query['pid'],
      'trackIds': query['ids'],
      'op': 'update',
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 歌曲链接
Handler songUrl = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));

  if (!cookie.any((cookie) => cookie.name == 'MUSIC_U')) {
    String _createdSecretKey({int size = 16}) {
      StringBuffer buffer = StringBuffer();
      for (var i = 0; i < size; i++) {
        final position = math.Random().nextInt(_keys.length);
        buffer.write(_keys[position]);
      }
      return buffer.toString();
    }

    cookie = List.from(cookie)..add(Cookie('_ntes_nuid', _createdSecretKey()));
  }

  return eapiRequest(
    'https://interface3.music.163.com/eapi/song/enhance/player/url',
    '/api/song/enhance/player/url',
    {
      'ids': '[${query["id"]}]',
      'br': int.parse(query['br'] ?? '999000'),
    },
    cookies: cookie,
  );
};
// 已购单曲
Handler songPurchased = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/single/mybought/song/list',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

//歌曲上传
//TODO
Handler songUpload = (query, cookie) {
  return request(
    'POST',
    'http://interface.music.163.com/',
    {
      'pid': query['pid'],
      'trackIds': query['ids'],
      'op': 'update',
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
