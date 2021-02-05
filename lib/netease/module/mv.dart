part of '../module.dart';

// 全部MV
Handler mvAll = (query, cookie) {
  final data = {
    'tags': json.encode({
      '地区': query['area'] ?? '全部',
      '类型': query['type'] ?? '全部',
      '排序': query['order'] ?? '上升最快',
    }),
    'offset': query['offset'] ?? 0,
    'limit': query['limit'] ?? 30,
    'total': 'true',
  };
  return request(
    'POST',
    'https://interface.music.163.com/api/mv/all',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// MV 点赞转发评论数数据
Handler mvDetailInfo = (query, cookie) {
  final data = {
    'threadid': 'R_MV_5_${query['mvid']}',
    'composeliked': true,
  };
  return request(
    'POST',
    'https://music.163.com/api/comment/commentthread/info',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// MV详情
Handler mvDetail = (query, cookie) {
  final data = {'id': query['mvid']};
  return request(
    'POST',
    'https://music.163.com/weapi/mv/detail',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 网易出品
Handler mvExclusiveRcmd = (query, cookie) {
  final data = {
    'offset': query['offset'] ?? 0,
    'limit': query['limit'] ?? 30,
  };
  return request(
    'POST',
    'https://interface.music.163.com/api/mv/exclusive/rcmd',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 最新MV
Handler mvFirst = (query, cookie) {
  final data = {
    'area': query['area'] ?? '',
    'limit': query['limit'] ?? 30,
    'total': true,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/mv/first',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 收藏与取消收藏MV
Handler mvSub = (query, cookie) {
  query['t'] = (query['t'] == 1 ? 'sub' : 'unsub');
  final data = {
    'mvId': query['mvid'],
    'mvIds': '["' + query['mvid'] + '"]',
  };
  return request(
    'POST',
    'https://music.163.com/weapi/mv/${query['t']}',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 已收藏MV列表
Handler mvSublist = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 30,
    'total': true,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/mv/first',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// MV链接
Handler mvUrl = (query, cookie) {
  final data = {
    'id': query['id'],
    'r': query['r'] ?? 1080,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/song/enhance/play/mv/url',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
