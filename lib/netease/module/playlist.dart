part of '../module.dart';

// 全部歌单分类
Handler playlistCatlist = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/playlist/catalogue',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 创建歌单
Handler playlistCreate = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));

  return request(
    'POST',
    'https://music.163.com/weapi/playlist/create',
    {
      'name': query['name'],
      'privacy': query['privacy'], //0 为普通歌单，10 为隐私歌单
      'type': query['type'] ?? 'NORMAL', // NORMAL|VIDEO
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 删除歌单
Handler playlistDelete = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/playlist/remove',
      {
        'ids': '[${query['id']}]',
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 更新歌单描述
Handler playlistDescUpdate = (query, cookie) {
  return eapiRequest(
    'https://interface3.music.163.com/eapi/playlist/desc/update',
    '/api/playlist/desc/update',
    {
      'id': query['id'],
      'desc': query['desc'],
    },
    cookies: cookie,
  );
};

// 初始化名字
Handler playlistDetailDynamic = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/playlist/detail/dynamic',
    {
      'id': query['id'],
      's': query['s'] ?? 8,
      'n': 100000,
    },
    crypto: Crypto.linuxapi,
    cookies: cookie,
  );
};

// 歌单详情
Handler playlistDetail = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/v3/playlist/detail',
    {
      'id': query['id'],
      'n': 100000,
      's': query['s'] ?? 8,
    },
    crypto: Crypto.linuxapi,
    cookies: cookie,
  );
};

// 精品歌单 tags
Handler playlistHighqualityTags = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/playlist/highquality/tags',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 热门歌单分类
Handler playlistHot = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/playlist/hottags',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 我喜欢的歌单
Handler playlistMyLike = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/mlog/playlist/mylike/bytime/get',
    {
      'time': query['time'] ?? '-1',
      'limit': query['limit'] ?? '12',
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
// 更新歌单名
Handler playlistNameUpdate = (query, cookie) {
  final data = {
    'id': query['id'],
    'name': query['name'],
  };

  return eapiRequest(
    'https://interface3.music.163.com/eapi/playlist/update/name',
    '/api/playlist/update/name',
    data,
    cookies: cookie,
  );
};

// 编辑歌单顺序
Handler playlistOrderUpdate = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    'ids': query['ids'],
  };

  return request(
    'POST',
    'https://music.163.com/api/playlist/order/update',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 收藏与取消收藏歌单
Handler playlistSubscribe = (query, cookie) {
  query['t'] = (query['t'] == 1 ? 'subscribe' : 'unsubscribe');
  return request(
      'POST',
      'https://music.163.com/weapi/playlist/${query['t']}',
      {
        'id': query['id'],
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 歌单收藏者
Handler playlistSubscribers = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/playlist/subscribers', {'id': query['id'], 'limit': query['limit'] ?? 20, 'offset': query['offset'] ?? 0},
      crypto: Crypto.weapi, cookies: cookie);
};

// 更新歌单名
Handler playlistTagsUpdate = (query, cookie) {
  final data = {
    'id': query['id'],
    'tags': query['tags'],
  };

  return eapiRequest(
    'https://interface3.music.163.com/eapi/playlist/tags/update',
    '/api/playlist/tags/update',
    data,
    cookies: cookie,
  );
};

// 收藏单曲到歌单
Handler playlistTrackAdd = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  query['ids'] = query['ids'] ?? '';
  final data = {
    'id': query['pid'],
    'tracks': json.encode(
      query['ids'].toString().split(',').map((e) => {'type': 3, 'id': e}).toList(),
    ),
  };
  return request(
    'POST',
    'https://music.163.com/api/playlist/track/add',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
//从歌单删除歌曲
Handler playlistTrackDelete = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  query['ids'] = query['ids'] ?? '';
  final data = {
    'id': query['pid'],
    'tracks': json.encode(
      query['ids'].toString().split(',').map((e) => {'type': 3, 'id': e}).toList(),
    ),
  };
  return request(
    'POST',
    'https://music.163.com/api/playlist/track/delete',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 收藏单曲到歌单 从歌单删除歌曲
Handler playlistTracks = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  final tracks = query['tracks'].toString().split(',').toList();

  final data = {
    'op': query['op'], // del,add
    'pid': query['pid'], // 歌单id
    'trackIds': json.encode(tracks), // 歌曲id
    'imme': 'true'
  };

  return request(
    'POST',
    'https://music.163.com/api/playlist/manipulate/tracks',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 编辑歌单
Handler playlistUpdate = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  query['desc'] = query['desc'] ?? '';
  query['tags'] = query['tags'] ?? '';
  final data = {
    '/api/playlist/desc/update': '{"id":${query['id']},"desc":"${query['desc']}"}',
    '/api/playlist/tags/update': '{"id":${query['id']},"tags":"${query['tags']}"}',
    '/api/playlist/update/name': '`{"id":${query['id']},"name":"${query['name']}"}',
  };

  return request(
    'POST',
    'https://music.163.com/weapi/batch',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

Handler playlisVideoRecent = (query, cookie) {
  final data = {};

  return request(
    'POST',
    'https://music.163.com/api/playlist/video/recent',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 公开隐私歌单
Handler playlisPrivacy = (query, cookie) {
  final data = {
    'id': query['id'],
    'privacy': 0,
  };

  return request(
    'POST',
    'https://interface.music.163.com/eapi/playlist/update/privacy',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
