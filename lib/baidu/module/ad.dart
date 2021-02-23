part of '../module.dart';

//开屏
Handler openScreen = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/ad/openscreen",
    LinkedHashMap(),
    authorization: auth,
  );
};
