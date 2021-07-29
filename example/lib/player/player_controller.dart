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

  // RxInt playIndex = RxInt(-1);

  @override
  void onInit() {
    super.onInit();

    miguRepository = MiGuRepository();
    player.onErrorDo = (err) {
      Get.snackbar("提示", "出错了,应该执行别的操作了",
          backgroundColor: Colors.red.withOpacity(0.2),
          maxWidth: 500,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          dismissDirection: SnackDismissDirection.HORIZONTAL);
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

      printInfo(info: "${position.value} == ${duration.value}");

      if (duration.value > 500 && duration.value - position.value < 200) {
        Get.snackbar("提示", "应该播放下一首",
            backgroundColor: Colors.red.withOpacity(0.2),
            maxWidth: 500,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            dismissDirection: SnackDismissDirection.HORIZONTAL);
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
    await miguRepository?.playUrl(song.id ?? "").then((play) {
      if (play.code != "000000" && song.url == null) {
        Get.snackbar("提示", play.msg ?? "",
            backgroundColor: Colors.red.withOpacity(0.2),
            maxWidth: 500,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            dismissDirection: SnackDismissDirection.HORIZONTAL);
      } else {
        openFile(
          (play.url ?? song.url).toString().replaceAll("MP3_128_16_Stero", "MP3_320_16_Stero"),
          play.name ?? song.name,
          (play.singer ?? song.singer)?.map((e) => e.name).join(","),
          play.album ?? song.album,
          play.img ?? song.img,
        );
      }
    }).catchError((error) {
      Get.snackbar("提示", "$error",
          backgroundColor: Colors.red.withOpacity(0.2),
          maxWidth: 500,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          dismissDirection: SnackDismissDirection.HORIZONTAL);
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
        showNotification: true,
        notificationSettings: NotificationSettings(
          customNextAction: (player) {
            Get.snackbar("提示", "通知栏下一首",
                backgroundColor: Colors.red.withOpacity(0.2),
                maxWidth: 500,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                dismissDirection: SnackDismissDirection.HORIZONTAL);
          },
          customPlayPauseAction: (player) {
            player.playOrPause();
            Get.snackbar("提示", "通知栏播放,暂停",
                backgroundColor: Colors.red.withOpacity(0.2),
                maxWidth: 500,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                dismissDirection: SnackDismissDirection.HORIZONTAL);
          },
        ),
      );
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
