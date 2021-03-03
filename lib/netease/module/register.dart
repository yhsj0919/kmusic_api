part of '../module.dart';

//注册账号
Handler registerCellphone = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    'captcha': query['captcha'],
    'phone': query['phone'],
    'password':
        Encrypted(md5.convert(utf8.encode(query['password'])).bytes).base16,
    'nickname': query['nickname'],
    'countrycode': query['countrycode'] ?? '86'
  };
  return request(
    'POST',
    'https://music.163.com/weapi/register/cellphone',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
