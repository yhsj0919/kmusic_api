
import 'package:get/get.dart';
import 'package:kmusic_api_example/entity/album_entity.dart';
import 'package:kmusic_api_example/entity/song_entity.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/player/player_controller.dart';

class AlbumController extends GetxController with StateMixin<dynamic> {
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
    getSongList(album.id!);
    getInfo(album.id!);
  }

  /**
   * 获取歌单歌曲
   */
  void getSongList(String id) {
    change([], status: RxStatus.loading());
    miguRepository?.albumSong(albumId: id).then((value) {
      songs.clear();
      songs.addAll(value);
      change(songs, status: RxStatus.success());
    });
  }

  /**
   * 获取歌单详情
   */
  void getInfo(String id) {
    miguRepository?.albumInfo(albumId: id).then((value) {
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
