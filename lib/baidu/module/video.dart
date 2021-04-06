part of '../module.dart';

//精选视频
Handler videoList = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/video/list",
    LinkedHashMap.of({
      // "appid": '16073360',
      "pageNo": query['pageNo'] ?? 1,
      "pageSize": query['size'] ?? 20,
    }),
    authorization: auth,
  );
};

//视频详情
Handler videoInfo = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/video/info",
    LinkedHashMap.of({
      // "appid": '16073360',
      "assetCode": query['assetCode'],
      "rate": query['rate'] ?? '720',
    }),
    authorization: auth,
  );
};

//热门视频、视频推荐
Handler videoRecommend = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/video/recommend",
    LinkedHashMap.of({}),
    authorization: auth,
  );
};
//视频下载
Handler videoDownload = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/video/download",
    LinkedHashMap.of({
      // "appid": '16073360',
      "assetCode": query['assetCode'],
      "rate": query['rate'] ?? '720',
    }),
    authorization: auth,
  );
};
