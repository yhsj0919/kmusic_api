part of '../module.dart';

/*
 * 全部MV
 * order 1，最新，0最热
 */
Handler mvlist = (Map query, cookie) {
  final page = query['page'] ?? 1;
  final size = query['size'] ?? 20;
  final sin = (page - 1) * size;

  final data = {
    "data": json.encode({
      "comm": {"ct": 24},
      "mv_tag": {"module": "MvService.MvInfoProServer", "method": "GetAllocTag", "param": {}},
      "mv_list": {
        "module": "MvService.MvInfoProServer",
        "method": "GetAllocMvInfo",
        "param": {"start": sin, "size": size, "version_id": 7, "area_id": 15, "order": 1}
      }
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};

/*
 *mv信息，更多推荐
 */
Handler mvInfo = (Map query, cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 4747474},
      "mvinfo": {
        "module": "video.VideoDataServer",
        "method": "get_video_info_batch",
        "param": {
          "vidlist": ["w0026q7f01a"],
          "required": [
            "vid",
            "type",
            "sid",
            "cover_pic",
            "duration",
            "singers",
            "video_switch",
            "msg",
            "name",
            "desc",
            "playcnt",
            "pubdate",
            "isfav",
            "gmid",
          ],
        }
      },
      "other": {
        "module": "video.VideoLogicServer",
        "method": "rec_video_byvid",
        "param": {
          "vid": "w0026q7f01a",
          "required": [
            "vid",
            "type",
            "sid",
            "cover_pic",
            "duration",
            "singers",
            "video_switch",
            "msg",
            "name",
            "desc",
            "playcnt",
            "pubdate",
            "isfav",
            "gmid",
            "uploader_headurl",
            "uploader_nick",
            "uploader_encuin",
            "uploader_uin",
            "uploader_hasfollow",
            "uploader_follower_num"
          ],
          "support": 1
        }
      }
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};
/*
* MV播放地址
 */
Handler mvUrl = (Map query, cookie) {
  final data = {
    "comm": {"ct": 24, "cv": 4747474, "g_tk": 812935580, "uin": 0, "format": "json", "platform": "yqq"},
    "data": json.encode({
      "mvUrl": {
        "module": "gosrf.Stream.MvUrlProxy",
        "method": "GetMvUrls",
        "param": {
          "vids": ["w0026q7f01a"],
          "request_typet": 10001,
          "addrtype": 3,
          "format": 264
        }
      },
    })
  };
  return request(
    'GET',
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    data,
    cookies: cookie,
  );
};
