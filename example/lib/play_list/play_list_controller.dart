import 'dart:convert';

import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/player/player_controller.dart';

class PlayListController extends GetxController {
  final playerController = Get.put(PlayerController());
  MiGuRepository? miguRepository;
  RxList<Map<String, dynamic>> songs = RxList<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    miguRepository = MiGuRepository();
  }

  @override
  void onReady() {
    super.onReady();
    getSong(Get.arguments["playlistId"]);
  }

  /**
   * 获取歌单歌曲
   */
  void getSong(String id) {
    miguRepository?.playListSong(id: id).then((value) {
      printInfo(info: json.encode(value));

      songs.clear();

      var list = value['data']['songList'] as List;

      songs.addAll(list.map((e) {
        return e as Map<String, dynamic>;
      }).toList());
    });
  }

  Future<void> play(songId) async {
    await playerController.play(songId);
  }
}
