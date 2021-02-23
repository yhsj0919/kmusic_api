part of '../module.dart';

/*
 * 榜单分类
*/
Handler bdCategory = (Map query, auth) {
  final data = LinkedHashMap();

  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/bd/category",
    data,
    authorization: auth,
  );
};

/*
 * 榜单列表
*/
Handler bdList = (Map query, auth) {
  final data = LinkedHashMap();
  data['bdid'] = query['bdid'];
  data['pageNo'] = query['page'] ?? 1;
  data['pageSize'] = query['size'] ?? 20;
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/bd/list",
    data,
    authorization: auth,
  );
};
