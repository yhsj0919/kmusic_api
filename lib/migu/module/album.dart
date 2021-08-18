part of '../module.dart';

/*
* 新专辑、新碟
 */
Handler albumNewWeb = (Map query, cookie) async {
  final data = {
    "pageSize": 10,
    "nid": 23854016,
    "pageNo": 0,
    "type": 2003,
  };
  return request(
    'GET',
    "http://m.music.migu.cn/migu/remoting/cms_list_tag",
    data,
    cookies: cookie,
  );
};

/*
 * 新专辑类型
 */
Handler albumNewType = (Map query, cookie) async {
  final data = {
    "templateVersion": 7,
  };
  return request(
    'GET',
    "http://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/get-new-cd-list-header",
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
 * 全部专辑
 */
Handler albumNew = (Map query, cookie) async {
  final data = {
    "columnId": query['query'] ?? 15279065,
    "count": query['size'] ?? 20,
    "start": query['page'] ?? 1,
    "templateVersion": 7,
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/get-new-cd-list-data/release",
    data,
    cookies: cookie,
  );
};

/*
* 专辑歌曲
 */
Handler albumSong = (Map query, cookie) async {
  final data = {
    "resourceId": query['albumId'],
    "needSimple": query['needSimple'] ?? "01",
    "resourceType": query['type'] ?? "2003",
    "pageNo": query['page'] ?? 1,
    "pageSize": query['size'] ?? 50,
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do",
    data,
    cookies: cookie,
  );
};
Handler albumSong2 = (Map query, cookie) async {
  final data = {
    "albumId": query['albumId'],
    "pageNo": query['page'] ?? 1,
    "pageSize": query['size'] ?? 50,
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/resource/album/song/v2.0",
    data,
    cookies: cookie,
  );
};

/*
* 专辑信息
 */
Handler albumInfo = (Map query, cookie) async {
  final data = {
    "resourceId": query['albumId'],
    "needSimple": query['needSimple'] ?? "00",
    "resourceType": query['type'] ?? "2003",
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do",
    data,
    cookies: cookie,
  );
};

Handler albumInfo2 = (Map query, cookie) async {
  final data = {
    "albumId": query['albumId'],
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM3.0/resource/album/v2.0",
    data,
    cookies: cookie,
  );
};
