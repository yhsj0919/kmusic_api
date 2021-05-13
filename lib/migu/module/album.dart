part of '../module.dart';

/*
* 新专辑、新碟
 */
Handler album = (Map query, cookie) {
  final data = {
    "pageSize": 10,
    "nid": 23831003,
    "pageNo": 0,
    "type": 2006,
  };
  return request(
    'GET',
    "http://m.music.migu.cn/migu/remoting/cms_list_tag",
    data,
    cookies: [],
  );
};
