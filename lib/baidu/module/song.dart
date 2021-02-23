part of '../module.dart';

/*
 * 新歌推荐
 * @param page 从1开始
 * @param size 默认20
*/
Handler songList = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/song/list",
    LinkedHashMap.of({
      "pageNo": query['pageNo'] ?? 1,
      "pageSize": query['size'] ?? 20,
    }),
    authorization: auth,
  );
};

/*
 * 歌曲信息(播放地址。Vip歌曲只能获取30秒)
 * @param tsId 歌曲Id
*/
Handler songInfo = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/song/tracklink",
    LinkedHashMap.of({
      "TSID": query['tsId'],
      "rate": query['rate'] ?? 320,
    }),
    authorization: auth,
  );
};

/*
 * 歌曲下载
 * @param tsId 歌曲Id
*/
Handler songDownload = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/song/download",
    LinkedHashMap.of({
      "TSID": query['tsId'],
      "rate": query['rate'] ?? 320,
    }),
    authorization: auth,
  );
};
