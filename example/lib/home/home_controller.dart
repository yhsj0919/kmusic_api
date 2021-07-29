import 'dart:convert';

import 'package:get/get.dart';
import 'package:kmusic_api_example/entity/play_list_entity.dart';
import 'package:kmusic_api_example/entity/song_entity.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/player/player_controller.dart';

class HomeController extends GetxController {
  final playerController = Get.put(PlayerController());
  MiGuRepository? miguRepository;
  RxList<Map<String, dynamic>> banners = RxList<Map<String, dynamic>>();
  RxList<PlayListEntity> playList = RxList();
  RxList<Map<String, dynamic>> albums = RxList<Map<String, dynamic>>();
  RxList<SongEntity> songs = RxList();

  @override
  void onInit() {
    super.onInit();
    miguRepository = MiGuRepository();
    getBanner();
    getPlayList();
    getAlbum();
    getSong();
  }

  /**
   * Banner
   */
  void getBanner() {
    miguRepository?.banner().then((value) {
      banners.clear();
      banners.addAll(value['results']);
      if (banners.isNotEmpty) {
        playerController.appBgImageUrl.value = banners.first['picUrl'];
      }
    });
  }

  /**
   * 歌单推荐
   */
  void getPlayList() {
    miguRepository?.playListNewWeb().then((value) {
      printInfo(info: json.encode(value));

      playList.clear();

      playList.addAll(value);
    });
  }

  /**
   * 专辑
   */
  void getAlbum() {
    miguRepository?.albumNewWeb().then((value) {
      albums.clear();

      var list = value['result']['results'] as List;

      albums.addAll(list.map((e) {
        return e['albumData'] as Map<String, dynamic>;
      }).toList());
    });
  }

  /**
   * 新歌
   */
  void getSong() {
    miguRepository?.songNewWeb().then((value) {
      songs.clear();
      songs.addAll(value);
    });
  }

  Future<void> play(SongEntity song) async {
    await playerController.play(song);
  }
}
