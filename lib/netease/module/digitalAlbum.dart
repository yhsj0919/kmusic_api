part of '../module.dart';

// 购买数字专辑
Handler digitalAlbumOrdering = (query, cookie) {
  final data = {
    'business': 'Album',
    'paymentMethod': query['paymentMethod'],
    'digitalResources': json.encode({
      "business": 'Album',
      'resourceID': query['id'],
      'quantity': query['quantity'],
    }),
    "from": 'web',
  };

  return request(
    'POST',
    'https://music.163.com/api/digitalAlbum/purchased',
    data,
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

//我的数字专辑
Handler digitalAlbumPurchased = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/digitalAlbum/purchased',
    {
      'limit': query['limit'] ?? 30,
      'offset': query['offset'] ?? 0,
      'total': true,
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
