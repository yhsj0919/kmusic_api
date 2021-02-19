part of '../module.dart';

Handler yunbeiExpense = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/store/api/point/expense',
    {
      'limit': query['limit'] ?? 10,
      'offset': query['offset'] ?? 0,
    },
    crypto: Crypto.linuxapi,
    cookies: cookie,
  );
};

Handler yunbeiInfo = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/v1/user/info',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

Handler yunbeiReceipt = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/store/api/point/receipt',
    {
      'limit': query['limit'] ?? 10,
      'offset': query['offset'] ?? 0,
    },
    crypto: Crypto.linuxapi,
    cookies: cookie,
  );
};

Handler yunbeiSign = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/point/dailyTask',
    {
      'type': '0',
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

Handler yunbeiTaskFinish = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/usertool/task/point/receive',
    {
      'userTaskId': query['userTaskId'],
      'depositCode': query['depositCode'] ?? '0',
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

Handler yunbeiTaskTodo = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/usertool/task/todo/query',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

Handler yunbeiTask = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/usertool/task/list/all',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

Handler yunbeiToday = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/point/today/get',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

Handler yunbei = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/point/signed/get',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
