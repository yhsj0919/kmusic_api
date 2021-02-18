part of '../module.dart';

// 私信歌单
Handler sendPlaylist = (query, cookie) {
  cookie.add(Cookie('os', "pc"));

  final data = {
    'id': query['playlist'],
    'type': 'playlist',
    'msg': query['msg'],
    'userIds': '[${query['user_ids']}]'
  };
  return request(
    'POST',
    'https://music.163.com/weapi/msg/private/send',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 私信歌曲
Handler sendSong = (query, cookie) {
  cookie.add(Cookie('os', "ios"));
  cookie.add(Cookie('appver', "8.0.00"));

  final data = {
    'id': query['id'],
    'type': 'song',
    'msg': query['msg'],
    'userIds': '[${query['user_ids']}]'
  };
  return request(
    'POST',
    'https://music.163.com/api/msg/private/send',
    data,
    crypto: Crypto.linuxapi,
    cookies: cookie,
  );
};

// 私信
Handler sendText = (query, cookie) {
  cookie.add(Cookie('os', "pc"));

  final data = {
    'type': 'text',
    'msg': query['msg'],
    'userIds': '[${query['user_ids']}]'
  };
  return request(
    'POST',
    'https://music.163.com/weapi/msg/private/send',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
