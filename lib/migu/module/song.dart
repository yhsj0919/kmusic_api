part of '../module.dart';

/*
* 新歌
 */
Handler songNewWeb = (Map query, cookie) {
  final data = {
    "pageSize": 10,
    "nid": 23853978,
    "pageNo": 0,
  };
  return request(
    'GET',
    "https://m.music.migu.cn/migu/remoting/cms_list_tag",
    data,
    cookies: cookie,
  );
};

/*
 * 新歌类型
 */
Handler songNewType = (Map query, cookie) {
  final data = {
    "templateVersion": 4,
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/get-new-music-list-header",
    data,
    cookies: cookie,
  ).then((value) {
    final data = value.body;
    final contentItemList = data['data']['contentItemList'] as List;
    final itemList = contentItemList[0]['itemList'] as List;
    data['data']['contentItemList'] = itemList.map((e) {
      final actionUrl = e['actionUrl'];
      final columnId = Uri.parse(actionUrl).queryParameters['columnId'];
      e['columnId'] = columnId;
      return e;
    }).toString();
    final resp = value.copy(body: data);
    return Future.value(resp);
  });
};

/*
 * 新歌
 */
Handler songNew = (Map query, cookie) {
  final data = {
    "columnId": query['query'] ?? 15279065,
    "count": query['size'] ?? 20,
    "start": query['page'] ?? 1,
    "templateVersion": 7,
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/new-music-list-data/release",
    data,
    cookies: cookie,
  );
};

/*
* 播放地址
 */
Handler playUrl = (Map query, cookie) {
  final data = {
    // "albumId": query['albumId'],
    "netType": '01',
    "resourceType": 2,
    "songId": query['songId'],
    "toneFlag": query['toneFlag'] ?? 'PQ',
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM2.0/strategy/listen-url/v2.3",
    data,
    cookies: cookie,
  );
};
