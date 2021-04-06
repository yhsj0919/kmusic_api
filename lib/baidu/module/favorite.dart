part of '../module.dart';

//收藏
//restype:video,artist,song,tracklist,album
Handler favorite = (Map query, auth) {
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/favorite/create",
    LinkedHashMap.of({
      "code": query['code'],
      "restype": query['restype'],
    }),
    authorization: auth,
  );
};
//取消收藏
//restype:video,artist,song,tracklist,album
Handler favoriteDelete = (Map query, auth) {
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/favorite/delete",
    LinkedHashMap.of({
      "code": query['code'],
      "restype": query['restype'],
    }),
    authorization: auth,
  );
};

/*
 * 收藏的列表
 * restype:video,artist,song,tracklist,album
 */
Handler favoriteList = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/favorite/song",
    LinkedHashMap.of({
      "pageNo": query['pageNo'] ?? 1,
      "pageSize": query['size'] ?? 20,
      "restype": query['restype'],
    }),
    authorization: auth,
  );
};
