import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/entity/singer_entity.dart';
import 'package:kmusic_api_example/entity/song_entity.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/player/player_controller.dart';
import 'package:kmusic_api_example/utils/utils.dart';
import 'package:kmusic_api_example/widget/music_widget.dart';
import 'package:kmusic_api_example/widget/page_list_view.dart';

class TabSongPage extends StatelessWidget {
  TabSongPage({Key? key}) : super(key: key);
  final TabSongController _controller = Get.put(TabSongController());
  final playerController = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((List<SongEntity>? datas) {
      return PageListView(
        padding: EdgeInsets.only(bottom: 70),
        totalPage: _controller.totalPage.value,
        thisPage: _controller.thisPage.value,
        itemCount: datas?.length ?? 0,
        itemBuilder: (context, index) {
          return songItem(
            onTap: () {
              playerController.play(datas![index]);
            },
            img: datas?[index].img,
            title: datas?[index].name,
            subtitle: datas?[index].singer?.map((e) => e.name).join(","),
          );
        },
        onRefresh: (int index) {
          return _controller.search();
        },
        onLoadMore: (index) {
          printInfo(info: "加载更多$index");
          return _controller.search(page: index);
        },
      );
    });
  }
}

class TabSongController extends GetxController with StateMixin<List<SongEntity>> {
  final migu = MiGuRepository();
  String _keyword = "";

  List<SongEntity> datas = [];
  RxInt totalPage = RxInt(0);
  RxInt thisPage = RxInt(0);

  //搜索
  Future<void> search({String keyword: "", int type = 0, int page = 1, int size = 20}) async {
    if (keyword.isNotEmpty) {
      _keyword = keyword;
    }
    if (page == 1) {
      change(<SongEntity>[], status: RxStatus.loading());
    }
    if (_keyword.isNotEmpty) {
      return migu.search(_keyword, type: type, page: page, size: size).then((value) {
        // printInfo(info: json.encode(value));
        thisPage.value++;
        if (page == 1) {
          datas.clear();
          thisPage.value = 1;
        }
        totalPage.value = getPage(int.tryParse(value?["songResultData"]?["totalCount"]) ?? 0, size);

        var list = value['songResultData']['result'] as List;

        datas.addAll(list.map((e) {
          return SongEntity(
            id: e["songId"],
            name: e["songName"],
            img: (e["imgItems"] as List?)?.first?["img"],
            album: e["album"],
            albumId: e["albumId"],
            singer: (e["artists"] as List?)?.map((e) => SingerEntity(id: e["id"], name: e["name"])).toList(),
            lrc: e["lrcUrl"],
          );
        }).toList());

        change(datas, status: RxStatus.success());
      });
    } else {
      return Future.value();
    }
  }
}
