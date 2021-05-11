part of '../module.dart';

/*
 * 搜索建议
 * https://c.y.qq.com/splcloud/fcgi-bin/smartbox_new.fcg?format=json&key=周杰伦
 */
Handler searchSuggest = (Map query, cookie) {
  final data = {
    "format": "json",
    "key": query["key"],
  };
  return request(
    'GET',
    "https://c.y.qq.com/splcloud/fcgi-bin/smartbox_new.fcg",
    data,
    cookies: cookie,
  );
};

/*
 *搜索
 * t 0:单曲, 1:相关歌手,2:专辑,3:歌单,4:MV,7:歌词,8:用户
 */
Handler search = (Map query, cookie) {
  final num = query['num'] ?? 20;
  final page = query['page'] ?? 1;

  final data = {
    "data": json.encode({
      "comm": {"mina": 1, "ct": 25},
      "req": {
        "method": "DoSearchForQQMusicMobile",
        "module": "music.search.SearchBrokerCgiServer",
        "param": {
          "search_type": query['type'] ?? 0,
          "query": query['key'],
          "page_num": page,
          "num_per_page": num,
        }
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
