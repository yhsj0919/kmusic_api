part of '../module.dart';

//首页
Handler index = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/index",
    LinkedHashMap.of({'appid':'16073360'}),
    authorization: auth,
  );
};
