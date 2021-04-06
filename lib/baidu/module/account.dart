part of '../module.dart';

/*
  * 登出
 */
Handler logout = (Map query, auth) {
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/account/logout",
    LinkedHashMap(),
    authorization: auth,
  );
};

/*
  * 账户信息
 */
Handler accountInfo = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/account/info",
    LinkedHashMap(),
    authorization: auth,
  );
};

/*
  * 修改账户信息
  * @param age 年龄
  * @param avatar 头像（可为空，是一个完整的图片路径，上传方式请查看说明文档）
  * @param birth 生日
  * @param nickname 昵称
  * @param sex 性别（0，保密，1，男,2女）
  * @param intro 简介
 */
Handler changeAccountInfo = (Map query, auth) {
  final data = LinkedHashMap();
  data["nickname"] = query['nickname'];
  data["age"] = query['age'];
  if (query['avatar'].toString().isNotEmpty) {
    data["avatar"] = query['avatar'];
  }
  data["birth"] = query['birth'];
  data["sex"] = query['sex'];
  if (query['intro'] != null) {
    data["intro"] = query['intro'];
  }
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/account/info",
    data,
    authorization: auth,
  );
};

/*
  *账户歌曲列表(喜欢的歌曲？)
 */
Handler accountSongList = (Map query, auth) {
  final data = LinkedHashMap();
  data["pageNo"] = query['page'] ?? 1;
  data["pageSize"] = query['size'] ?? 20;

  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/account/songlist",
    data,
    authorization: auth,
  );
};

/*
  *账户收藏等信息
 */
Handler accountAmount = (Map query, auth) {
  final data = LinkedHashMap();

  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/account/amount",
    data,
    authorization: auth,
  );
};

/*
 *已购专辑
 */
Handler accountPurchaseAlbum = (Map query, auth) {
  final data = LinkedHashMap();
  data["pageNo"] = query['page'] ?? 1;
  data["pageSize"] = query['size'] ?? 20;

  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/account/purchase/album",
    data,
    authorization: auth,
  );
};

/*
 *已购单曲
 */
Handler accountPurchase = (Map query, auth) {
  final data = LinkedHashMap();
  data["pageNo"] = query['page'] ?? 1;
  data["pageSize"] = query['size'] ?? 20;

  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/account/purchase",
    data,
    authorization: auth,
  );
};
