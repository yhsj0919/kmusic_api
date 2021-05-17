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
* 榜单详情,这个接口暂时没法访问
 */
Handler topListDetail = (Map query, cookie) {
  final data = {
    "columnId": '27553319',
    "id": '27553319',
    "needAll": '0',
    "resourceType": '2009',
    "templateVersion": '3',
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/rank-detail/release",
    data,
    cookies: cookie,
  );
};
