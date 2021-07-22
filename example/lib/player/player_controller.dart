import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlayerController extends GetxController {
  final player = AssetsAudioPlayer();
  var initPlayer = false;

  PanelController panelController = new PanelController();

  MiGuRepository? miguRepository;

  RxInt duration = RxInt(1);
  RxInt position = RxInt(0);
  Rx<PlayerState> playerState = Rx(PlayerState.stop);
  RxBool isBuffering = RxBool(false);
  Rx<Metas> songInfo = Rx(Metas());

  RxString appBgImageUrl = RxString('');
  RxDouble opacity = RxDouble(0);

  RxList<Map<String, dynamic>> playList = RxList();

  // RxInt playIndex = RxInt(-1);

  @override
  void onInit() {
    super.onInit();

    miguRepository = MiGuRepository();

    player.playerState.listen((event) {
      playerState.value = event;
    });
    player.isBuffering.listen((event) {
      isBuffering.value = event;
    });
    player.isPlaying.listen((event) {
      print("isPlaying:$event");
    });
    player.currentPosition.listen((event) {
      position.value = event.inMilliseconds;
    });
    player.current.listen((event) {
      if (event != null) {
        duration.value = event.audio.duration.inMilliseconds;
        songInfo.value = event.audio.audio.metas;
      }
    });
  }

  Future<void> play(song) async {
    playList.addIf(!playList.contains(song), song);
    await miguRepository?.playUrl(song['songId']).then((value) {
      printInfo(info: json.encode(value));
      if (value["code"] == "440000") {
        Get.snackbar(
          "提示",
          value["info"],
          backgroundColor: Colors.red.withOpacity(0.2),
          maxWidth: 500,
          margin: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
          dismissDirection: SnackDismissDirection.HORIZONTAL
        );
        return;
      }

      final play = value['data'];
      final playSong = value['data']["song"];
      openFile(
        (play["url"] ?? song['listenUrl']).toString().replaceAll("MP3_128_16_Stero", "MP3_320_16_Stero"),
        playSong["songName"],
        (playSong["singerList"] as List).map((e) => e["name"]).join(","),
        playSong == null ? "" : playSong["album"],
        "http://d.musicapp.migu.cn" + playSong["img1"],
      );
    });
  }

  Future<void> openFile(path, title, artist, album, image) async {
    initPlayer = true;
    try {
      await player.open(
          Audio.network(
            path,
            metas: Metas(
              title: title,
              artist: artist,
              album: album,
              image: MetasImage.network(image),
            ),
          ),
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
          showNotification: true);
    } catch (t) {
      initPlayer = false;
      //mp3 unreachable
    }
  }

  void playOrPause() {
    if (!initPlayer) {
      // openFile();
    } else {
      player.playOrPause();
    }
  }
}
