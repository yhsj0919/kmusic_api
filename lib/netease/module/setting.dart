part of '../module.dart';

// 设置
Handler setting = (query, cookie) {
  final data = {};
  return request(
    'POST',
    'https://music.163.com/api/user/setting',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
