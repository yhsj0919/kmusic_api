part of '../module.dart';

//专辑评论
Handler commentAlbum = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));

  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0,
    'beforeTime': query['before'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/resource/comments/R_AL_3_${query["id"]}',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

//电台评论
Handler commentDj = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));
  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0,
    'beforeTime': query['before'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/resource/comments/A_DJ_1_${query["id"]}',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

// 获取动态评论
Handler commentEvents = (query, cookies) {
  final data = {
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/resource/comments/${query["threadId"]}',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
//楼层评论
Handler commentFloor = (query, cookies) {
  final data = {
    'parentCommentId': query['parentCommentId'],
    'threadId': query['type'] + query['id'],
    'time': query['time'] ?? -1,
    'limit': query['limit'] ?? 20,
  };
  return request(
    'POST',
    'https://music.163.com/api/resource/comment/floor/get',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

// 热门评论
Handler commentHot = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));

  query['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'R_EV_2_', //  动态
  }[query['type']];

  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0,
    'beforeTime': query['before'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/resource/hotcomments/${query["type"]}${query["id"]}',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

//评论抱一抱列表
Handler commentHugList = (query, cookies) {
  cookies.add(Cookie('os', 'ios'));
  cookies.add(Cookie('appver', '8.1.20'));

  query['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'R_EV_2_', //  动态
  }[query['type']];

  final data = {
    'targetUserId': query['uid'],
    'commentId': query['cid'],
    'cursor': query['cursor'] ?? '-1',
    'threadId': query['type'] + query['id'],
    'pageNo': query['page'] ?? 1,
    'idCursor': query['idCursor'] ?? -1,
    'pageSize': query['pageSize'] ?? 100,
  };

  return request(
    'POST',
    'https://music.163.com/api/v2/resource/comments/hug/list',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

Handler commentHugListener = (query, cookies) {
  cookies.add(Cookie('os', 'ios'));
  cookies.add(Cookie('appver', '8.0.00'));

  query['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'R_EV_2_', //  动态
  }[query['type']];

  final data = {
    'targetUserId': query['uid'],
    'commentId': query['cid'],
    'threadId': query['type'] + query['id'],
  };

  return request(
    'POST',
    'https://music.163.com/api/v2/resource/comments/hug/listener',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

// 点赞与取消点赞评论
Handler commentLike = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));

  final t = query['t'] == 1 ? 'like' : 'unlike';

  query['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'R_EV_2_', //  动态
  }[query['type']];

  final data = {
    'threadId': query['type'] + query['id'],
    'commentId': query['cid']
  };
  if (query['type'] == 'A_EV_2_') {
    data['threadId'] = query['threadId'];
  }
  return request(
    'POST',
    'https://music.163.com/weapi/v1/comment/$t',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

//歌曲评论
Handler commentMusic = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));

  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0,
    'beforeTime': query['before'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/resource/comments/R_SO_4_${query["id"]}',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

//mv评论
Handler commentMv = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));

  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0,
    'beforeTime': query['before'] ?? 0,
  };
  return request(
      'POST',
      'https://music.163.com/weapi/v1/resource/comments/R_MV_5_${query["id"]}',
      data,
      crypto: Crypto.weapi,
      cookies: cookies);
};

//歌单评论
Handler commentPlaylist = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));
  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0,
    'beforeTime': query['before'] ?? 0,
  };
  return request(
      'POST',
      'https://music.163.com/weapi/v1/resource/comments/A_PL_0_${query["id"]}',
      data,
      crypto: Crypto.weapi,
      cookies: cookies);
};

//视频评论
Handler commentVideo = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));
  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0,
    'beforeTime': query['before'] ?? 0,
  };
  return request(
      'POST',
      'https://music.163.com/weapi/v1/resource/comments/R_VI_62_${query["id"]}',
      data,
      crypto: Crypto.weapi,
      cookies: cookies);
};

//评论
Handler commentNew = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));
  query['t'] = (query['t'] == 1 ? 'add' : 'delete');
  query['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'A_EV_2_' //  动态
  }[query['type']];

  final pageNo = query['pageNo'] ?? 1;
  final pageSize = query['pageSize'] ?? 20;

  final data = {
    'threadId': query['type'] + query['id'],
    'pageNo': pageNo,
    'pageSize': pageSize,
    'showInner': query['showInner'] ?? true,
    'cursor':
        query['sortType'] == 3 ? query['cursor'] ?? 0 : (pageNo - 1) * pageSize,
    'sortType': query['sortType'] ?? 1 //1:按推荐排序,2:按热度排序,3:按时间排序
  };

  return eapiRequest(
    'https://music.163.com/api/v2/resource/comments',
    '/api/v2/resource/comments',
    data,
    cookies: cookies,
  );
};

//发送与删除评论
Handler comment = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));
  query['t'] = const {
    0: 'delete',
    1: 'add',
    2: 'reply',
  }[query['t'] ?? 1];
  query['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'A_EV_2_' //  动态
  }[query['type']];

  final data = {
    'threadId': query['type'] + query['id'],
  };
  if (query['type'] == 'A_EV_2_') {
    data['threadId'] = query['threadId'];
  }

  if (query['t'] == 'add') {
    data['content'] = query['content'];
  } else if (query['t'] == 'delete') {
    data['commentId'] = query['commentId'];
  } else if (query['t'] == 'reply') {
    data['commentId'] = query['commentId'];
    data['content'] = query['content'];
  }
  return request(
    'POST',
    'https://music.163.com/weapi/resource/comments/${query["t"]}',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
