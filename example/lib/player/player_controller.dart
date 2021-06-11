import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';

class PlayerController extends GetxController {
  final player = AssetsAudioPlayer();
  var initPlayer = false;

  RxInt duration = RxInt(1);
  RxInt position = RxInt(0);
  Rx<PlayerState> playerState = Rx(PlayerState.stop);
  RxBool isBuffering = RxBool(false);
  Rx<Metas> songInfo = Rx(Metas());

  @override
  void onInit() {
    super.onInit();
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

  Future<void> openFile() async {
    initPlayer = true;
    try {
      await player.open(
          Audio.network(
            "http://freetyst.nf.migu.cn/public/product9th/product41/2020/09/0817/2015%E5%B9%B410%E6%9C%8814%E6%97%A515%E7%82%B905%E5%88%86%E5%86%85%E5%AE%B9%E5%87%86%E5%85%A5SONY999%E9%A6%96/%E6%A0%87%E6%B8%85%E9%AB%98%E6%B8%85/MP3_320_16_Stero/6005970EYGK174553.mp3?channelid=03&k=04aeb50690d824e4&t=1623224972&msisdn=b83a5578-b62b-4365-975f-840b42c29413",
            metas: Metas(
              title: "Swagger",
              artist: "Angie Johnson",
              album: "Sing For You",
              image: MetasImage.network(
                  "http://d.musicapp.migu.cn/prod/file-service/file-down/8121e8df41a5c12f48b69aea89b71dab/c6ac1a8cc5242f77cae0f06302aa6430/3f09149f95923cfd31f9b558bb48c74d"), //can be MetasImage.network
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
      openFile();
    } else {
      player.playOrPause();
    }
  }
}
