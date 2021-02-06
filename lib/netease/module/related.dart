part of '../module.dart';

// 相关视频
Handler relatedAllvideo = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/cloudvideo/v1/allvideo/rcmd',
    {
      'id': query['id'],
      'type': ((RegExp(r'^\d+$')).hasMatch(query['id'])) ? 0 : 1
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 相关歌单
//好像解析网页搞得啊，稍后再实现
Handler relatedPlaylist = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/playlist?id=${query['id']}',
    {},
    crypto: Crypto.weapi,
    ua: 'pc',
    cookies: cookie,
  ).then((value) {
    throw 'TODO';
  });
};
