part of '../module.dart';

//电台banner
Handler djBanner = (query, cookie) {
  return request(
    'POST',
    'http://music.163.com/weapi/djradio/banner/get',
    const {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台非热门类型
Handler djCategoryExcludehot = (query, cookie) {
  return request(
    'POST',
    'http://music.163.com/weapi/djradio/category/excludehot',
    const {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台推荐类型
Handler djCategoryRecommend = (query, cookie) {
  return request(
    'POST',
    'http://music.163.com/weapi/djradio/category/recommend',
    const {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

//电台分类列表
Handler djCatelist = (query, cookie) {
  return request(
    'POST',
    'http://music.163.com/weapi/djradio/category/get',
    const {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

//电台详情
Handler djDetail = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/djradio/v2/get',
    {'id': query['rid']},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

//热门电台
Handler djHot = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 30,
    'offset': query['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/hot/v1',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 付费电台
Handler djPaygift = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 30,
    ['offset']: query['offset'] ?? 0
  };
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/home/paygift/list?_nmclfl=1',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台个性推荐
Handler djPersonalizeRcmd = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 6,
  };
  return request(
    'POST',
    'https://music.163.com/api/djradio/personalize/rcmd',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台节目详情
Handler djProgramDetail = (query, cookie) {
  final data = {'id': query['id']};
  return request(
    'POST',
    'https://music.163.com/weapi/dj/program/detail',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台24小时节目榜
Handler djProgramToplistHours = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 100,
    // 不支持 offset
  };
  return request(
    'POST',
    'https://music.163.com/api/djprogram/toplist/hours',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台节目榜
Handler djProgramToplist = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 100,
    'offset': query['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/api/program/toplist/v1',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台节目列表
Handler djProgram = (query, cookie) {
  final data = {
    'radioId': query['rid'],
    'limit': query['limit'] ?? 30,
    'offset': query['offset'] ?? 0,
    'asc': toBoolean(query['asc'])
  };
  return request(
    'POST',
    'https://music.163.com/weapi/dj/program/byradio',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
// 类别热门电台
Handler djRadioHot = (query, cookie) {
  final data = {
    'cateId': query['cateId'],
    'limit': query['limit'] ?? 30,
    'offset': query['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/api/djradio/hot',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 精选电台分类

/*
    有声书 10001
    知识技能 453050
    商业财经 453051
    人文历史 11
    外语世界 13
    亲子宝贝 14
    创作|翻唱 2001
    音乐故事 2
    3D|电子 10002
    相声曲艺 8
    情感调频 3
    美文读物 6
    脱口秀 5
    广播剧 7
    二次元 3001
    明星做主播 1
    娱乐|影视 4
    科技科学 453052
    校园|教育 4001
    旅途|城市 12
*/
Handler djRecommendType = (query, cookie) {
  final data = {'cateId': query['type']};
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/recommend',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 精选电台
Handler djRecommend = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/recommend/v1',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 订阅与取消电台
Handler djSub = (query, cookie) {
  query['t'] = (query['t'] == 1 ? 'sub' : 'unsub');
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/${query["t"]}',
    {'id': query['rid']},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 订阅电台列表
Handler djSublist = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 30,
    'offset': query['offset'] ?? 0,
    'total': true
  };
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/get/subed',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台订阅者列表
Handler djSubscriber = (query, cookie) {
  final data = {
    'time': query['time'] ?? '-1',
    'id': query['id'],
    'limit': query['limit'] ?? 20,
    'total': true
  };
  return request(
    'POST',
    'https://music.163.com/api/djradio/subscriber',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台今日优选
Handler djTodayPerfered = (query, cookie) {
  final data = {'page': query['page'] ?? 0};
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/home/today/perfered',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台24小时主播榜
Handler djToplistHours = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 100,
    // 不支持 offset
  };
  return request(
    'POST',
    'https://music.163.com/api/dj/toplist/hours',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台新人榜
Handler djToplistNewcomer = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 100,
    'offset': query['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/api/dj/toplist/newcomer',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 付费精品
Handler djToplistPay = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 100,
    // 'offset': query['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/api/djradio/toplist/pay',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 电台最热主播榜
Handler djToplistPopular = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 100,
    // 'offset': query['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/api/dj/toplist/popular',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 新晋电台榜/热门电台榜
Handler djToplist = (query, cookie) {
  //0为新晋,1为热门
  final type = const {"new": 0, "hot": 1}[query['type'] ?? "new"];

  final data = {
    'limit': query['limit'] ?? 100,
    'offset': query['offset'] ?? 0,
    'type': type,
  };
  return request(
    'POST',
    'https://music.163.com/api/djradio/toplist',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
