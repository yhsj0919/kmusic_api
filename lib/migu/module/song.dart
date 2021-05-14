part of '../module.dart';

/*
* 播放地址
 */
Handler playUrl = (Map query, cookie) {
  final data = {
    // "albumId": query['albumId'],
    "netType": '01',
    "resourceType": 2,
    "songId": query['songId'],
    "toneFlag": query['toneFlag'] ?? 'PQ',
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM2.0/strategy/listen-url/v2.3",
    data,
    cookies: cookie,
  );
};
