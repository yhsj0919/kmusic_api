part of '../module.dart';

// 账户
Handler userAccount = (query, cookie) {
  final data = {};

  return request(
    'POST',
    'https://music.163.com/api/nuser/account/get',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 用户创建的电台
Handler userAudio = (query, cookie) {
  final data = {
    'userId': query['uid'],
  };

  return request(
    'POST',
    'https://music.163.com/weapi/djradio/get/byuser',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
// 用户绑定手机
Handler userBindingCellphone = (query, cookie) {
  final data = {
    'phone': query['phone'],
    'countrycode': query['countrycode'] ?? '86',
    'captcha': query['captcha'],
    'password': Encrypted(Uint8List.fromList(md5.convert(utf8.encode(query['password'])).bytes)).base16,
  };

  return request(
    'POST',
    'https://music.163.com/api/user/bindingCellphone',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 用户绑定
Handler userBinding = (query, cookie) {
  final data = {
    'userId': query['uid'],
  };

  return request(
    'POST',
    'https://music.163.com/api/v1/user/bindings/${query["uid"]}',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 云盘歌曲删除
Handler userCloudDel = (query, cookie) {
  final data = {
    'songIds': [query['id']],
  };

  return request(
    'POST',
    'https://music.163.com/weapi/cloud/del',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
// 云盘数据详情
Handler userCloudDetail = (query, cookie) {
  final id = query['id'].toString().replaceAll(' ', "").split(",");

  final data = {
    'songIds': id,
  };

  return request(
    'POST',
    'https://music.163.com/weapi/v1/cloud/get/byids',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 云盘数据详情
Handler userCloud = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 30,
    'offset': query['offset'] ?? 0,
  };

  return request(
    'POST',
    'https://music.163.com/api/v1/cloud/get',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
// 用户详情
Handler userDetail = (query, cookie) {
  final data = {};

  return request(
    'POST',
    '`https://music.163.com/weapi/v1/user/detail/${query["uid"]}',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 用户电台节目
Handler userDj = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 30,
    'offset': query['offset'] ?? 0,
  };

  return request(
    'POST',
    'https://music.163.com/weapi/dj/program/${query["uid"]}',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 用户动态
Handler userEvent = (query, cookie) {
  cookie.add(Cookie('os', 'ios'));
  cookie.add(Cookie('appver', '8.1.20'));

  return request(
    'POST',
    'https://music.163.com/api/event/get/${query['uid']}',
    {'getcounts': true, 'limit': query['limit'] ?? 30, 'time': query['lasttime'] ?? -1, 'total': false},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 关注与取消关注用户
Handler userFollow = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  query['t'] = (query['t'] == 1 ? 'follow' : 'delfollow');
  return request(
    'POST',
    'https://music.163.com/weapi/user/${query['t']}/${query['id']}',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 关注TA的人(粉丝)
Handler userFolloweds = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/eapi/user/getfolloweds/${query["uid"]}',
    {
      'userId': query['uid'],
      'time': '0',
      'limit': query['limit'] ?? 30,
      'offset': query['offset '] ?? 0,
      'getcounts': 'true',
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// TA关注的人(关注)
Handler userFollows = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/user/getfollows/${query["uid"]}',
    {'limit': query['limit'] ?? 30, 'offset': query['offset'] ?? 0, 'order': true},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 类别热门电台
Handler userLevel = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/user/level',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 用户歌单
Handler userPlaylist = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/user/playlist',
    {
      'uid': query['uid'],
      'limit': query['limit'] ?? 30,
      'offset': query['offset'] ?? 0,
      'includeVideo': true,
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 听歌排行
Handler userRecord = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/v1/play/record',
    {
      'uid': query['uid'],
      'type': query['type'] ?? 1 // 1: 最近一周, 0: 所有时间
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 更换手机
Handler userReplaceCellphone = (query, cookie) {
  final data = {
    'phone': query['phone'],
    'captcha': query['captcha'],
    'oldcaptcha': query['oldcaptcha'],
    'ctcode': query['ctcode'] ?? '86',
  };

  return request(
    'POST',
    'https://music.163.com/api/user/replaceCellphone',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 收藏计数
Handler userSubcount = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/subcount',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 编辑用户信息
Handler userUpdate = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/user/profile/update',
    {
      'avatarImgId': "0",
      'birthday': query['birthday'],
      'city': query['city'],
      'gender': query['gender'],
      'nickname': query['nickname'],
      'province': query['province'],
      'signature': query['signature']
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 用户评论历史
Handler userCommentHistory = (query, cookie) {
  cookie.add(Cookie("os", "ios"));
  cookie.add(Cookie("appver", "8.1.20"));
  return request(
    'POST',
    'https://music.163.com/api/comment/user/comment/history',
    {
      'compose_reminder': "true",
      'compose_hot_comment': "true",
      'limit': query['limit'] ?? 10,
      'user_id': query['uid'],
      'time': query['time'] ?? 0,
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
