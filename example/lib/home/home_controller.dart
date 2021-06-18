import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/player/player_controller.dart';

class HomeController extends GetxController {
  final playerController = Get.put(PlayerController());
  MiGuRepository miguRepository;
  RxList<Map<String, dynamic>> banners = RxList<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    miguRepository = MiGuRepository();
    getBanner();
  }

  void getBanner() {
    miguRepository.banner().then((value) {
      banners.clear();
      banners.addAll(value['results']);
      if (banners.isNotEmpty) {
        playerController.appBgImageUrl.value = banners.first['picUrl'];
      }
    });
  }
}
