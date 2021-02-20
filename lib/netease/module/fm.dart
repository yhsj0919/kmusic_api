part of '../module.dart';

// 垃圾桶
//说明 : 调用此接口 , 传入音乐 id, 可把该音乐从私人 FM 中移除至垃圾桶
Handler fmTrash = (query, cookie) {
  final data = {
    'songId': query['id'],
  };
  return request(
    'POST',
    'https://music.163.com/weapi/radio/trash/add?alg=RT&songId=${query['id']}&time=${query['time'] ?? 25}',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
