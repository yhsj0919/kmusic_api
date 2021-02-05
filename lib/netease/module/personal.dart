part of '../module.dart';

// 私人FM
Handler personalFm = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/v1/radio/get',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 推荐电台
Handler personalizedDjprogram = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/personalized/djprogram',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 推荐电台
Handler personalizedMv = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/personalized/mv',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 推荐新歌
Handler personalizedNewsong = (query, cookie) {
  final data = {
    'type': 'recommend',
    'limit': query['limit'] ?? 10,
    'areaId': query['areaId'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/personalized/newsong',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 独家放送列表
Handler personalizedPrivatecontentList = (query, cookie) {
  final data = {
    'offset': query['offset'] ?? 0,
    'limit': query['limit'] ?? 60,
    'total': 'true',
  };
  return request(
    'POST',
    'https://music.163.com/api/v2/privatecontent/list',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 独家放送
Handler personalizedPrivatecontent = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/personalized/privatecontent',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 推荐歌单
Handler personalized = (query, cookie) {
  final data = {
    // 'offset': query['offset'] ?? 0,
    'limit': query['limit'] ?? 30,
    'total': true,
    'n': '1000',
  };

  return request(
    'POST',
    'https://music.163.com/weapi/personalized/playlist',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
