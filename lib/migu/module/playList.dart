part of '../module.dart';

/*
* 歌单热门标签
 */
Handler playListHotTag = (Map query, cookie) {
  final data = {};
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/musiclistplaza-hottaglist/release",
    data,
    cookies: cookie,
  );
};
/*
* 歌单热门推荐(歌单最顶上的几个)
 */
Handler playListRec = (Map query, cookie) {
  final data = {};
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/musiclistplaza-header/release",
    data,
    cookies: cookie,
  );
};

/*
* 歌单播放量
 */
Handler playListPlayNum = (Map query, cookie) {
  final data = {
    'id': (query['contentIds'] as List).join("|"),
    'resourceType': (query['contentType'] as List).join("|"),
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/content/queryOPNumItemsAction.do",
    data,
    cookies: cookie,
  );
};

/*
* 歌单播放量
 */
Handler playList = (Map query, cookie) {
  final data = {
    'pageNumber': query['page'] ?? '1',
    'tagId': query['tagId'],
    'templateVersion': '1',
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/musiclistplaza-listbytag/release",
    data,
    cookies: cookie,
  );
};

/*
* 歌单全部标签
 */
Handler playListTagList = (Map query, cookie) {
  final data = {
    'templateVersion': '1',
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/musiclistplaza-taglist/release",
    data,
    cookies: cookie,
  );
};

/*
* 歌单信息(包含创建者信息)
 */
Handler playListInfo = (Map query, cookie) {
  final data = {
    'needSimple': '00',
    'resourceId': query['id'],
    'resourceType': query['type'],
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do",
    data,
    cookies: cookie,
  );
};

/*
* 歌单歌曲
 */
Handler playListSong = (Map query, cookie) {
  final data = {
    'pageNo': query['page'] ?? 1,
    'pageSize': query['size'] ?? 50,
    'playlistId': query['id'],
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/resource/playlist/song/v2.0",
    data,
    cookies: cookie,
  );
};
