part of '../module.dart';

/*
* 电台列表
 */
Handler radioList = (Map query, cookie) {
  final data = {
    "format": 'json',
  };
  return request(
    'GET',
    "https://c.y.qq.com/v8/fcg-bin/fcg_v8_radiolist.fcg",
    data,
    cookies: cookie,
  );
};

/*
 * 电台详情
 * 网页上，有个按钮切换，暂时不知道数据是怎么筛选的
 * 默认请求10条音乐，翻页时使用下列参数，不包含radiolist
 * {"songlist":{"module":"pf.radiosvr","method":"GetRadiosonglist","param":{"id":199,"firstplay":0,"num":10}},"comm":{"ct":24,"cv":0}}
 *
 * id 电台Id
 * firstplay 猜测：是不是第一次请求，和加载更多对应
 * num 每页数量
 */
Handler radioDetail = (Map query, cookie) {
  final page = query['page'] ?? 1;
  final size = query['size'] ?? 60;
  final sin = (page - 1) * size;

  final data = {
    "data": json.encode({
      "songlist": {
        "module": "pf.radiosvr",
        "method": "GetRadiosonglist",
        "param": {"id": 199, "firstplay": 1, "num": 10}
      },
      "radiolist": {
        "module": "pf.radiosvr",
        "method": "GetRadiolist",
        "param": {"ct": "24"}
      },
      "comm": {"ct": 24, "cv": 0}
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};
