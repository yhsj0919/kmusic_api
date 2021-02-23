part of '../module.dart';

/*
 * 签到
 */
Handler userSignin = (Map query, auth) {
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/user/points/signin",
    LinkedHashMap(),
    authorization: auth,
  );
};
