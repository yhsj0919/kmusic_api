part of '../module.dart';

// 将mlog id转为video id
Handler mlogToVideo = (query, cookies) {
  final data = {
    'mlogId': query['id'],
  };
  return request(
    'POST',
    'https://music.163.com/weapi/mlog/video/convert/id',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

// mlog链接
Handler mlogUrl = (query, cookies) {
  final data = {
    'id': query['id'],
    'resolution': query['res'] ?? 1080,
    'type': 1,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/mlog/detail/v1',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
// 歌曲相关视频
Handler mlogMusicRcmd = (query, cookies) {
  final data = {
    'id': query['mvid'] ?? 0,
    'type': 2,
    'rcmdType': 20,
    'limit': query['limit'] ?? 10,
    'extInfo': json.encode({
      'songId': query['songId'],
    }),
  };
  return request(
    'POST',
    'https://interface.music.163.com/eapi/mlog/rcmd/feed/list',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
