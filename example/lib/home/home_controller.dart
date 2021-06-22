import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/player/player_controller.dart';

class HomeController extends GetxController {
  final playerController = Get.put(PlayerController());
  MiGuRepository miguRepository;
  RxList<Map<String, dynamic>> banners = RxList<Map<String, dynamic>>();
  RxList<Map<String, dynamic>> playList = RxList<Map<String, dynamic>>();
  RxList<Map<String, dynamic>> albums = RxList<Map<String, dynamic>>();
  RxList<Map<String, dynamic>> songs = RxList<Map<String, dynamic>>();

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
    miguRepository.banner().then((value) {
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
    miguRepository.playListNewWeb().then((value) {
      playList.clear();

      var list = value['msg'] as List;

      playList.addAll(list.map((e) {
        return e as Map<String, dynamic>;
      }).toList());
    });
  }

  /**
   * 专辑
   */
  void getAlbum() {
    miguRepository.albumNewWeb().then((value) {
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
    miguRepository.songNewWeb().then((value) {
      songs.clear();

      var list = value['result']['results'] as List;

      songs.addAll(list.map((e) {
        return e['songData'] as Map<String, dynamic>;
      }).toList());
    });
  }

  Future<void> play(songId) async {
    await playerController.play(songId);
  }
}
