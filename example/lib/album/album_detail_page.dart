import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/entity/album_entity.dart';
import 'package:kmusic_api_example/widget/music_list_detail_page.dart';
import 'package:kmusic_api_example/widget/music_widget.dart';

import 'album_controller.dart';

class AlbumDetailPage extends StatelessWidget {
  AlbumDetailPage({Key? key}) : super(key: key);
  final AlbumController _controller = Get.put(AlbumController());
  final AlbumEntity playList = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return MusicListDetailPage(
        img: playList.img ?? "",
        title: "专辑",
        name: "${playList.name}",
        playBar: _playBar(),
        headWidget: [
          Container(height: 4),
          Row(
            children: [
              Icon(Icons.person, size: 14, color: Colors.black87),
              Container(width: 4),
              Obx(() => Text(
                    "${_controller.detail.value.singer?.map((e) => e.name).join(",") ?? ""}",
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          ),
          Spacer(),
          Obx(() => Text(
                "${_controller.detail.value.desc ?? ""}",
                style: TextStyle(color: Colors.black54, fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
        ],
        body: _controller.obx(
          (datas) => ListView.builder(
              padding: EdgeInsets.only(bottom: 70),
              physics: BouncingScrollPhysics(),
              itemCount: _controller.songs.length,
              itemBuilder: (_, index) => songItem(
                    onTap: () {
                      _controller.play(_controller.songs[index]);
                    },
                    img: "http://d.musicapp.migu.cn${_controller.songs[index].img}",
                    title: _controller.songs[index].name,
                    subtitle: _controller.songs[index].singer?.map((e) => e.name).join(","),
                  )),
        ));
  }

  Widget _playBar() {
    return Row(
      children: [
        TextButton.icon(
            onPressed: () {
              _controller.playAll(_controller.songs);
            },
            icon: Icon(Icons.play_circle_fill),
            label: Row(
              children: [
                Text(
                  "播放全部",
                  style: TextStyle(fontSize: 16),
                ),
                Container(width: 4),
                Obx(() => Text(
                      "(${_controller.songs.length})",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ))
              ],
            ))
      ],
    );
  }
}
