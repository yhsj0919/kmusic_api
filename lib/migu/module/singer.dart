part of '../module.dart';

/*
* 歌手
 */
Handler singer = (Map query, cookie) {
  final data = {
    "type": 'huayu-nan',
    "templateVersion": 3,
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/singer-list/release",
    data,
    cookies: cookie,
  );
};
