part of '../module.dart';

// 账号云豆数
Handler musicianCloudBean = (query, cookies) {
  final data = {};
  return request(
    'POST',
    'https://music.163.com/weapi/cloudbean/get',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
// 领取云豆
Handler musicianCloudBeanObtain = (query, cookies) {
  final data = {
    'userMissionId': query['id'],
    'period': query['period'],
  };
  return request(
    'POST',
    'https://music.163.com/weapi/nmusician/workbench/mission/reward/obtain/new',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
// 音乐人数据概况
Handler musicianDataOverview = (query, cookies) {
  final data = {};
  return request(
    'POST',
    'https://music.163.com/weapi/creator/musician/statistic/data/overview/get',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
// 音乐人歌曲播放趋势
Handler musicianPlayTrend = (query, cookies) {
  final data = {
    'startTime': query['startTime'],
    'endTime': query['endTime'],
  };
  return request(
    'POST',
    'https://music.163.com/weapi/creator/musician/play/count/statistic/data/trend/get',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};

// 音乐人歌曲播放趋势
Handler musicianTask = (query, cookies) {
  final data = {};
  return request(
    'POST',
    'https://music.163.com/weapi/nmusician/workbench/mission/cycle/list',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
// 音乐人签到
Handler musicianSign = (query, cookies) {
  final data = {};
  return request(
    'POST',
    'https://music.163.com/weapi/creator/user/access',
    data,
    crypto: Crypto.weapi,
    cookies: cookies,
  );
};
