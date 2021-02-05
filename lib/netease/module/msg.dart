part of '../module.dart';

// 评论
Handler msgComment = (query, cookie) {
  final data = {
    'beforeTime': query['beforeTime'] ?? "-1",
    'limit': query['limit'] ?? 30,
    'total': "true",
    'uid': query['uid']
  };
  return request(
    'POST',
    'https://music.163.com/api/v1/user/comments/${query["uid"]}',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// @我
Handler msgForwards = (query, cookie) {
  final data = {
    'offset': query['offset'] ?? 0,
    'limit': query['limit'] ?? 30,
    'total': "true"
  };
  return request(
    'POST',
    'https://music.163.com/api/forwards/get',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 通知
Handler msgNotice = (query, cookie) {
  final data = {
    'offset': query['offset'] ?? 0,
    'limit': query['limit'] ?? 30,
    'total': "true"
  };
  return request(
    'POST',
    'https://music.163.com/api/msg/notices',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 私信内容
Handler msgPrivateHistory = (query, cookie) {
  final data = {
    'userId': query['uid'],
    'offset': query['offset'] ?? 0,
    'limit': query['limit'] ?? 30,
    'total': "true"
  };
  return request(
    'POST',
    'https://music.163.com/api/msg/private/history',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 私信
Handler msgPrivate = (query, cookie) {
  final data = {
    'offset': query['offset'] ?? 0,
    'limit': query['limit'] ?? 30,
    'total': "true"
  };
  return request(
    'POST',
    'https://music.163.com/api/msg/private/users',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
// 最近联系
Handler msgRecentcontact = (query, cookie) {
  final data = {};
  return request(
    'POST',
    'https://music.163.com/api/msg/recentcontact/get',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
