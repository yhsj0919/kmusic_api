part of '../module.dart';

// 歌词
Handler lyric = (query, cookie) {
  cookie.add(Cookie("os", "pc"));

  final data = {
    'id': query['id'],
    'lv': -1,
    'kv': -1,
    'tv': -1,
  };
  return request(
    'POST',
    'https://music.163.com/api/song/lyric',
    data,
    crypto: Crypto.linuxapi,
    cookies: cookie,
    ua: 'pc',
  );
};
