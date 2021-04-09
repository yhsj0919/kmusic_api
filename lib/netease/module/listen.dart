part of '../module.dart';

// 一起听状态
Handler listenTogetherStatus = (Map query, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/api/listen/together/status/get",
    {},
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};
