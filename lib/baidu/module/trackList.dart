part of '../module.dart';

/*
 * 歌单分类
*/
Handler trackListCategory = (Map query, auth) {
  final data = LinkedHashMap();

  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/tracklist/category",
    data,
    authorization: auth,
  );
};

/*
 * 歌单分类详情
*/
Handler trackListList = (Map query, auth) {
  final data = LinkedHashMap();
  data['pageNo'] = query['page'] ?? 1;
  data['pageSize'] = query['size'] ?? 20;

  if (query['subCateId'].toString().isNotEmpty) {
    data['subCateId'] = query['subCateId'];
  }
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/tracklist/list",
    data,
    authorization: auth,
  );
};

/*
 * 歌单详情、推荐歌单
*/
Handler trackListInfo = (Map query, auth) {
  final data = LinkedHashMap();
  data['id'] = query['id'];
  data['pageNo'] = query['page'] ?? 1;
  data['pageSize'] = query['size'] ?? 20;
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/tracklist/info",
    data,
    authorization: auth,
  );
};
