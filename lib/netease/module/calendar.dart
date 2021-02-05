part of '../module.dart';

Handler calendar = (query, cookie) {
  final data = {
    'startTime': query['startTime'] ?? DateTime.now(),
    'endTime': query['endTime'] ?? DateTime.now(),
  };
  return request(
    'POST',
    'https://music.163.com/api/mcalendar/detail',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
