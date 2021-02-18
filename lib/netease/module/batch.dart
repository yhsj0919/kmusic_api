part of '../module.dart';

// 批量请求接口
Handler batch = (query, cookie) {
  final data = {"e_r": true};
  query.forEach((key, value) {
    if (RegExp(r"^\/api\/").hasMatch(key)) {
      data[key] = query[key];
    }
  });
  return eapiRequest(
    'http://music.163.com/eapi/batch',
    '/api/batch',
    data,
    cookies: cookie,
  );
};
