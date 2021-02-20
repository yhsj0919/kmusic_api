part of '../module.dart';

//云贝支出
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
//云贝账户信息
Handler yunbeiInfo = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/v1/user/info',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
//云贝收入
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
//云贝签到
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
//云贝完成任务
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

//云贝todo任务
Handler yunbeiTaskTodo = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/usertool/task/todo/query',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
//云贝所有任务
Handler yunbeiTask = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/usertool/task/list/all',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
//云贝今日签到信息
Handler yunbeiToday = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/point/today/get',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
//云贝
Handler yunbei = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/api/point/signed/get',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
