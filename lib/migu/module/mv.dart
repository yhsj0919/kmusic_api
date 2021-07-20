part of '../module.dart';

/*
* Mv资源信息
 */
Handler mvResource = (Map query, cookie) async {
  final data = {
    "resourceId": query['mvId'],
    "resourceType": 'D',
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do",
    data,
    cookies: cookie,
  );
};

/*
* MV播放地址
* 先在上面的资源接口拿到播放地址,然后在这里获取真实的播放地址
 */
Handler mvPlayUrl = (Map query, cookie) async {
  final data = {
    "concertId": query['mvId'],
    "mvContentId": query['mvId'],
    "mvCopyrightId": query['mvCopyrightId'],
    "format": query['format'],
    "size": query['size'],
    "type": query['type'] ?? '01',
    "url": Uri.encodeComponent(query['url'])
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/mvplayinfo.do",
    data,
    cookies: cookie,
  );
};

/*
* MV推荐
 */
Handler mvRec = (Map query, cookie) async {
  final data = {
    "pageNumber": query['page'] ?? '1',
    "resourceId": query['mvId'],
    "resourceType": query['resourceType'] ?? 'D',
  };
  return request(
    'GET',
    "https://app.c.nf.migu.cn/MIGUM2.0/v3.0/content/recommend-mv",
    data,
    cookies: cookie,
  );
};
