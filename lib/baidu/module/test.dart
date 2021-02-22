part of '../module.dart';

Handler test = (Map query, auth) {
  return request(
    'GET',
    "https://api-qianqian.taihe.com/v1/ad/openscreen",
    LinkedHashMap(),
    authorization: auth,
  );
};
