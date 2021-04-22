part of '../module.dart';

/*
* 首页
 */
Handler home = (Map query, cookie) {
  final num = query['num'] ?? 20;
  final page = query['page'] ?? 1;
  final start = (page - 1) * num;

  final data = {
    "data": json.encode({
      "req_0": {
        "module": "MvService.MvInfoProServer",
        "method": "GetNewMv",
        "param": {"style": 0, "tag": 0, "start": 0, "size": 8}
      },
      "req_1": {
        "module": "music.musicHall.MusicHallPlatform",
        "method": "GetFocus",
        "param": {
          "Device": {"OS": "3", "AppName": "QQ音乐"}
        }
      },
      "req_2": {
        "module": "playlist.HotRecommendServer",
        "method": "get_new_hot_recommend",
        "param": {"cmd": 0, "page": 0, "daily_page": 0, "size": 12}
      },
      "req_3": {
        "module": "newsong.NewSongServer",
        "method": "get_new_song_info",
        "param": {"type": 5}
      },
      "req_4": {
        "module": "music.longRadio.recommend",
        "method": "getRadioList",
        "param": {"pos": 6}
      },
      "comm": {"ct": 20, "cv": 1807,}
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};
