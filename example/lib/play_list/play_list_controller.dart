import 'package:get/get.dart';
import 'package:kmusic_api_example/entity/play_list_entity.dart';
import 'package:kmusic_api_example/entity/song_entity.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/player/player_controller.dart';

class PlayListController extends GetxController with StateMixin<dynamic> {
  final playerController = Get.put(PlayerController());
  MiGuRepository? miguRepository;
  RxList<SongEntity> songs = RxList();
  final PlayListEntity playList = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    miguRepository = MiGuRepository();
  }

  @override
  void onReady() {
    super.onReady();
    getSong(playList.id!);
  }

  /**
   * 获取歌单歌曲
   */
  void getSong(String id) {
    change([], status: RxStatus.loading());
    miguRepository?.playListSong(id: id).then((value) {
      songs.clear();
      songs.addAll(value);
      change(songs, status: RxStatus.success());
    });
  }

  Future<void> play(SongEntity song) async {
    await playerController.play(song);
  }
}
