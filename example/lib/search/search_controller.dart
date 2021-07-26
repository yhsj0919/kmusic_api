import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/search/tab/tab_album_page.dart';
import 'package:kmusic_api_example/search/tab/tab_lyric_page.dart';
import 'package:kmusic_api_example/search/tab/tab_playlist_page.dart';
import 'package:kmusic_api_example/search/tab/tab_singer_page.dart';
import 'package:kmusic_api_example/search/tab/tab_song_page.dart';
import 'package:kmusic_api_example/search/tab/tab_video_page.dart';

class SearchController extends GetxController {
  final migu = MiGuRepository();

  final TabSongController _songController = Get.put(TabSongController());
  final TabAlbumController _albumController = Get.put(TabAlbumController());
  final TabVideoController _videoController = Get.put(TabVideoController());
  final TabPlayListController _playlistController = Get.put(TabPlayListController());
  final TabLyricController _lyricController = Get.put(TabLyricController());
  final TabSingerController _singerController = Get.put(TabSingerController());

  final RxList hotwords = RxList();
  final RxList discovery = RxList();

  final RxBool showResult = false.obs;

  @override
  void onInit() {
    super.onInit();
    searchHotWord();
  }

  //搜索热词
  void searchHotWord() {
    migu.searchHotWord().then((value) {
      hotwords.addAll(value["data"]["hotwords"][0]["hotwordList"] as List);
      discovery.addAll(value["data"]["discovery"] as List);
    });
  }

  //搜索建议
  Future<Iterable<dynamic>> searchSuggest(String keyword) {
    return migu.searchSuggest(keyword).then((value) {
      if (value["code"] == "000000") {
        return Future.value(value["data"]);
      } else {
        return Future.error("请求失败");
      }
    });
  }

  //搜索
  void search(String keyword, {int type = 0}) {
    if (keyword.isNotEmpty) {
      showResult.value = true;
      _songController.search(keyword: keyword);
      _albumController.search(keyword: keyword);
      _videoController.search(keyword: keyword);
      _playlistController.search(keyword: keyword);
      _lyricController.search(keyword: keyword);
      _singerController.search(keyword: keyword);
    } else {}
  }
}
