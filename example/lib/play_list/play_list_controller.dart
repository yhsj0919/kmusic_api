import 'package:get/get.dart';
import 'package:kmusic_api_example/entity/play_list_entity.dart';
import 'package:kmusic_api_example/entity/song_entity.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/player/player_controller.dart';

class PlayListController extends GetxController with StateMixin<dynamic> {
  int pageSize = 50;

  final playerController = Get.put(PlayerController());
  MiGuRepository? miguRepository;
  RxList<SongEntity> songs = RxList();
  final PlayListEntity playList = Get.arguments;

  Rx<PlayListEntity> detail = Rx(PlayListEntity());

  @override
  void onInit() {
    super.onInit();
    miguRepository = MiGuRepository();
  }

  @override
  void onReady() {
    super.onReady();

    getInfo(playList.id!, playList.type);
  }

  /**
   * 获取歌单歌曲
   */
  void getSongList(String id, int pageNo) {
    if (pageNo == 1) {
      change([], status: RxStatus.loading());
    }
    miguRepository?.playListSong(id: id, pageNo: pageNo, pageSize: pageSize).then((value) {
      if (pageNo == 1) {
        songs.clear();
      }
      songs.addAll(value);
      change(songs, status: RxStatus.success());
      if (songs.length < (int.tryParse(detail.value.musicNum ?? "0") ?? 0)) {
        getSongList(id, ++pageNo);
      }
    });
  }

  /**
   * 获取歌单详情
   */
  void getInfo(String id, String? type) {
    miguRepository?.playListInfo(id: id, type: type).then((value) {
      detail.value = value;
      getSongList(playList.id!, 1);
    });
  }

  Future<void> play(SongEntity song) async {
    await playerController.play(song);
  }

  void playAll(List<SongEntity> songs) {
    playerController.playAll(songs);
  }
}
