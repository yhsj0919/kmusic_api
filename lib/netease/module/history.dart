part of '../module.dart';

// 历史每日推荐歌曲详情
Handler historyRecommendSongsDetail = (query, cookie) {
  cookie.add(Cookie('os', 'ios'));
  return request(
    'POST',
    'https://music.163.com/api/discovery/recommend/songs/history/detail',
    {"data": query['data' ?? '']},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 历史每日推荐歌曲
Handler historyRecommendSongs = (query, cookie) {
  cookie.add(Cookie('os', 'ios'));
  return request(
    'POST',
    'https://music.163.com/api/discovery/recommend/songs/history/recent',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
