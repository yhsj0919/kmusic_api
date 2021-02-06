part of '../module.dart';

Handler scrobble = (query, cookie) {
  final data = {
    'logs': json.encode([
      {
        'action': 'play',
        'json': {
          'download': 0,
          'end': 'playend',
          'id': query['id'],
          'sourceId': query['sourceId'],
          'time': query['time'],
          'type': 'song',
        }
      }
    ]),
  };

  return request(
    'POST',
    'https://music.163.com/weapi/feedback/weblog',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
