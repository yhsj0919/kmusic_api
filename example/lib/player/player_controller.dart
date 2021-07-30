
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/entity/song_entity.dart';
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

  RxList<SongEntity> playList = RxList();

  RxInt playIndex = RxInt(0);

  @override
  void onInit() {
    super.onInit();

    miguRepository = MiGuRepository();
    player.onErrorDo = (err) {
      err.player.stop();
      Get.snackbar("提示", "出错了,应该执行别的操作了", backgroundColor: Colors.red.withOpacity(0.2), maxWidth: 500, margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8), dismissDirection: SnackDismissDirection.HORIZONTAL);
    };

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

      if (duration.value > 500 && duration.value - position.value < 200) {
        next();
      }
    });
    player.current.listen((event) {
      if (event != null) {
        duration.value = event.audio.duration.inMilliseconds;
        songInfo.value = event.audio.audio.metas;
      }
    });
  }

  Future<void> play(SongEntity song) async {
    playList.addIf(!playList.contains(song), song);

    playIndex.value = playList.indexOf(song);

    await miguRepository?.playUrl(song.id ?? "").then((play) {
      if (play.code != "000000" && song.url == null || song.url?.startsWith("http://218.200.230.40:18089") == true) {
        showInfo(play.msg ?? "");
        playList.remove(song);
      } else {
        openFile(
          (play.url ?? song.url).toString().replaceAll("MP3_128_16_Stero", "MP3_320_16_Stero").replaceAll("ftp://218.200.160.122:21", "http://freetyst.nf.migu.cn"),
          play.name ?? song.name,
          (play.singer ?? song.singer)?.map((e) => e.name).join(","),
          play.album ?? song.album,
          play.img ?? song.img,
        );
      }
    }).catchError((error) {
      showInfo("$error");
    });
  }

  void playAll(List<SongEntity> songs) {
    playList.clear();
    playList.addAll(songs);
    play(playList[0]);
  }

  void next() {
    playIndex++;

    if (playIndex < playList.length) {
      play(playList[playIndex.value]);
    } else {
      showInfo("已经最后一首");
    }
  }

  void previous() {
    playIndex--;

    if (playIndex >= 0 && playIndex < playList.length) {
      play(playList[playIndex.value]);
    } else {
      showInfo("已经第一首");
    }
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
        showNotification: true,
        notificationSettings: NotificationSettings(customNextAction: (player) {
          next();
        }, customPlayPauseAction: (player) {
          player.playOrPause();
        }, customPrevAction: (player) {
          previous();
        }),
      );
    } catch (t) {
      player.stop();
      print(">>>>>>>>>>>>>>>>>>>>>>>>" + t.toString());

      initPlayer = false;
      //mp3 unreachable
    }
  }

  void showInfo(String msg) {
    Get.snackbar("提示", msg, backgroundColor: Colors.red.withOpacity(0.2), maxWidth: 500, margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8), dismissDirection: SnackDismissDirection.HORIZONTAL);
  }

  void playOrPause() {
    if (!initPlayer) {
      // openFile();
    } else {
      player.playOrPause();
    }
  }
}
