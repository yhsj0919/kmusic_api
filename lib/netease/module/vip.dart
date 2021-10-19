part of '../module.dart';

// 会员成长值
Handler vipGrowthpoint = (query, cookies) {
  final data = {};
  return request(
    'POST',
    'https://music.163.com/weapi/vipnewcenter/app/level/growhpoint/basic',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
// 会员成长值领取记录
Handler vipGrowthpointDetail = (query, cookies) {
  final data = {
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/vipnewcenter/app/level/growth/details',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

// 领取会员成长值
Handler vipGrowthpointGet = (query, cookies) {
  final data = {
    'taskIds': query['ids'],
  };
  return request(
    'POST',
    'https://music.163.com/weapi/vipnewcenter/app/level/task/reward/get',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

// 会员任务
Handler vipTasks = (query, cookies) {
  final data = {};
  return request(
    'POST',
    'https://music.163.com/weapi/vipnewcenter/app/level/task/list',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
// 获取 VIP 信息
Handler vipInfo = (query, cookies) {
  final data = {};
  return request(
    'POST',
    'https://music.163.com/weapi/music-vip-membership/front/vip/info',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
