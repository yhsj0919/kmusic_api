part of '../module.dart';

//手机登录
Handler loginCellphone = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    'phone': query['phone'],
    'countrycode': query['countrycode'] ?? 86,
    'password': Encrypted(Uint8List.fromList(md5.convert(utf8.encode(query['password'])).bytes)).base16,
    'rememberLogin': 'true'
  };

  return request(
    'POST',
    'https://music.163.com/weapi/login/cellphone',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
    ua: 'pc',
  );
};

// 二维码登录检测（轮询）
Handler loginQrCheck = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/login/qrcode/client/login',
    {
      'key': query['key'],
      'type': 1,
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

//返回二维码信息，自己去生成二维码
Handler loginQrCreate = (query, cookie) {
  final url = 'https://music.163.com/login?codekey=${query["key"]}';
  return Future.value(
    Answer(
      status: 200,
      body: {'qrurl': url},
    ),
  );
};

// 二维码Key
Handler loginQrKey = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/login/qrcode/unikey',
    {
      'type': 1,
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 登录刷新
Handler loginRefresh = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/login/token/refresh',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
    ua: 'pc',
  );
};

// 登录状态
Handler loginStatus = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/w/nuser/account/get',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
    ua: 'pc',
  );
};

// 邮箱登录
Handler login = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {'username': query['email'], 'password': Encrypted(Uint8List.fromList(md5.convert(utf8.encode(query['password'])).bytes)).base16, 'rememberLogin': 'true'};

  return request(
    'POST',
    'https://music.163.com/weapi/login',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
    ua: 'pc',
  );
};

// 退出登录
Handler logout = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/logout', {}, crypto: Crypto.weapi, cookies: cookie, ua: 'pc');
};

// 检测手机号码是否已经注册
Handler cellphoneExistenceCheck = (query, cookie) {
  final data = {'cellphone': query['phone'], 'countrycode': query['countrycode']};
  return eapiRequest(
    'http://music.163.com/eapi/cellphone/existence/check',
    '/api/cellphone/existence/check',
    data,
    cookies: cookie,
  );
};

// 检测用户名是否已经注册
Handler activateInitProfile = (query, cookie) {
  final data = {'nickname': query['nickname']};
  return eapiRequest(
    'http://music.163.com/eapi/activate/initProfile',
    '/api/activate/initProfile',
    data,
    cookies: cookie,
  );
};
