part of '../module.dart';

//云盘歌曲信息匹配纠正
Handler cloudMatch = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));
  cookies.add(Cookie('appver', '8.1.20'));

  final data = {
    'userId': query['uid'],
    'songId': query['sid'],
    'adjustSongId': query['asid'],
  };
  return request(
    'POST',
    'https://music.163.com/api/cloud/user/song/match',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
