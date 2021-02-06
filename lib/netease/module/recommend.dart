part of '../module.dart';

// 推荐节目
Handler programRecommend = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/program/recommend/v1',
    {
      'cateId': query['type'],
      'limit': query['limit'] ?? 10,
      'offset': query['offset'] ?? 0
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 每日推荐歌单
Handler recommendResource = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/v1/discovery/recommend/resource',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 每日推荐歌曲
Handler recommendSongs = (query, cookie) {
  cookie.add(Cookie('os', 'ios'));
  return request(
    'POST',
    'https://music.163.com/api/v3/discovery/recommend/songs',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
