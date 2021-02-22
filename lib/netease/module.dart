import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math' as math;
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import '../utils/answer.dart';
import 'util/net_request.dart';
import '../utils/utils.dart';

part 'module/album.dart';
part 'module/artist.dart';
part 'module/banner.dart';
part 'module/batch.dart';
part 'module/calendar.dart';
part 'module/captcha.dart';
part 'module/check_music.dart';
part 'module/comment.dart';
part 'module/countries.dart';
part 'module/daily_signin.dart';
part 'module/digitalAlbum.dart';
part 'module/dj.dart';
part 'module/event.dart';
part 'module/fm.dart';
part 'module/history.dart';
part 'module/homepage.dart';
part 'module/hot.dart';
part 'module/like.dart';
part 'module/login.dart';
part 'module/lyric.dart';
part 'module/msg.dart';
part 'module/mv.dart';
part 'module/personal.dart';
part 'module/playlist.dart';
part 'module/playmode.dart';
part 'module/recommend.dart';
part 'module/register.dart';
part 'module/related.dart';
part 'module/resource_like.dart';
part 'module/scrobble.dart';
part 'module/search.dart';
part 'module/send.dart';
part 'module/setting.dart';
part 'module/share.dart';
part 'module/simi.dart';
part 'module/song.dart';
part 'module/top.dart';
part 'module/user.dart';
part 'module/video.dart';
part 'module/weblog.dart';
part 'module/yunbei.dart';

typedef Handler = Future<Answer> Function(Map query, List<Cookie> cookie);

final handles = <String, Handler>{
  //专辑
  "/album": album,
  "/album/detail/dynamic": albumDetailDynamic,
  "/album/detail": albumDetail,
  "/album/style": albumStyle,
  "/album/list": albumList,
  "/album/new": albumNewest,
  "/album/newest": albumNewest,
  "/album/songsaleboard": albumSongSaleBoard,
  "/album/sub": albumSub,
  "/album/sublist": albumSublist,
  //歌手
  "/artist/album": artistAlbum,
  "/artist/desc": artistDesc,
  "/artist/detail": artistDetail,
  "/artist/list": artistList,
  "/artist/mv": artistMv,
  "/artist/new/mv": artistNewMv,
  "/artist/new/song": artistNewSong,
  "/artist/songs": artistSongs,
  "/artist/sub": artistSub,
  "/artist/sublist": artistSubList,
  "/artist/top/song": artistTopSong,
  "/artists": artists,
  //Banner
  "/banner": banner,
  // 批量请求接口
  "/batch": batch,
  //音乐日历
  "/calendar": calendar,
  //验证码
  "/captcha/send": captchaSend,
  "/captcha/verify": captchaVerify,
  //音乐是否可用
  "check/music": checkMusic,
  //评论
  "/comment/album": commentAlbum,
  "/comment/dj": commentDj,
  "/comment/events": commentEvents,
  "/comment/floor": commentFloor,
  "/comment/hot": commentHot,
  "/comment/hug/list": commentHugList,
  "/comment/hug": commentHugListener,
  "/comment/like": commentLike,
  "/comment/music": commentMusic,
  "/comment/mv": commentMv,
  "/comment/playlist": commentPlaylist,
  "/comment/video": commentVideo,
  "/comment/new": commentNew,
  "/comment": comment,
  //签到
  "/daily_signin": dailySignin,
  //数字专辑
  "/digitalAlbum/ordering": digitalAlbumOrdering,
  "/digitalAlbum/purchased": digitalAlbumPurchased,
  //电台
  "/dj/banner": djBanner,
  "/dj/category/excludehot": djCategoryExcludehot,
  "/dj/category/recommend": djCategoryRecommend,
  "/dj/catelist": djCatelist,
  "/dj/detail": djDetail,
  "/dj/hot": djHot,
  "/dj/paygift": djPaygift,
  "/dj/personalize/recommend": djPersonalizeRcmd,
  "/dj/program/detail": djProgramDetail,
  "/dj/program/toplist/hours": djProgramToplistHours,
  "/dj/program/toplist": djProgramToplist,
  "/dj/program": djProgram,
  "/dj/radio/hot": djRadioHot,
  "/dj/recommend/type": djRecommendType,
  "/dj/recommend": djRecommend,
  "/dj/sub": djSub,
  "/dj/sublist": djSublist,
  "/dj/subscriber": djSubscriber,
  "/dj/today/perfered": djTodayPerfered,
  "/dj/toplist/hours": djToplistHours,
  "/dj/toplist/newcomer": djToplistNewcomer,
  "/dj/toplist/pay": djToplistPay,
  "/dj/toplist/popular": djToplistPopular,
  "/dj/toplist": djToplist,
  //动态
  "/event/del": eventDel,
  "/event/forward": eventForward,
  "/event": event,
  //垃圾桶
  "/fm_trash": fmTrash,
  //历史日推
  "/history/recommend/songs/detail": historyRecommendSongsDetail,
  "/history/recommend/songs": historyRecommendSongs,
  //首页
  "/homepage/block/page": homepageBlockPage,
  "/homepage/dragon/ball": homepageDragonBall,
  //热门话题
  "/hot/topic": hotTopic,
  //喜欢音乐
  "/like": like,
  "/likelist": likelist,
  //登录
  "/login/cellphone": loginCellphone,
  "/login/qr/check": loginQrCheck,
  "/login/qr/create": loginQrCreate,
  "/login/qr/key": loginQrKey,
  "/login/refresh": loginRefresh,
  "/login/status": loginStatus,
  "/login": login,
  "/logout": logout,
  "/cellphone/existence/check": cellphoneExistenceCheck,
  "/activate/init/profile": activateInitProfile,
  //歌词
  "/lyric": lyric,
  //通知消息
  "/msg/comment": msgComment,
  "/msg/forwards": msgForwards,
  "/msg/notice": msgNotice,
  "/msg/private/history": msgPrivateHistory,
  "/msg/private": msgPrivate,
  "/msg/recentcontact": msgRecentcontact,
  //MV
  "/mv/all": mvAll,
  "/mv/detail/info": mvDetailInfo,
  "/mv/detail": mvDetail,
  "/mv/exclusive/rcmd": mvExclusiveRcmd,
  "/mv/first": mvFirst,
  "/mv/sub": mvSub,
  "/mv/sublist": mvSublist,
  "/mv/url": mvUrl,
  //电台
  "/personal_fm": personalFm,
  "/personalized/djprogram": personalizedDjprogram,
  "/personalized/mv": personalizedMv,
  "/personalized/newsong": personalizedNewsong,
  "/personalized/privatecontent/list": personalizedPrivatecontentList,
  "/personalized/privatecontent": personalizedPrivatecontent,
  "/personalized": personalized,

  //歌单
  "/playlist/catlist": playlistCatlist,
  "/playlist/create": playlistCreate,
  "/playlist/delete": playlistDelete,
  "/playlist/desc/update": playlistDescUpdate,
  "/playlist/detail/dynamic": playlistDetailDynamic,
  "/playlist/detail": playlistDetail,
  "/playlist/highquality/tags": playlistHighqualityTags,
  "/playlist/hot": playlistHot,
  "/playlist/mylike": playlistMyLike,
  "/playlist/name/update": playlistNameUpdate,
  "/playlist/order/update": playlistOrderUpdate,
  "/playlist/subscribe": playlistSubscribe,
  "/playlist/subscribers": playlistSubscribers,
  "/playlist/tags/update": playlistTagsUpdate,
  "/playlist/track/add": playlistTrackAdd,
  "/playlist/track/delete": playlistTrackDelete,
  "/playlist/tracks": playlistTracks,
  "/playlist/update": playlistUpdate,
  "/playlist/video/recent": playlisVideoRecent,
  //心动模式/智能播放
  "/playmode/intelligence/list": playmodeIntelligenceList,
  //推荐
  "/program/recommend": programRecommend,
  "/recommend/resource": recommendResource,
  "/recommend/songs": recommendSongs,
  //注册(修改密码)
  "/register/cellphone": registerCellphone,
  //相关
  "/related/allvideo": relatedAllvideo,
  "/related/playlist": relatedPlaylist,
  //资源点赞( MV,电台,视频)
  "/resource/like": resourceLike,
  "/scrobble": scrobble,
  //搜索
  "/search/default": searchDefaultkeyword,
  "/search/hot/detail": searchHotDetail,
  "/search/hot": searchHot,
  "/search/multimatch": searchMultimatch,
  "/search/suggest": searchSuggest,
  "/search": search,
  "/cloudSearch": cloudSearch,
  //私信
  "send/playlist": sendPlaylist,
  "send/song": sendSong,
  "send/text": sendText,
  //设置
  "setting": setting,
  //分享
  "/share/resource": shareResource,
  //相似
  "/simi/artist": simiArtist,
  "/simi/mv": simiMv,
  "/simi/playlist": simiPlaylist,
  "/simi/song": simiSong,
  "/simi/user": simiUser,
  //歌曲
  "/song/detail": songDetail,
  "/song/order/update": songOrderUpdate,
  "/song/url": songUrl,
  //热门
  "/top/album": topAlbum,
  "/top/artists": topArtists,
  "/top/list": topList,
  "/top/mv": topMv,
  "/top/playlist/highquality": topPlaylistHighquality,
  "/top/playlist": topPlaylist,
  "/top/song": topSong,
  //话题
  "/topic/detail/event/hot": topicDetailEventHot,
  "/topic/detail": topicDetail,
  "/topic/sublist": topicSubList,
  //榜单
  "/toplist/artist": toplistArtist,
  "/toplist/detail": toplistDetail,
  "/toplist": toplist,
  //用户
  "/user/account": userAccount,
  "/user/audio": userAudio,
  "/user/binding": userBinding,
  "/user/cloud/del": userCloudDel,
  "/user/cloud/detail": userCloudDetail,
  "/user/cloud": userCloud,
  "/user/detail": userDetail,
  "/user/dj": userDj,
  "/user/event": userEvent,
  "/follow": userFollow,
  "/user/followeds": userFolloweds,
  "/user/follows": userFollows,
  "/user/level": userLevel,
  "/user/playlist": userPlaylist,
  "/user/record": userRecord,
  "/user/replacephone": userReplaceCellphone,
  "/user/subcount": userSubcount,
  "/user/update": userUpdate,
  //视频
  "/video/detail/info": videoDetailInfo,
  "/video/detail": videoDetail,
  "/video/group/list": videoGroupList,
  "/video/group": videoGroup,
  "/video/sub": videoSub,
  "/video/timeline/all": videoTimelineAll,
  "/video/timeline/recommend": videoTimelineRecommend,
  "/video/url": videoUrl,

  "/weblog": weblog,
  //云贝
  "/yunbei/tasks/expense": yunbeiExpense,
  "/yunbei/info": yunbeiInfo,
  "/yunbei/tasks/receipt": yunbeiReceipt,
  "/yunbei/sign": yunbeiSign,
  "/yunbei/task/finish": yunbeiTaskFinish,
  "/yunbei/tasks/todo": yunbeiTaskTodo,
  "/yunbei/tasks": yunbeiTask,
  "/yunbei/today": yunbeiToday,
  "/yunbei": yunbei,
};
