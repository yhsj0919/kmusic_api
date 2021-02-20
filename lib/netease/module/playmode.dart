part of '../module.dart';

// 心动模式/智能播放
Handler playmodeIntelligenceList = (query, cookie) {
  return request(
      'POST',
      'http://music.163.com/weapi/playmode/intelligence/list',
      {
        'songId': query['id'],
        'type': "fromPlayOne",
        'playlistId': query['pid'],
        'startMusicId': query['sid'] ?? query['id'],
        'count': query['count'] ?? 1
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};
