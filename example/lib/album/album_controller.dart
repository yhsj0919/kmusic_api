import 'package:get/get.dart';
import 'package:kmusic_api_example/entity/album_entity.dart';
import 'package:kmusic_api_example/entity/song_entity.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/player/player_controller.dart';

class AlbumController extends GetxController with StateMixin<dynamic> {
  int pageSize = 50;
  final playerController = Get.put(PlayerController());
  MiGuRepository? miguRepository;
  RxList<SongEntity> songs = RxList();
  final AlbumEntity album = Get.arguments;

  Rx<AlbumEntity> detail = Rx(AlbumEntity());

  @override
  void onInit() {
    super.onInit();
    miguRepository = MiGuRepository();
  }

  @override
  void onReady() {
    super.onReady();
    getSongList(album.id!, album.type ?? "2003", 1);
    getInfo(album.id!, album.type ?? "2003");
  }

  /**
   * 获取歌单歌曲
   */
  void getSongList(String id, String type, int pageNo) {
    if (pageNo == 1) {
      change([], status: RxStatus.loading());
    }
    (pageNo == 1
            ? miguRepository?.albumSong(albumId: id, type: type, pageNo: pageNo, pageSize: pageSize)
            : miguRepository?.albumSong2(albumId: id, type: type, pageNo: pageNo, pageSize: pageSize))
        ?.then((value) {
      if (pageNo == 1) {
        songs.clear();
      }
      songs.addAll(value);
      change(songs, status: RxStatus.success());
      if (songs.length < (int.tryParse(detail.value.musicNum ?? "0") ?? 0)) {
        getSongList(id, type, ++pageNo);
      }
    });
  }

  /**
   * 获取歌单详情
   */
  void getInfo(String id, String type) {
    miguRepository?.albumInfo(albumId: id, type: type).then((value) {
      detail.value = value;
    });
  }

  Future<void> play(SongEntity song) async {
    await playerController.play(song);
  }

  void playAll(List<SongEntity> songs) {
    playerController.playAll(songs);
  }
}
