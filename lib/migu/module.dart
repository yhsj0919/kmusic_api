import 'dart:io';

import 'package:kmusic_api/migu/util/migu_request.dart';
import 'package:kmusic_api/utils/answer.dart';

part 'module/album.dart';

part 'module/playList.dart';

part 'module/singer.dart';

part 'module/song.dart';

part 'module/topList.dart';

typedef Handler = Future<Answer> Function(Map query, List<Cookie> cookie);

final handles = <String, Handler>{
  "/album": album,
  "/playList/hotTag": playListHotTag,
  "/playList/rec": playListRec,
  "/playList/playNum": playListPlayNum,
  "/playList": playList,
  "/playList/tagList": playListTagList,
  "/playList/info": playListInfo,
  "/playList/song": playListSong,
  "/song/url": playUrl,
  "/topList": topList,
  "/topList/detail": topListDetail,
};
