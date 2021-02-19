part of '../module.dart';

// 视频点赞转发评论数数据
Handler videoDetailInfo = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/comment/commentthread/info',
    {
      'threadid': "R_VI_62_${query['vid']}",
      'composeliked': true,
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 视频详情
Handler videoDetail = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/cloudvideo/v1/video/detail',
    {
      'id': query['id'],
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 视频标签列表
Handler videoGroupList = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/cloudvideo/group/list',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 视频标签/分类下的视频
Handler videoGroup = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/videotimeline/videogroup/otherclient/get',
    {
      'groupId': query['id'],
      'offset': query['offset'] ?? 0,
      'need_preview_url': 'true',
      'total': true,
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 收藏与取消收藏视频
Handler videoSub = (query, cookie) {
  query['t'] = (query['t'] == 1 ? 'sub' : 'unsub');
  return request(
    'POST',
    'https://music.163.com/weapi/cloudvideo/video/${query["t"]}',
    {
      'id': query['id'],
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 全部视频列表
Handler videoTimelineAll = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/videotimeline/otherclient/get',
    {
      'groupId': 0,
      'offset': query['offset'] ?? 0,
      'need_preview_url': 'true',
      'total': true,
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 推荐视频
Handler videoTimelineRecommend = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/videotimeline/get',
    {
      'offset': query['offset'] ?? 0,
      'filterLives': '[]',
      'withProgramInfo': 'true',
      'needUrl': '1',
      'resolution': 480,
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 视频链接
Handler videoUrl = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/cloudvideo/playurl',
    {
      'ids': '["' + query['id'] + '"]',
      'resolution': query['res'] ?? 1080,
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
