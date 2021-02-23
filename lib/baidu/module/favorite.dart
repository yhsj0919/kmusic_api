part of '../module.dart';

/*
 * 收藏的歌曲
 */
Handler favoriteSong = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/favorite/song",
    LinkedHashMap.of({
      "pageNo": query['pageNo'] ?? 1,
      "pageSize": query['size'] ?? 20,
    }),
    authorization: auth,
  );
};

/*
 * 收藏歌曲
 */
Handler favoriteSongCreate = (Map query, auth) {
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/favorite/song/create",
    LinkedHashMap.of({
      "code": query['code'],
    }),
    authorization: auth,
  );
};

/*
 * 删除收藏歌曲
 */
Handler favoriteSongDelete = (Map query, auth) {
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/favorite/song/delete",
    LinkedHashMap.of({
      "code": query['code'],
    }),
    authorization: auth,
  );
};

/*
 * 收藏的歌单
 */
Handler favoriteTrackList = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/favorite/tracklist",
    LinkedHashMap.of({
      "pageNo": query['pageNo'] ?? 1,
      "pageSize": query['size'] ?? 20,
    }),
    authorization: auth,
  );
};

/*
 * 收藏歌单
 */
Handler favoriteTrackListCreate = (Map query, auth) {
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/favorite/tracklist/create",
    LinkedHashMap.of({
      "code": query['code'],
    }),
    authorization: auth,
  );
};

/*
 * 删除收藏歌单
 */
Handler favoriteTrackListDelete = (Map query, auth) {
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/favorite/tracklist/delete",
    LinkedHashMap.of({
      "code": query['code'],
    }),
    authorization: auth,
  );
};

/*
 * 收藏的歌手
 */
Handler favoriteArtist = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/favorite/artist",
    LinkedHashMap.of({
      "pageNo": query['pageNo'] ?? 1,
      "pageSize": query['size'] ?? 20,
    }),
    authorization: auth,
  );
};

/*
 * 收藏歌手
 */
Handler favoriteArtistCreate = (Map query, auth) {
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/favorite/artist/create",
    LinkedHashMap.of({
      "code": query['code'],
    }),
    authorization: auth,
  );
};

/*
 * 删除收藏歌手
 */
Handler favoriteArtistDelete = (Map query, auth) {
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/favorite/artist/delete",
    LinkedHashMap.of({
      "code": query['code'],
    }),
    authorization: auth,
  );
};
