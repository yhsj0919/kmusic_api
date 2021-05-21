part of '../module.dart';

/*
 * 歌手列表
 * @param page 从1开始
 * @param size 默认20
 * @param artistGender 性别(男、女、组合、乐队),值是写死的;
 * 这个不传不分页;
 * 这个参数必须在地区之前，不然获取不到值
 * @param artistRegion 地区(内地、港台、欧美、韩国、日本、其他),值是写死的,这个不传不分页
*/
Handler artistList = (Map query, auth) {
  final data = LinkedHashMap();
  if (query.containsKey('artistGender')) {
    data["artistGender"] = query['artistGender'];
  }
  if (query.containsKey('artistRegion')) {
    data["artistRegion"] = query['artistRegion'];
  }

  if (data.isNotEmpty) {
    data["pageNo"] = query['page'] ?? 1;
    data["pageSize"] = query['size'] ?? 20;
  }
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/artist/list",
    data,
    authorization: auth,
  );
};

/*
 * 歌手详情
 * @param artistCode 歌手Id
*/
Handler artistInfo = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/artist/info",
    LinkedHashMap.of({
      "artistCode": query['artistCode'],
    }),
    authorization: auth,
  );
};

/*
 * 歌手热门歌曲
 * @param artistCode 歌手Id
*/
Handler artistSong = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/artist/song",
    LinkedHashMap.of({
      'appid': '16073360',
      "artistCode": query['artistCode'],
      "pageNo": query['page'] ?? 1,
      "pageSize": query['size'] ?? 20,
    }),
    authorization: auth,
  );
};

/*
 * 歌手热门专辑
 * @param artistCode 歌手Id
*/
Handler artistAlbum = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/artist/album",
    LinkedHashMap.of({
      'appid': '16073360',
      "artistCode": query['artistCode'],
      "pageNo": query['page'] ?? 1,
      "pageSize": query['size'] ?? 20,
    }),
    authorization: auth,
  );
};
