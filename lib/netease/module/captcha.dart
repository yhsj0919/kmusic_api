part of '../module.dart';

// 发送验证码
Handler captchaSend = (query, cookie) {
  final data = {
    'ctcode': query['ctcode'] ?? '86',
    'cellphone': query['phone'],
  };
  return request(
    'POST',
    'https://music.163.com/api/sms/captcha/sent',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

//校验验证码
Handler captchaVerify = (query, cookie) {
  final data = {
    'ctcode': query['ctcode'] ?? '86',
    'cellphone': query['phone'],
    'captcha': query['captcha']
  };
  return request(
    'POST',
    'https://music.163.com/weapi/sms/captcha/verify',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
