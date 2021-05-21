import 'dart:collection';

import 'package:kmusic_api/baidu/util/baidu_request.dart';
import 'package:kmusic_api/utils/answer.dart';

part 'module/account.dart';

part 'module/ad.dart';

part 'module/album.dart';

part 'module/artist.dart';

part 'module/bd.dart';

part 'module/favorite.dart';

part 'module/index.dart';

part 'module/oauth.dart';

part 'module/search.dart';

part 'module/song.dart';

part 'module/trackList.dart';

part 'module/user.dart';

part 'module/video.dart';

typedef Handler = Future<Answer> Function(Map query, String auth);

final handles = <String, Handler>{
  "/openScreen": openScreen,
  "/index": index,
  "/album/info": albumInfo,
  "/album/list": albumList,
  "/song/list": songList,
  "/song/info": songInfo,
  "/song/download": songDownload,
  "/artist/list": artistList,
  "/artist/info": artistInfo,
  "/artist/song": artistSong,
  "/artist/album": artistAlbum,
  "/search": search,
  "/search/sug": searchSug,
  "/bd/type": bdCategory,
  "/bd/list": bdList,
  "/tracklist/type": trackListCategory,
  "/tracklist/list": trackListList,
  "/tracklist/info": trackListInfo,
  "/sendSms": sendSms,
  "/login": login,
  "/logout": logout,
  "/account/info": accountInfo,
  "/account/info/change": changeAccountInfo,
  "/account/songlist": accountSongList,
  "/account/amount": accountAmount,
  "/account/purchase": accountPurchase,
  "/account/purchase/album": accountPurchaseAlbum,
  "/signin": userSignin,
  "/favorite": favorite,
  "/favorite/delete": favoriteDelete,
  "/favorite/list": favoriteList,
  "/video/list": videoList,
  "/video/info": videoInfo,
  "/video/recommend": videoRecommend,
  "/video/download": videoDownload,
};
