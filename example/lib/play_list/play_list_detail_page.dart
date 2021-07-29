import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/entity/play_list_entity.dart';
import 'package:kmusic_api_example/play_list/play_list_controller.dart';
import 'package:kmusic_api_example/player/player_page.dart';
import 'package:kmusic_api_example/widget/app_appbar.dart';
import 'package:kmusic_api_example/widget/app_image.dart';
import 'package:kmusic_api_example/widget/header_delegate.dart';
import 'package:kmusic_api_example/widget/music_widget.dart';

class PlayListDetailPage extends StatelessWidget {
  PlayListDetailPage({Key? key}) : super(key: key);
  final PlayListController _controller = Get.put(PlayListController());

  final PlayListEntity playList = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return PlayerPage(
      imageUrl: RxString(playList.img ?? ""),
      appBar: AppAppBar(
        title: Text(
          "${playList.name}",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: NestedScrollView(
          // physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _playListHeader(),
              _playBar(),
            ];
          },
          body: _songList(),
        ),
      ),
    );
  }

  Widget _playListHeader() {
    return SliverPersistentHeader(
      delegate: HeaderDelegate(
        minHeight: 140,
        maxHeight: 140,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Hero(
                tag: playList.img ?? "",
                child: AppImage(
                  url: playList.img ?? "",
                  radius: 10,
                  width: 100,
                  height: 100,
                  animationDuration: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _playBar() {
    return SliverPersistentHeader(
      // 可以吸顶的TabBar
      pinned: true,
      delegate: HeaderDelegate(
        minHeight: 60,
        maxHeight: 60,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    _controller.playAll(_controller.songs);
                  },
                  icon: Icon(Icons.play_circle_fill),
                  label: Text("播放全部")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songList() {
    return Container(
      color: Colors.white,
      child: _controller.obx(
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
      ),
    );
  }
}
