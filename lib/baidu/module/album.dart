part of '../module.dart';

/*
 * 专辑信息
 * @param albumAssetCode 专辑Id
*/
Handler albumInfo = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/album/info",
    LinkedHashMap.of({
      "albumAssetCode": query['albumAssetCode'],
      "appid": '16073360',
    }),
    authorization: auth,
  );
};

/*
 * 专辑列表，最新专辑
 * @param page 从1开始
 * @param size 默认20
*/
Handler albumList = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/album/list",
    LinkedHashMap.of({
      "pageNo": query['pageNo'] ?? 1,
      "pageSize": query['size'] ?? 20,
    }),
    authorization: auth,
  );
};
