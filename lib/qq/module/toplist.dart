part of '../module.dart';

/*
 * 榜单信息
 */
Handler toplistInfo = (Map query, cookie) {
  final num = query['num'] ?? 20;
  final page = query['page'] ?? 1;
  final start = (page - 1) * num;

  final data = {
    "data": json.encode({
      "req_0": {
        "module": "musicToplist.ToplistInfoServer",
        "method": "GetAll",
        "param": {},
      },
      "comm": {
        "g_tk": 709041629,
        "uin": "0",
        "format": "json",
        "ct": 20,
        "cv": 1803,
        "platform": "wk_v17",
      }
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};

/*
 * 榜单歌曲
 */
Handler toplistDetail = (Map query, cookie) {
  final num = query['num'] ?? 20;
  final page = query['page'] ?? 1;
  final start = (page - 1) * num;

  final data = {
    "data": json.encode({
      "req_0": {
        "module": "musicToplist.ToplistInfoServer",
        "method": "GetDetail",
        "param": {"topid": 62, "num": 300, "period": "2021-03-10"}
      },
      "comm": {
        "g_tk": 709041629,
        "uin": "0",
        "format": "json",
        "ct": 20,
        "cv": 1803,
        "platform": "wk_v17",
      }
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};
