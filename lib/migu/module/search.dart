part of '../module.dart';

/*
* 搜索热词
 */
Handler searchHotword = (Map query, cookie) {
  final data = {};
  return request(
    'GET',
    "https://jadeite.migu.cn/music_search/v3/search/hotword",
    data,
    cookies: cookie,
  );
};

/*
* 搜索
 */
Handler search = (Map query, cookie) {
  final searchSwitch = [
    {"song": 1, "tagSong": 1, "bestShow": 1},
    {"album": 1},
    {"mvSong": 1},
    {"songlist": 1},
    {"lyricSong": 1},
    {"singer": 1},
    {"concert": 1},
    {"ticket": 1}
  ];

  final keyword = query['keyword'];
  final type = query['type'] ?? 0;
  final data = {
    // 新特性支持标识，默认值为null。格式：“0000000000”。
    // 第1位：取值为“1”：表示最佳展示位活动支持多类型
    // 第2位：取值为“1”：表示需要返回搜索倾向Tab标识
    // 第3位：取值为“1”：支持榜单标签
    // 第4位：取值为“1”：支持是否自动展示标签功能
    // 'feature':'1111000000',
    'pageNo': query['page'] ?? 1,
    'pageSize': query['size'] ?? 20,
    'sort': query['sort'] ?? 1,
    'text': keyword,
    'searchSwitch': json.encode(searchSwitch[type]),
    'isCopyright': 1,
    'isCorrect': 1,
  };

  switch (type) {
    case 2:
      data['userSort'] = json.encode({"mv": "default"});
      break;
    case 3:
      {
        data['userSort'] = json.encode({"songlist": "default"});
        data['userFilter'] = json.encode({"songlisttag": []});
      }
      break;
  }

  final deviceId = Uuid().v1().replaceAll("-", '').toUpperCase();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final signatureMd5 = '6cdc72a439cef99a3418d2a78aa28c73'; // app签名证书的md5
  final text = "$keyword${signatureMd5}yyapp2d16148780a1dcc7408e06336b98cfd50$deviceId$timestamp";
  final sign = md5.convert(utf8.encode(text)).toString();

  final header = {
    'uiVersion': 'A_music_3.6.1',
    'deviceId': deviceId,
    'timestamp': timestamp,
    'sign': sign,
  };
  return request(
    'GET',
    "https://jadeite.migu.cn/music_search/v2/search/searchAll",
    data,
    cookies: cookie,
    header: header,
  );
};

/*
* 搜索建议
 */
Handler searchSuggest = (Map query, cookie) {
  final keyword = query['keyword'];
  final data = {
    'pageSize': query['size'] ?? 10,
    'text': keyword,
    'isCopyright': 1,
  };

  final deviceId = Uuid().v1().replaceAll("-", '').toUpperCase();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final signatureMd5 = '6cdc72a439cef99a3418d2a78aa28c73'; // app签名证书的md5
  final text = "$keyword${signatureMd5}yyapp2d16148780a1dcc7408e06336b98cfd50$deviceId$timestamp";
  final sign = md5.convert(utf8.encode(text)).toString();

  final header = {
    'uiVersion': 'A_music_3.6.1',
    'deviceId': deviceId,
    'timestamp': timestamp,
    'sign': sign,
  };
  return request(
    'GET',
    "https://jadeite.migu.cn/music_search/v2/suggest",
    data,
    cookies: cookie,
    header: header,
  );
};
