part of '../module.dart';

//专辑内容
Handler album = (Map query, List<Cookie> cookie) {
  return request('POST', "https://music.163.com/weapi/v1/album/${query['id']}", {}, cookies: cookie, crypto: Crypto.weapi);
};

// 专辑动态信息
Handler albumDetailDynamic = (Map query, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/api/album/detail/dynamic",
    {'id': query['id']},
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};

// 数字专辑详情
Handler albumDetail = (Map query, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/weapi/vipmall/albumproduct/detail",
    {'id': query['id']},
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};

//数字专辑-语种风格馆
//Z_H:华语,E_A:欧美,KR:韩国,JP:日本
Handler albumStyle = (query, cookie) => request(
      'POST',
      'https://music.163.com/weapi/vipmall/appalbum/album/style',
      {'limit': query['limit'] ?? 10, 'offset': query['offset'] ?? 0, 'total': true, 'area': query['area'] ?? 'Z_H'},
      crypto: Crypto.weapi,
      cookies: cookie,
    );

//数字专辑-新碟上架
//ALL:全部,ZH:华语,EA:欧美,KR:韩国,JP:日本
Handler albumList = (query, cookie) => request(
      'POST',
      'https://music.163.com/weapi/vipmall/albumproduct/list',
      {'limit': query['limit'] ?? 30, 'offset': query['offset'] ?? 0, 'total': true, 'area': query['area'] ?? 'ALL', 'type': query['type']},
      crypto: Crypto.weapi,
      cookies: cookie,
    );

// 全部新碟
//ALL:全部,ZH:华语,EA:欧美,KR:韩国,JP:日本
Handler albumNew = (query, cookie) => request(
      'POST',
      'https://music.163.com/weapi/album/new',
      {
        'limit': query['limit'] ?? 30,
        'offset': query['offset'] ?? 0,
        'total': true,
        'area': query['area'] ?? 'ALL',
      },
      crypto: Crypto.weapi,
      cookies: cookie,
    );

// 最新专辑
Handler albumNewest = (Map query, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/api/discovery/newAlbum",
    {},
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};

// 数字专辑&数字单曲-榜单
Handler albumSongSaleBoard = (Map query, List<Cookie> cookie) {
  //0为数字专辑,1为数字单曲
  final data = {'albumType': query['albumType'] ?? 0};

  final type = query['type'] ?? 'daily'; // daily,week,year,total
  if (type == 'year') {
    data['year'] = query['year'];
  }

  return request(
    'POST',
    "https://music.163.com/api/feealbum/songsaleboard/$type/type",
    data,
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};

// 收藏/取消收藏专辑
Handler albumSub = (Map query, List<Cookie> cookie) {
  final type = query['t'] == 1 ? 'sub' : 'unsub';

  return request(
    'POST',
    "https://music.163.com/api/album/$type",
    {'id': query['id']},
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};

// 已收藏专辑列表
Handler albumSublist = (Map query, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/weapi/album/sublist",
    {'limit': query['limit'] ?? 25, 'offset': query['offset'] ?? 0, 'total': true},
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};

// 数字专辑销量
Handler albumSales = (Map query, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/weapi/vipmall/albumproduct/album/query/sales",
    {
      'albumIds': query['ids'],
    },
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};
