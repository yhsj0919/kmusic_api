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
    'POST',
    'http://music.163.com/eapi/batch',
    data,
    cookies: cookie,
  );
};
