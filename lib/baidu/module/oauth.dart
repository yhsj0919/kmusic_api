part of '../module.dart';

/*
 * 发送短信验证码
 * @param phone 手机号
*/
Handler sendSms = (Map query, auth) {
  final data = LinkedHashMap();
  data['phone'] = query['phone'];
  data['randstr'] = '@arV';
  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/oauth/send_sms",
    data,
    authorization: auth,
  );
};

/*
 * 登录
 * @param phone 手机号
 * @param code 验证码
 * NjVhNTMzM2QyZWEyZTlhOTI5OTJiMjZiNWE2YTkwMjY=
*/
Handler login = (Map query, auth) {
  final data = LinkedHashMap();
  data['code'] = query['code'];
  data['phone'] = query['phone'];

  return request(
    'POST',
    "https://api-qianqian.taihe.com/v1/oauth/login",
    data,
    authorization: auth,
  );
};
