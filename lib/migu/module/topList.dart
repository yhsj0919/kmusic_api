part of '../module.dart';

/*
* 榜单
 */
Handler topList = (Map query, cookie) {
  final data = {
    "templateVersion": '11',
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/rank-list/release",
    data,
    cookies: cookie,
  );
};

/*
* 榜单详情
 */
Handler topListDetail = (Map query, cookie) {
  final data = {
    "columnId": query['columnId'],
    "needAll": '0',
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/querycontentbyId.do",
    data,
    cookies: cookie,
  );
};
