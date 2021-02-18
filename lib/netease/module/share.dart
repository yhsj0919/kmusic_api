part of '../module.dart';

// 分享歌曲到动态
Handler shareResource = (query, cookie) {
  final data = {
    'type': query['type'] ?? 'song',
    'msg': query['msg'] ?? '',
    'id': query['id'] ?? '',
  };
  return request(
    'POST',
    'https://music.163.com/weapi/share/friends/resource',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
