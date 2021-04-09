part of '../module.dart';

/*
 * 搜索
 * @param type 0全部、1单曲、3专辑、2歌手
 * 0没有分页，其他有 pageNo、pageSize
 * @param word 搜索关键词
*/
Handler search = (Map query, auth) {
  final data = LinkedHashMap();
  if (query['type'] != 0) {
    data['pageNo'] = query['page'] ?? 1;
    data['pageSize'] = query['size'] ?? 20;
    data['timestamp'] = DateTime.now().millisecondsSinceEpoch;
    data['type'] = query['type'];
    data['word'] = query['word'];
  } else {
    data['timestamp'] = DateTime.now().millisecondsSinceEpoch;
    data['type'] = query['type'];
    data['word'] = query['word'];
  }

  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/search",
    data,
    authorization: auth,
  );
};

/*
 * 搜索热词
 * @param word 搜索关键词
*/
Handler searchSug = (Map query, auth) {
  final data = LinkedHashMap();
  data['timestamp'] = DateTime.now().millisecondsSinceEpoch;
  data['word'] = query['word'];
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/search/sug",
    data,
    authorization: auth,
  );
};
