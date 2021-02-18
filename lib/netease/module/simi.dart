part of '../module.dart';

// 相似歌手
Handler simiArtist = (query, cookie) {
  if (cookie.where((element) => element.name == "MUSIC_U").length == 0) {
    cookie.add(Cookie('MUSIC_A',
        '8aae43f148f990410b9a2af38324af24e87ab9227c9265627ddd10145db744295fcd8701dc45b1ab8985e142f491516295dd965bae848761274a577a62b0fdc54a50284d1e434dcc04ca6d1a52333c9a'));
  }

  return request(
    'POST',
    'https://music.163.com/weapi/discovery/simiArtist',
    {
      'artistid': query['id'],
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 相似MV
Handler simiMv = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/discovery/simiMv',
    {
      'mvid': query['mvid'],
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 相似歌单
Handler simiPlaylist = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/discovery/simiPlaylist',
      {
        'playlistid': query['playlistid'],
        'limit': query['limit'] ?? 50,
        'offset': query['offset'] ?? 0
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 相似歌曲
Handler simiSong = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/discovery/simiSong',
    {
      'songid': query['id'],
      'limit': query['limit'] ?? 50,
      'offset': query['offset'] ?? 0
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

Handler simiUser = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/discovery/simiUser',
    {
      'songid': query['id'],
      'limit': query['limit'] ?? 50,
      'offset': query['offset'] ?? 0
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
