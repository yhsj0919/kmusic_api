part of '../module.dart';

// 国家编码列表
Handler countriesCodeList = (query, cookie) {
  return eapiRequest(
    'https://interface3.music.163.com/eapi/lbs/countries/v1',
    '/api/lbs/countries/v1',
    {},
    cookies: cookie,
  );
};
