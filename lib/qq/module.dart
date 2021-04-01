import 'dart:convert';
import 'dart:io';
import 'package:kmusic_api/qq/util/qq_request.dart';
import 'package:kmusic_api/utils/answer.dart';

part 'module/album.dart';

part 'module/mv.dart';

part 'module/playlist.dart';

part 'module/radio.dart';

part 'module/singer.dart';

part 'module/song.dart';

part 'module/toplist.dart';

typedef Handler = Future<Answer> Function(Map query, List<Cookie> cookie);

final handles = <String, Handler>{
  "/singer/list": singerList,
  "/singer/info": singerInfo,
  "/singer/song": singerSong,
  "/singer/album": singerAlbum,
  "/singer/mv": singerMV,
  "/singer/similarSinger": singerSimilarSinger,
  "/song/info": songInfo,
  "/song/lyric": songLyric,
  "/song/mv": songMv,
  "/song/listen": songListen,
  "/song/download": songDownload,
  "/song/playList": songPlayList,
  "/song/comment": songComment,
  "/mv/info": mvInfo,
  "/mv/url": mvUrl,
  "/toplist/info": toplistInfo,
  "/toplist/detail": toplistDetail,
  "/playlist": playlistByTag,
  "/radiolist": radiolist,
};
